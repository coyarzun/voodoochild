class Donmiguel{
  private RiSpeech[] speech;
  private int cspeech;
  String lastlyric = "";
  
  Donmiguel(){
    //speech = new RiSpeech(p); 
    //speech.setVoice("kevin");
    /*
    speech.useMacTTS();
    speech.setVoice("Kathy");*/
    speech = new RiSpeech[2];
    for(int i=0; i<speech.length; i++){
      speech[i] = new RiSpeech(p);
      //speech[i].setVoice("kevin");
      speech[i].useMacTTS();
      speech[i].setVoice("Kathy");
      
      /*"Victoria", "Agnes", "Kathy", "Princess", "Vicki", 
    "Bruce", "Fred", "Junior", "Ralph", "Albert",
    "Bad News", "Bahh", "Bells", "Boing", "Bubbles", 
    "Cellos", "Deranged", "Good News", "Hysterical", 
    "Pipe Organ", "Trinoids", "Whisper", "Zarvox"*/

    }
  }
  void sing(String $1){
   try{
      
      if(random(2)>1){speech[cspeech].setVoice("Fred");}else{speech[cspeech].setVoice("Kathy");}
      speech[cspeech].speak($1);
      cspeech++;
      cspeech%=speech.length;
      lastlyric = $1;
      
    }
      catch(Exception e){
    }
  }
}

