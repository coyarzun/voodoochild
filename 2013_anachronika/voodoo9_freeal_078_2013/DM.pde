class Donmiguel{
   String lastlyric = "";

  Donmiguel(){
  }
  void sing(String $1){
    try{
      lastlyric = $1;
      udp.send( $1 );
    }
    catch(Exception e){
    }
  }
}


