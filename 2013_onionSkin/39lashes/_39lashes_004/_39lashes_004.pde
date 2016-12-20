import arb.soundcipher.*;
import promidi.*;
import rita.*;

PApplet p = this;
Donmiguel donmiguel;
SCScore score  = new SCScore();

int quantization = 16;
int tempo        = 120;

MidiIO midiIO;
MidiOut drums, bass, kboard;
int midioutChan = 0;
int bar;
int frame;
int part = -1;

void setup(){
  noLoop();
  donmiguel = new Donmiguel();
  setupMidi();
  delay(1000);
  score.tempo(tempo);
  score.addCallbackListener(this);
  makeBar();
}
void keyPressed(){
  if(keyCode==32)    println(part+"\t"+bar+"\t"+frame+" <<<<<<<<<<<<");
}
void draw(){
  
}
void setupMidi(){
  midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  drums   = midiIO.getMidiOut(9,midioutChan);
  bass    = midiIO.getMidiOut(0,midioutChan);
  kboard  = midiIO.getMidiOut(1,midioutChan);
  //midiIO.plug(this,"noteOn",0,9);
  //midiIO.plug(this,"noteOff",0,9);
  //midiIO.plug(this,"controllerIn",0,9);
  //midiIO.plug(this,"programChange",0,9);
}
void makeBar() {
  score.empty();
  for (float i=0; i<quantization; i++){
    score.addCallback(i/4,int(i));
  }
  score.addCallback(4,-1);
  score.play();
  bar++;
}
void handleCallbacks(int callbackID) {
  int i = callbackID;
  if(callbackID==-1){
    score.stop();makeBar();
  }else{
    frame = i;
    compose(i);
    //println(part+"\t"+bar+"\t"+i);
    checkLyrics(i);
  }
}
void stop() {
  score.stop();
}


