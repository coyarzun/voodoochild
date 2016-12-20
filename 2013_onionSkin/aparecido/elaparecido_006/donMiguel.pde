class Donmiguel{
  RiSpeech speech1, speech2;

  Donmiguel(){
    speech1 = new RiSpeech(p); 
    speech1.setVoice("kevin");

    speech2 = new RiSpeech(p); 
    speech2.useMacTTS();
    speech2.setVoice("Kathy");

  }
  void sing(String $1){
    try{
      //if(random(100)>50){
      //  speech1.speak($1);
      //}else{
        speech2.speak($1);
      //}
    }
    catch(Exception e){
    }
  }
}

