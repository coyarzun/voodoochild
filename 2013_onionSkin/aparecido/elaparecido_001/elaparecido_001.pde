import arb.soundcipher.*;
import promidi.*;

SoundCipher sc = new SoundCipher(this);
SCScore score  = new SCScore();
float[] r = new float[4];

MidiIO midiIO;
MidiOut drums, bass, kboard;
int midioutChan = 0;

void setup() {  
  noLoop();
  score.tempo(100);
  score.addCallbackListener(this);
  makeMusic();
}
void setupMidi(){
  midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  drums   = midiIO.getMidiOut(9,midioutChan);
  bass    = midiIO.getMidiOut(2,midioutChan);
  kboard  = midiIO.getMidiOut(1,midioutChan);
}
void makeMusic() {
  score.empty();
  for (float i=0; i<12; i++) {
    if(i%2==0)
    score.addNote(i/4, 9, 0, 42, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    else
    score.addNote(i/4, 9, 0, 44, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    if(i%3==0 || random(10)>5){
      score.addNote(1*i/4+0*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      score.addNote(1*i/4+2*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      score.addNote(1*i/4+4*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    }
    if(i==2||i==4||i==8||i==10)
        score.addNote(i/4, 9, 0, 36, random(120,127), 0.25, 0.8, 64);
    if(i%2==0 || i%3==0)
    score.addNote(i/4, 0, 0, 32+12*(i%3!=0?0:1), random(80,100), 0.25, 0.8, 64);
  }
  score.addCallback(3,0);
  //score.update();
  score.play();
}

void handleCallbacks(int callbackID) {
  if(callbackID==0){
    score.stop();makeMusic();
  }
}
  
void draw() {
  background(120);
  rect(r[0], r[1], r[2], r[3]);
}

void stop() {
  score.stop();
}
