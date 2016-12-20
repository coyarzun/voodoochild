class VZong{
  //promidi.Sequencer sequencer;// = new promidi.Sequencer();
  ZongSettings settings;// = new ZongSettings();
  promidi.Sequencer sequencer = new promidi.Sequencer();

  MidiOut drumsout = midiIO.getMidiOut(9,midiChan);
  MidiOut bassout = midiIO.getMidiOut(1,midiChan);
  MidiOut guitarout = midiIO.getMidiOut(0,midiChan);
  MidiOut bellsout = midiIO.getMidiOut(1,midiChan);

  promidi.Track drumstrack, basstrack, guitartrack, bellstrack;

  Song song;

  boolean rocking;
  String name = "";
  int bars = 0;
  int bar = 0, frame = 0, cframe = 0;
  int oldbar=-1, oldframe=-1;

  String[][] lyrics;

  BeatMap beatMap;

  VZong(){
  }
  void draw(){
    //if(!score.playing)stop();
  }
  void rock(){
    sequencer.start();
    rocking = true;
    vplayer.println("song "+name+" rocking!");
  }

  void stop(){
    sequencer.stop();
    rocking = false;
    bar = 0; 
    frame = 0; 
    cframe = 0;
    vplayer.println("song "+name+" stopped");
  }
  void dobeat(int pos, int pad){
    switch(pad){
    case 35:
    case 36:
      beatMap.addKick(pos);
      break;
    case 38:
      beatMap.addSnare(pos);
      break;
    case 42:
    case 44:
      beatMap.addHat(pos);
      break;
    case 37:
      beatMap.addRim(pos);
      break;   
    }
  }
  void checksong(){
    if(rocking){
      bar = int(sequencer.getTickPosition()/512);
      frame = int((sequencer.getTickPosition()%512)/32);

      if(oldbar!=bar || oldframe!=frame){

        if(lyrics[bar][frame]!=null){
          donmiguel.sing(lyrics[bar][frame]);
          vadmin.cscreen.addLyric(lyrics[bar][frame]);
        }
      };
      if(!settings.loopeable && bar<oldbar){
        stop();
      }    

      oldbar=bar;
      oldframe=frame;
    }
  }
}

class ZongSettings{
  int tempo = 120;
  boolean loopeable = false;
  int mainlevel = 127;
  int basslevel = 127;
  int guitarlevel = 127;
  int drumlevel = 127;
  int bassinstrument = 38;
  int guitarinstrument = 28;

  ZongSettings(){
  }
  ZongSettings(XMLElement $1){
    tempo = int($1.getChild(0).getContent());
    loopeable = boolean($1.getChild(1).getContent());

    mainlevel = int($1.getChild(2).getChild(0).getContent());
    drumlevel = int($1.getChild(2).getChild(1).getContent());
    basslevel = int($1.getChild(2).getChild(2).getContent());
    guitarlevel = int($1.getChild(2).getChild(3).getContent());

    bassinstrument = int($1.getChild(3).getChild(0).getContent());
    guitarinstrument = int($1.getChild(3).getChild(1).getContent());
  }
}






