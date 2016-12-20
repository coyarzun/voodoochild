class Bassplayer{
  Sequencer sequencer = new Sequencer();
  MidiOut midiout = midiIO.getMidiOut(1,0);
  Track base;
  Song song;
  
  String patterns[][];
  
  int mastervolume = 127;
  int volume = 127;
  float tempo = 150;
  int quantization = 16;
  int kurrent[];
  
  int mininstrument = 32;
  int maxinstrument = 39;
  int instrument = mininstrument;
  
  int minnote = 24;
  int maxnote = minnote+12*3;
  int note = minnote;
  
  int tab[][];
  
  Bassplayer(String $1){
    String txt[] = loadStrings($1);
    
    patterns = new String[128][16];
    int patterncounter = 0;
    int padcounter = 0;
  
    for(int i=0; i<txt.length; i++){
      String linex = txt[i];
      if(linex.length()==(quantization)){
        patterns[patterncounter][padcounter++] = linex;
      }else{
        patterncounter++;
      };
    };
    //luego carga un pattern x default
    tab = new int[1][16];
    
    kurrent = new int[1];
    kurrent[0] = 0;
    parsePatterns();
  }
  void rawInstrument(int v){
    setInstrument(int(mininstrument+(maxinstrument-mininstrument)*v/127));
  }
  void setInstrument(int v){
    instrument = v;
    parsePatterns();
  }
  void rawNote(int v){
    setNote(int(minnote+(maxnote-minnote)*v/127));
  }
  void setNote(int v){
    note = v;
    parsePatterns();
  }
  void setMasterVolume(int v){
    mastervolume = v;
    parsePatterns();
  }
  void setVolume(int v){
    volume = v;
    parsePatterns();
  }
  void setTempo(float t){
    tempo = t;
    song.setTempo(t);
  }
  void parsePatterns(){
    base = new Track("bass", midiout);
    base.setQuantization(Q._1_16);
                   
    midiout.sendProgramChange(new ProgramChange(instrument));  
    
    for(int k=0; k<kurrent.length; k++){

      String[] pattern = patterns[kurrent[k]];

      float a = float(mastervolume)/127;
      float b = float(volume)/127;
      float prevol = a*b;
      
      for(int i=0; i<pattern.length; i++){
        if(pattern[i]!=null){
          String linex = pattern[i];
          //int instrument = unhex(linex.substring(0,2));
          for(int j=0; j<linex.length(); j++){
            try{
              note = minnote+tab[k][j];
              int pitx = note+unhex(linex.substring(j,j+1));
              int vol = int(prevol*127);//int(prevol*127*unhex(linex.substring(j,j+1))/15);
              int dur = 40;
              base.addEvent(new Note(pitx, vol, dur), j+quantization*k); 
            }catch(Exception e){//NullPointerException
              //println("crashed by "+e);
            };
          };
        };
      };
    };

    song = new Song("bass", tempo);
    song.addTrack(base);
    //song.setTempo(tempo);
    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*tab.length);
    sequencer.setLoopCount(-1);
  }
}
/*
33.     Acoustic Bass
34.     Electric Bass (finger)
35.     Electric Bass (pick) 
36.     Fretless Bass 
37.     Slap Bass 1   
38.     Slap Bass 2   
39.     Synth Bass 1  
40.     Synth Bass 2  
*/
