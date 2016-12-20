//import processing.opengl.*;
import fullscreen.*; 
import rita.*;
import promidi.*;
import arb.soundcipher.*;
import hypermedia.net.*;

UDP udp;  // define the UDP object

FullScreen fs; 
VScreen screen1, screen2;
VPlayer vplayer;
VAdmin vadmin; 

PApplet p = this;

int midiChan;

SCScore score;
MidiIO midiIO;

Evolution evolution;
MidiKb    midikb;

VZession session;
Donmiguel donmiguel;

boolean mini =     true;
boolean fsStatus = false;
boolean realmidi = true;

boolean scrollOn, halloesOn, innerOn, outLineOn, vertexOn, cycleOn;
int screendiv = 1;

void setup(){
  midiChan = 1;//realmidi? 1:0;
  // create a new datagram connection on port 6000
  // and wait for incomming message
  udp = new UDP( this, 6000, "224.0.0.1" );
  udp.listen( true );

  screen1 = new VScreen(0,0,800,600);//0,0,512,384);//1280,800);
  screen2 = new VScreen(0,0,800,600);//0,0,512,384);
  screen1.showCursor = false;
  screen2.showCursor = false;
  vplayer = new VPlayer(0,0,800,600);//screen1.width, screen1.height);
  
  halloesOn = true;
  innerOn   = true;
  outLineOn = false;
  vertexOn  = false;
  cycleOn   = false;
  scrollOn  = false;

  score = new SCScore();
  midiIO = MidiIO.getInstance();
  midiIO.printDevices();


  evolution = new Evolution(3);
  midikb    = new MidiKb(2);
  
  session = new VZession("session/_ten.xml");
  donmiguel = new Donmiguel();
  //
  vadmin = new VAdmin(0,0,800,600);//512,384);
//
  if(mini)
  size(400,300);//800,600);//screen1.width+screen2.width, max(screen1.height, screen2.height),JAVA2D);//720,480);//720,480);//512,384);//512*2,384);//
  else
  size(800,600);
  //size(400,400);
  colorMode(HSB);
  frameRate(30);
  fs = new FullScreen(this);//SoftFullScreen(this);
  if(fsStatus)fs.enter();
}

void draw(){
  background(0);
  noCursor();
  pushMatrix();
  if(mini)scale(.5);
  translate(screen2.x,screen2.y);

  vadmin.draw();
  //midikb.draw();
  //evolution.draw();
  popMatrix();
  vplayer.update();
}
void mouseMoved(){
  screen1.mouseMoved();
  screen2.mouseMoved();
  noCursor();
}
void stop(){
}




