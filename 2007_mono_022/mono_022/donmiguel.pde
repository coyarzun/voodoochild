class Donmiguel{
  
  RiSpeech speech1, speech2;
    
  String alllyrics[];
  /*
  VoiceManager voiceManager;
  Voice[] voices;
  String voiceName;
  Voice voice;
  */
  
  int tab[][];
  
  Donmiguel(){
        speech1 = new RiSpeech(p); 
    speech1.setVoice("kevin");

    speech2 = new RiSpeech(p); 
    speech2.useMacTTS();
    speech2.setVoice("Kathy");
    /*
    voiceManager = VoiceManager.getInstance();
    voices = voiceManager.getVoices();
    for(int i=0; i<voices.length; i++){
      //println("    " +voices[i].getName()+" ("+voices[i].getDomain()+" domain)");
    };
    voiceName = "kevin";
    //println("Using voice: " + voiceName);
    voice = voiceManager.getVoice(voiceName);
    //voice.allocate();
    */
  }
  void loadLyrics(String $1){
    alllyrics = loadStrings($1);
  }
  void sing(int $1){
    try{
      //voice.speak(alllyrics[$1]);
      speech1.speak(alllyrics[$1]);
    }catch(Exception e){
    };
  }
  void speak(String $1){
    try{
      speech2.speak($1);
      //voice.speak($1);
    }catch(Exception e){
    };
  }
}
