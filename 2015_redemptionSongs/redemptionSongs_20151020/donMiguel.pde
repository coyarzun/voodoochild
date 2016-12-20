class DonMiguel {
  String lastlyric = "";
  UDP udp;  // define the UDP object

  DonMiguel() {
    udp = new UDP( p, 6000, "224.0.0.1" );
    udp.listen( true );
  }
  void sing(String $1) {
    try {
      lastlyric = $1;
      udp.send( $1 );
    }
    catch(Exception e) {
    }
  }
  void sing(String $1, boolean isfemale) {//not yet
    try {
      lastlyric = $1;
      udp.send( $1 );
    }
    catch(Exception e) {
    }
  }
  //  UDP udp;  // define the UDP object
  //  boolean local;
  //   String lastlyric = "";
  //   
  //
  //  DonMiguel(boolean l){
  //    local = l;
  //    udp = new UDP( p, 6000, "224.0.0.1" );
  //    udp.listen( true );
  //  }
  //
  //  void sing(String $1){
  //    try{
  //      lastlyric = $1;
  //      udp.send( $1 );
  //    }
  //    catch(Exception e){
  //    }
  //  }
  //  void sing(String $1, boolean isfemale){//not yet
  //    try{
  //      lastlyric = $1;
  //      udp.send( $1 );
  //    }
  //    catch(Exception e){
  //    }
  //  }


  //  RiSpeech speech1, speech2;
  //
  //  DonMiguel() {
  //    speech1 = new RiSpeech(p); 
  //    speech1.setVoice("kevin");
  //
  //    speech2 = new RiSpeech(p); 
  //    speech2.useMacTTS();
  //    speech2.setVoice("Kathy");
  //  }
  //  void sing(String $1) {
  //    try {
  //      if (random(100)>50) {
  //        speech1.speak($1);
  //      }
  //      else {
  //        speech2.speak($1);
  //      }
  //    }
  //    catch(Exception e) {
  //    }
  //  }
  //  void sing(String $1, boolean isfemale) {
  //    try {
  //      if (!isfemale) {
  //        speech1.speak($1);
  //      }
  //      else {
  //        speech2.speak($1);
  //      }
  //    }
  //    catch(Exception e) {
  //    }
  //  }
}
