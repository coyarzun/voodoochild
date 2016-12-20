import rita.*;
import hypermedia.net.*;

UDP udp;  // define the UDP object

PApplet p = this;
Donmiguel donmiguel;
void setup(){
  udp = new UDP( this, 6000, "224.0.0.1" );
  udp.listen( true );

  donmiguel = new Donmiguel();
}
void draw(){
}
void mousePressed(){
  donmiguel.sing("ideologically    ");//hydraulphones");//
}
void receive( byte[] data, String ip, int port ){
  String message = new String( data );
  donmiguel.sing(message);
  //println(message);
  udp.send( "", ip, port );
}

