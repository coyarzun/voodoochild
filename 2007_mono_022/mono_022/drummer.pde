class Drummer{
  Sequencer sequencer = new Sequencer();
  MidiOut midiout = midiIO.getMidiOut(9,0);
  Track base;
  Song song;
  
  String patterns[][];
  int mastervolume = 127;
  int volume = 127;
  float tempo = 150;
  int quantization = 16;
  int kurrent[];
  
  Drummer(String $1){
    String txt[] = loadStrings($1);
    
    patterns = new String[128][128];
    int patterncounter = 0;
    int padcounter = 0;
  
    for(int i=0; i<txt.length; i++){
      String linex = txt[i];
      if(linex.length()==(2+1+quantization)){
        patterns[patterncounter][padcounter++] = linex;
      }else{
        patterncounter++;
      };
    };
    //luego carga un pattern x default
    kurrent = new int[1];
    kurrent[0] = 0;
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
    base = new Track("drums", midiout);
    base.setQuantization(Q._1_16);
    
    for(int k=0; k<kurrent.length; k++){

      String[] pattern = patterns[kurrent[k]];

      float a = float(mastervolume)/127;
      float b = float(volume)/127;
      float prevol = a*b;
      
      for(int i=0; i<pattern.length; i++){
        if(pattern[i]!=null){
          String linex = pattern[i];
          int instrument = unhex(linex.substring(0,2));

          for(int j=3; j<linex.length(); j++){
            try{
              int vol = int(prevol*127*unhex(linex.substring(j,j+1))/15);
              base.addEvent(new Note(instrument, vol, 80), j-3+quantization*k); 
            }catch(Exception e){//NullPointerException
              //println("crashed by "+e);
            };
          };
        };
      };
    };

    song = new Song("drums", tempo);
    song.addTrack(base);
    //song.setTempo(tempo);
    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*kurrent.length);
    sequencer.setLoopCount(-1);
  }
}
/*drums 
  27: punch breaker
  28: clap?
  29: skratch teki high
  30: skratch teki low
  31: baquetas
  32: pt'k!
  33: rim shot
  34: cencerro?
  35: bass drum low
  36: bass drum
  37: rim shot 2
  38: snare drum
  39: clap 2
  40: high snare drum
  41: high metallic tom
  42: charles
  43: mid metallic tom 
  44: charles open
  45: low metallic tom 
  46: ride?
  47: high tom?
  48: mid tom?
  49: crash
  50: tom zaund
  51: ride? + apagao
  52: platisho shino
  53: cymbal
  54: pandero
  55: platillo raro tipo crash apagao
  56: cencerro?
  57: crash?
  58: kashta�uelas
  59: platisho doble?
  60: otro tipo de cencerro o bong�
  61: tamborcillo sambero
  62: borde de tambor apagao
  63: tipo bong�
  64: tipo bong�
  65: conga
  66: low conga
  67: claves metalicas
  68: weaitas
  69: maraca
  70: especie de maraka como grillo
  71: pito
  72: pito juerte
  73: rascando?
  74: rascando low
  75: claves?
  76: brazil este
  77: brazil este low
  78: brazil membrana tipo voz de mono
  79: brazil membrana tipo voz de mono low
  80: very brilliant brazil klaves
  81: very very brilliant brazil klaves
  82: kaskabeles
  83: brazil kaskabel metaliico?
  84: palitos o kizas q cosa
  85: kasta�eteo seko
  86: cajon
  87: timbal
  */
