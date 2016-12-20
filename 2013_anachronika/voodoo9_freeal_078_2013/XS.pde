class XMLZong extends VZong{
  XMLElement xmlsong;
  //ZongSettings settings;
  XMLElement patterns;
  XMLElement tonepatterns;
  XMLElement compose;


  String file;
  boolean songloaded = false;
  //boolean rocking = false;

  float a, b, prevol;

  int notes2search;
  int note, pitx, vol, dur;

  //String[][] 

  XMLZong(String $1){
    lyrics = new String[1024][16];
    file = $1;
    loadSong();
  }
  void loadSong(){
    try{
      xmlsong = new XMLElement(p, file);
      parseSong();
      songloaded = true;
      vplayer.println("song "+name+" loaded!");
    }
    catch(Exception ide){
      vplayer.println(ide+" File "+file+" does not exist");
      songloaded = false;
    }
  }

  

  void parseSong(){
    //score.empty();
    name = xmlsong.getStringAttribute("name");
    settings = new ZongSettings(xmlsong.getChild(0));
    patterns = xmlsong.getChild(1);
    tonepatterns = xmlsong.getChild(2);
    compose = xmlsong.getChild(3);

    drumstrack = new promidi.Track("drums", drumsout);
    basstrack = new promidi.Track("bass", bassout);
    guitartrack = new promidi.Track("guitar", guitarout);

    drumstrack.setQuantization(Q._1_16);
    basstrack.setQuantization(Q._1_16);
    guitartrack.setQuantization(Q._1_16);
    
    drumsout.sendController(new Controller(0,1)); 
    drumsout.sendProgramChange(new ProgramChange(settings.bassinstrument)); 
    
    //drumsout.sendController(new Controller(7,0)); volume
    //bassout.sendController(new Controller(7,0)); volume
    
    //bassout.sendProgramChange(new ProgramChange(settings.bassinstrument)); 
    guitarout.sendProgramChange(new ProgramChange(settings.guitarinstrument)); 

    int quantization = 16;
    int position = 0;

    int chan = 0;

beatMap = new BeatMap();

    for(int i=0; i<compose.getChildCount();i++){//recorre las partes
      for(int j =0; j<compose.getChild(i).getChildCount();j++){//y luego los patterns
        for(int k =0; k<compose.getChild(i).getChild(j).getChildCount();k++){//y luego los patterns dentro
          switch(compose.getChild(i).getChild(j).getChild(k).getIntAttribute("kind")){

          case 0:
            a = float(settings.mainlevel)/127;
            b = float(settings.drumlevel)/127;
            prevol = a*b;

            int drum2search = int(compose.getChild(i).getChild(j).getChild(k).getContent());

            for(int pad=0; pad<patterns.getChild(0).getChild(drum2search).getChildCount(); pad++){
              int padinstrument = patterns.getChild(0).getChild(drum2search).getChild(pad).getIntAttribute("id");
              String pttrn = patterns.getChild(0).getChild(drum2search).getChild(pad).getContent();
              for(int m=0; m<pttrn.length(); m++){
                String hxtep = pttrn.substring(m,m+1);
                try{
                  int vol = int(prevol*127*unhex(hxtep)/15);
                  //score.addNote(float(position+m)/4, 9, 0, padinstrument, 100, 0.25, 0.8, 64);//random(127));//80);
                  drumstrack.addEvent(new Note(padinstrument, vol, 80), position+m); 
                  drumstrack.addEvent(new Note(padinstrument, 0, 0), position+m+4);
                  
                  dobeat(position+m, padinstrument);
                }
                catch(Exception e){//NullPointerException
                  //vplayer.println("crashed by "+e);
                }
              }
            }
            break;
          case 1:
            a = float(settings.mainlevel)/127;
            b = float(settings.basslevel)/127;
            prevol = a*b;

            notes2search  = int(compose.getChild(i).getChild(j).getChild(k).getChild(0).getContent());
            int[] bassnotes = int(split(tonepatterns.getChild(notes2search).getContent(), ","));
            int bass2search = int(compose.getChild(i).getChild(j).getChild(k).getChild(1).getContent());

            for(int pad=0; pad<patterns.getChild(1).getChild(bass2search).getChildCount(); pad++){
              String pttrn = patterns.getChild(1).getChild(bass2search).getChild(pad).getContent();
              for(int m=0; m<pttrn.length(); m++){
                String hxtep = pttrn.substring(m,m+1);
                try{
                  note = 24+bassnotes[m];
                  int postpos = 3;                  
                  if(hxtep.equals("X")){
                    hxtep="0";
                    postpos = 3*3*8*2;
                  } 
                  pitx = note+unhex(hxtep);
                  vol = int(prevol*127);
                  
                  //score.addNote(float(position+m)/4, chan, settings.bassinstrument, pitx, vol, 0.25, 0.8, 64);//random(127));//80);
                  basstrack.addEvent(new Note(pitx, vol, dur), position+m);
                  basstrack.addEvent(new Note(pitx, 0, 0), position+m+postpos);
                  
                }
                catch(Exception e){//NullPointerException
                  //vplayer.println("crashed by "+e);
                }
                //score.addCallback(i/4, 0);
               }
            }
            break;

          case 2:
            a = float(settings.mainlevel)/127;
            b = float(settings.guitarlevel)/127;
            prevol = a*b;

            notes2search  = int(compose.getChild(i).getChild(j).getChild(k).getChild(0).getContent());
            int[] guitarnotes = int(split(tonepatterns.getChild(notes2search).getContent(), ","));
            int guitar2search = int(compose.getChild(i).getChild(j).getChild(k).getChild(1).getContent());

            for(int pad=0; pad<patterns.getChild(2).getChild(guitar2search).getChildCount(); pad++){
              String pttrn = patterns.getChild(2).getChild(guitar2search).getChild(pad).getContent();
              for(int m=0; m<pttrn.length(); m++){
                String hxtep = pttrn.substring(m,m+1);
                try{
                  note = 48+guitarnotes[m];
                  pitx = note+unhex(hxtep);
                  vol = int(prevol*127);
                  dur = 800;//0;
                  //score.addNote(float(position+m)/4, chan, settings.guitarinstrument, pitx, vol, 0.25*8, 0.8, 64);//random(127));//80);
                  guitartrack.addEvent(new Note(pitx, vol, dur), position+m);
                  //guitartrack.removeEvent(new Note(pitx, vol, dur), position+m);
                  guitartrack.addEvent(new Note(pitx, 0, 0), position+m+16);
                }
                catch(Exception e){//NullPointerException
                  //vplayer.println("crashed by "+e);
                }
              }
            }
            break;

          case 3:
            int frame = int(compose.getChild(i).getChild(j).getChild(k).getStringAttribute("frame").toString());
            String speech = compose.getChild(i).getChild(j).getChild(k).getContent();//(0).toString();
            lyrics[bars][frame] = speech;
            break;
          }
        }

        for(int m=0; m<16; m++){
          //score.addCallback(float(position+m)/4, 1);
        }

        bars++;
        position+=quantization;
      }
    }


    //score.tempo(settings.tempo);
    //score.addCallbackListener(p);
    song = new Song(name, settings.tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(guitartrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*bars);
    sequencer.setLoopCount(-1);
  }
}





