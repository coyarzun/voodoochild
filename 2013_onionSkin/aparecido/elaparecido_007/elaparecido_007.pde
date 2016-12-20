import arb.soundcipher.*;
import promidi.*;
import rita.*;

PApplet p = this;
Donmiguel donmiguel;
SCScore score  = new SCScore();
float[] r = new float[4];

MidiIO midiIO;
MidiOut drums, bass, kboard;
int midioutChan = 0;
int bar;
int frame;

void setup() {  
  noLoop();
  donmiguel = new Donmiguel();
  setupMidi();
  score.tempo(70);
  score.addCallbackListener(this);
  makeBar();
}
void keyPressed(){
  if(keyCode==32)    println(part+"\t"+bar+"\t"+frame+" <<<<<<<<<<<<");
}
void setupMidi(){
  midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  drums   = midiIO.getMidiOut(9,midioutChan);
  bass    = midiIO.getMidiOut(0,midioutChan);
  kboard  = midiIO.getMidiOut(1,midioutChan);
}
void makeBar() {
  score.empty();
  for (float i=0; i<12; i++){
    score.addCallback(i/4,int(i));
  }
  score.addCallback(3,-1);
  score.play();
  bar++;
}
int part;

void compose(int i){
  switch(part){
    case 0:
    case 1:
    case 5:
    case 6:
    case 10:
    case 11:
    case 14:
    case 15:
    case 16:
    case 17:
      phrase0(i);//0(i);
      break;
    case 2:
    case 7:
      phrase1(i);
      break;
    case 3:
    case 8:
    case 12:
      phrase1_2(i);
      break;
    case 4:
    case 9:
    case 13:
      phrase2(i);
      break;
    case 18:
      break;
  }
}
void phrase0(int i){
  switch((bar-1)%4){
    case 0:
    default:
    riff001_2(i);
    break;
    case 1:
    riff004(i);
    break;
    case 2:
    riff002_3(i);
    break;
    case 3:
    riff001_2(i);
    if(i==11){bar=0;part++;}
    break;
  }
}
void phrase1(int i){
  switch((bar-1)%10){
    case 0:
    default:
    riff001(i);
    break;
    case 1:
    riff001(i);
    break;
    case 2:
    riff002(i);
    break;
    case 3:
    riff001(i);
    break;
    //
    case 4:
    riff002(i);
    break;
    case 5:
    riff003(i);
    break;
    case 6:
    riff001(i);
    break;
    case 7:
    riff001(i);
    break;
    //
    case 8:
    riff004(i);
    break;
    case 9:
    riff001(i);
    if(i==11){bar=0;part++;}
    break;
  }
}
void phrase1_2(int i){
  switch((bar-1)%8){
    case 0:
    default:
    riff001(i);
    break;
    case 1:
    riff001(i);
    break;
    case 2:
    riff002(i);
    break;
    case 3:
    riff001(i);
    break;
    //
    case 4:
    riff002(i);
    break;
    case 5:
    riff003(i);
    break;
    case 6:
    riff001(i);
    break;
    case 7:
    riff001(i);
    if(i==11){bar=0;part++;}
    break;
  }
}
void phrase2(int i){
  switch((bar-1)%15){
    case 0:
    case 2:
    case 4:
    case 6:
    case 8:
    case 10:
    case 12:
    default:
    riff005(i);
    break;
    case 1:
    case 3:
    case 5:
    case 7:
    case 9:
    case 11:
    riff006(i);
    break;
    case 13:
    riff001(i); 
    break;   
    case 14:
    riff001(i); 
    if(i==11){bar=0;part++;}
    break;
  }
}

void riff001(int i){//mim
    doDrums(i,0); 
    doBass(i,0,4);
    doGuitar(i,0,5,4,0);
}
void riff001_2(int i){//mim otro
    doDrums(i,0); 
    doBass(i,0,4);
    doGuitar(i,1,5,4,0);
}
void riff002(int i){//LaM
    doDrums(i,0); 
    doBass(i,0,9);
    doGuitar(i,0,5,9,1);
}
void riff002_3(int i){//Lam
    doDrums(i,0); 
    doBass(i,0,9);
    doGuitar(i,0,5,9,0);
}
void riff002_2(int i){//LaM otro
    doDrums(i,0); 
    doBass(i,0,9);
    doGuitar(i,0,5,9,1);
}
void riff003(int i){//SolM otro
    doDrums(i,0); 
    doBass(i,0,7);
    doGuitar(i,0,5,7,1);
}
void riff004(int i){//Sim 
    doDrums(i,0); 
    doBass(i,0,11);
    doGuitar(i,0,5,11,0);
}
void riff005(int i){//DoM
    doDrums(i,0); 
    doBass(i,1,0);
    doGuitar(i,1,5,0,1);
}
void riff006(int i){//ReM 
    doDrums(i,0); 
    doBass(i,0,2);
    doGuitar(i,0,5,2,1);
}
void riff007(int i){//DoM -Mim
    boolean cond = i<12;
    doDrums(i,0); 
    doBass(i,0,cond?0:4);
    doGuitar(i,0,5,cond?0:4,cond?1:0);
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
