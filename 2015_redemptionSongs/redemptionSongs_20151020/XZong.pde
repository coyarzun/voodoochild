class XMLZong extends VZong {
  XML xmlsong;
  //ZongSettings settings;
  XML patterns;
  XML tonepatterns;
  XML compose;


  String file;
  boolean songloaded = false;
  //boolean rocking = false;

  float a, b, prevol;

  int notes2search;
  int note, pitx, vol, dur;

  //String[][] 

  XMLZong(String $1) {
    lyrics = new String[1024][16];
    file = $1;
    loadSong();
  }
  void loadSong() {
    try {
      xmlsong = loadXML(file);

      parseSong();
      songloaded = true;
    }
    catch(Exception ide) {
      songloaded = false;
    }
  }
  void parseSong() {
    score.empty();

    name = xmlsong.getString("name");

    settings = new ZongSettings(xmlsong.getChild("settings"));
    patterns = xmlsong.getChild("patterns");
    tonepatterns = xmlsong.getChild("tonepatterns");
    compose = xmlsong.getChild("compose");

    //println(patterns);

    drumstrack = new promidi.Track("drums", drumsout);
    basstrack = new promidi.Track("bass", bassout);
    basstrack2 = new promidi.Track("bass", bassout2);
    guitartrack = new promidi.Track("guitar", guitarout);

    drumstrack.setQuantization(Q._1_16);
    basstrack.setQuantization(Q._1_16);
    basstrack2.setQuantization(Q._1_16);
    guitartrack.setQuantization(Q._1_16);

    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(settings.bassinstrument)); 

    //drumsout.sendController(new Controller(7,0)); volume
    //bassout.sendController(new Controller(7,0)); volume

    //bassout.sendProgramChange(new ProgramChange(settings.bassinstrument)); 
    guitarout.sendProgramChange(new ProgramChange(settings.guitarinstrument)); 

    quantization = 16;
    int position = 0;

    int chan = 0;

    beatMap = new BeatMap();

    XML[] parts = compose.getChildren("part");
    for (int i=0; i<parts.length;i++) {//recorre las partes
      XML[] phrases = parts[i].getChildren("phrase");
      for (int j =0; j<phrases.length;j++) {//y luego las frases
        XML[] barss = phrases[j].getChildren("bar");
        for (int k =0; k<barss.length;k++) {//y luego las bars
          switch(barss[k].getInt("kind")) {
          case 0:
            a = float(settings.mainlevel)/127;
            b = float(settings.drumlevel)/127;
            prevol = a*b;
            int drum2search = int(barss[k].getContent());
            XML[] drumpatterns = patterns.getChild("drumpatterns").getChildren("drumpattern");
            XML[] pads = drumpatterns[drum2search].getChildren("pad");
            for (int pad=0; pad<pads.length; pad++) {
              int padinstrument = pads[pad].getInt("id");
              String pttrn = pads[pad].getContent();
              for (int m=0; m<pttrn.length(); m++) {
                String hxtep = pttrn.substring(m, m+1);
                try {
                  int vol = int(prevol*127*unhex(hxtep)/15);
                  score.addNote(float(position+m)/4, 9, 0, padinstrument, 100, 0.25, 0.8, 64);//random(127));//80);
                  drumstrack.addEvent(new Note(padinstrument, vol, 80), position+m); 
                  drumstrack.addEvent(new Note(padinstrument, 0, 0), position+m+4);
                  dobeat(position+m, padinstrument);
                }
                catch(Exception e){
                  println("crashed by "+e);
                }
              }
            }
            break;
          case 1:
            a = float(settings.mainlevel)/127;
            b = float(settings.basslevel)/127;
            prevol = a*b;

            notes2search  = int(barss[k].getChild("notes").getContent());
            XML[] xtonepatterns = tonepatterns.getChildren("notes");
            int[] bassnotes = int(split(xtonepatterns[notes2search].getContent(), ","));
            int bass2search =  int(barss[k].getChild("rhytm").getContent());
            XML[] basspatterns = patterns.getChild("basspatterns").getChildren("basspattern");
            XML[] basspattern  = basspatterns[bass2search].getChildren("pattern");

            for (int pad=0; pad<basspattern.length; pad++) {
              String pttrn = basspattern[pad].getContent();
              for (int m=0; m<pttrn.length(); m++) {
                String hxtep = pttrn.substring(m, m+1);
                try {
                  note = 24+bassnotes[m];
                  int postpos = 3;                  
                  if (hxtep.equals("X")) {
                    hxtep="0";
                    postpos = 3*3*8*2;
                  } 
                  pitx = note+unhex(hxtep);
                  vol = int(prevol*127);

                  score.addNote(float(position+m)/4, chan, 35, pitx, vol, 0.25, 0.8, 64);//random(127));//80);
                  basstrack.addEvent(new Note(pitx, vol, dur), position+m);
                  basstrack.addEvent(new Note(pitx, 0, 0), position+m+postpos);
                  basstrack2.addEvent(new Note(pitx, vol, dur), position+m);
                  basstrack2.addEvent(new Note(pitx, 0, 0), position+m+postpos);
                }
                catch(Exception e) {//NullPointerException
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

            notes2search  = int(barss[k].getChild("notes").getContent());
            XML[] gtonepatterns  = tonepatterns.getChildren("notes");
            int[] guitarnotes    = int(split(gtonepatterns[notes2search].getContent(), ","));
            int   guitar2search  =  int(barss[k].getChild("rhytm").getContent());
            XML[] guitarpatterns = patterns.getChild("guitarpatterns").getChildren("guitarpattern");
            XML[] guitarpattern  = guitarpatterns[guitar2search].getChildren("pattern");

            for (int pad=0; pad<guitarpattern.length; pad++) {
              String pttrn = guitarpattern[pad].getContent();//patterns.getChild(2).getChild(guitar2search).getChild(pad).getContent();
              for (int m=0; m<pttrn.length(); m++) {
                String hxtep = pttrn.substring(m, m+1);
                try {
                  note = 48+guitarnotes[m];
                  pitx = note+unhex(hxtep);
                  vol = int(prevol*127);
                  dur = 800;//0;
                  score.addNote(float(position+m)/4, chan, 0, pitx, vol, 0.25*8, 0.8, 64);//random(127));//80);
                  guitartrack.addEvent(new Note(pitx, vol, dur), position+m);
                  guitartrack.addEvent(new Note(pitx, 0, 0), position+m+16);
                }
                catch(Exception e){
                  //println("crashed by "+e);
                }
              }
            }
            break;
          case 3:
            int frame     = int(barss[k].getString("frame"));
            String speech = barss[k].getContent();
            lyrics[bars][frame] = speech;
            break;
          }
        }
        bars++;
        position+=quantization;
      }
    }
    score.tempo(settings.tempo);
    song = new Song(name, settings.tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*bars);
    sequencer.setLoopCount(-1);
    sequencer.noLoop();
  }
}
