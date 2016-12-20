import arb.soundcipher.*;
import promidi.*;

SCScore score  = new SCScore();
float[] r = new float[4];

MidiIO midiIO;
MidiOut drums, bass, kboard;
int midioutChan = 0;
int bar;

void setup() {  
  noLoop();
  setupMidi();
  score.tempo(90);
  score.addCallbackListener(this);
  makeMusic();
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
void compose(){
  
}
void handleCallbacks(int callbackID) {
  int i = callbackID;
  if(callbackID==-1){
    score.stop();makeBar();
  }else{
    doDrums(i,0); 
    doGuitar(i,0);
  }
}
void stop() {
  score.stop();
}
