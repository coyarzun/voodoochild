class VZong {
  ZongSettings settings;// = new ZongSettings();
  promidi.Sequencer sequencer = new promidi.Sequencer();

  MidiOut drumsout  = midiIO.getMidiOut(9, midiManager.outputChan);//midiManager.
  MidiOut bassout   = midiIO.getMidiOut(1, midiManager.outputChan);
  MidiOut bassout2  = midiIO.getMidiOut(1, midiManager.outputChan2);
  MidiOut guitarout = midiIO.getMidiOut(0, midiManager.outputChan);
  MidiOut bellsout  = midiIO.getMidiOut(1, midiManager.outputChan);

  promidi.Track drumstrack, basstrack, basstrack2, guitartrack, bellstrack;

  Song song, song2;

  boolean rocking = false;
  String name = "";
  int bars = 0;
  int bar = 0, frame = 0, cframe = 0;
  int oldbar=-1, oldframe=-1;
  int quantization;

  String[][] lyrics;

  BeatMap beatMap;

  VZong() {
    muteall();
  }
  void muteall() {
    for (int i=0; i<127; i++) {
      drumsout.sendNote(new Note(i, 0, 0));
      bassout.sendNote(new Note(i, 0, 0));
      bassout2.sendNote(new Note(i, 0, 0));
      guitarout.sendNote(new Note(i, 0, 0));
    }
  }
  void setInstruments() {
    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(0)); 
    guitarout.sendProgramChange(new ProgramChange(42));//62));
  }
  void dobeat(int pos, int pad) {
    switch(pad) {
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
}

class ZongSettings {
  int tempo = 120;
  boolean loopeable = false;
  int mainlevel = 127;
  int basslevel = 127;
  int guitarlevel = 127;
  int drumlevel = 127;
  int bassinstrument = 38;
  int guitarinstrument = 28;

  ZongSettings() {
  }
  ZongSettings(XML $1) {

    tempo = int($1.getChild("tempo").getContent());
    loopeable = boolean($1.getChild("loopeable").getContent());

    mainlevel = int($1.getChild("levels").getChild("mainlevel").getContent());
    drumlevel = int($1.getChild("levels").getChild("drumlevel").getContent());
    basslevel = int($1.getChild("levels").getChild("basslevel").getContent());
    guitarlevel = int($1.getChild("levels").getChild("guitarlevel").getContent());

    bassinstrument = int($1.getChild("instruments").getChild("bassinstrument").getContent());
    guitarinstrument = int($1.getChild("instruments").getChild("guitarinstrument").getContent());
  }
}
