import arb.soundcipher.*;
import promidi.*;
import rita.*;

PApplet p = this;
Donmiguel donmiguel;

SoundCipher sc = new SoundCipher(this);
SCScore score  = new SCScore();

int quantization = 16;
int tempo        = 170;//140 ;//117;

promidi.Sequencer sequencer = new promidi.Sequencer();
promidi.Track drumstrack, basstrack, kboardtrack, bellstrack, samplertrack;

MidiIO midiIO;
MidiOut drums, bass, kboard, sampler;

Song song;

int midioutChan = 0;

int part = -1;
int bar, oldbar;
int frame, oldframe;
int position = 0;
//the eternal city
//voodoochild
void setup(){
  frameRate(300);
  donmiguel = new Donmiguel();
  setupMidi();
  muteall();
  makeSong();
}
void keyPressed(){
  if (keyCode==32){
    muteall();
    sequencer.setTickPosition(512*0);
    sequencer.start();
  }
}
void draw(){
  bar   = int(sequencer.getTickPosition()/512);
  frame = int((sequencer.getTickPosition()%512)/32);
  if(frame!=oldframe){
    println(bar+" "+frame);
    checkLyrics(bar, frame);
  }
  oldbar = bar;
  oldframe = frame;
}
void makeSong(){
  compose();
  song = new Song("geometric frustration", tempo);
  song.addTrack(drumstrack);
  song.addTrack(basstrack);
  song.addTrack(samplertrack);
  song.addTrack(kboardtrack);

  sequencer.setSong(song);
  sequencer.setLoopStartPoint(0);
  sequencer.setLoopEndPoint(512*(200));
  sequencer.setLoopCount(-1);
}
void setupMidi(){
  midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  drums   = midiIO.getMidiOut(9, midioutChan);
  bass    = midiIO.getMidiOut(1, midioutChan);
  sampler = midiIO.getMidiOut(1, midioutChan);//+1);
  kboard  = midiIO.getMidiOut(0, midioutChan);
  drumstrack   = new promidi.Track("drums", drums);
  basstrack    = new promidi.Track("bass", bass);
  samplertrack = new promidi.Track("sampler", sampler);
  kboardtrack  = new promidi.Track("guitar", kboard);

  drumstrack.setQuantization(Q._1_16);
  basstrack.setQuantization(Q._1_16);
  samplertrack.setQuantization(Q._1_16);
  kboardtrack.setQuantization(Q._1_16);
}
void stop(){
  muteall();
  //score.stop();
}

