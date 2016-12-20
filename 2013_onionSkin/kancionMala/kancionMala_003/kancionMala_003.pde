import arb.soundcipher.*;
import promidi.*;
import rita.*;

PApplet p = this;
Donmiguel donmiguel;

SoundCipher sc = new SoundCipher(this);
SCScore score  = new SCScore();

int quantization = 16;
int tempo        = 90;

promidi.Sequencer sequencer = new promidi.Sequencer();
promidi.Track drumstrack, basstrack, guitartrack, bellstrack;

MidiIO midiIO;
MidiOut drums, bass, kboard;

Song song;

int midioutChan = 0;

int part = -1;
int bar, oldbar;
int frame, oldframe;
int position = 0;
//kancionMala
//guaripolo
//bass tickbass
//fx   u02 cleanchorus o u03 rfier stack? o u19 flanger
//kbd  a52 arp     a32 arp     b43!
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
  song = new Song("kancionMala", tempo);
  song.addTrack(drumstrack);
  song.addTrack(basstrack);
  song.addTrack(guitartrack);

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
  kboard  = midiIO.getMidiOut(0, midioutChan);
  drumstrack = new promidi.Track("drums", drums);
  basstrack = new promidi.Track("bass", bass);
  guitartrack = new promidi.Track("guitar", kboard);

  drumstrack.setQuantization(Q._1_16);
  basstrack.setQuantization(Q._1_16);
  guitartrack.setQuantization(Q._1_16);
}
void stop(){
      muteall();
  //score.stop();
}

