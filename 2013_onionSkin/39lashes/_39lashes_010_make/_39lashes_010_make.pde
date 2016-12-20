import arb.soundcipher.*;
import promidi.*;
import rita.*;

PApplet p = this;
Donmiguel donmiguel;

SoundCipher sc = new SoundCipher(this);
SCScore score  = new SCScore();

int quantization = 16;
int tempo        = 100;

promidi.Sequencer sequencer = new promidi.Sequencer();
promidi.Track drumstrack, basstrack, guitartrack, bellstrack;

MidiIO midiIO;
MidiOut drums, bass, kboard;

  Song song;


int midioutChan = 0;

int frame;
int part = -4;
int bar, oldbar;

void setup() {
  //noLoop();
  frameRate(300);
  donmiguel = new Donmiguel();
  setupMidi();
  delay(1000);
  //score.tempo(tempo);
  //score.addCallbackListener(this);
  //makeBar();
  makeSong();
}
void keyPressed() {
  if (keyCode==32)    //println(part+"\t"+bar+"\t"+frame+" <<<<<<<<<<<<");
  sequencer.start();
}
void draw() {
    bar = int(sequencer.getTickPosition()/512);
    if(bar!=oldbar && bar<=40){
      String rnd = ""+(bar);
      donmiguel.sing(rnd);
    }
   int   frame = int((sequencer.getTickPosition()%512)/32);
   println(bar+" "+frame);
   oldbar = bar;
}
void makeSong() {
  for (part = -4; part<43; part++) {
    for (int i=0; i<quantization; i++) {
      compose(i);
    }
  }
  song = new Song("_39Lashes", tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(guitartrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*(48+4));
    sequencer.setLoopCount(-1);
}
void setupMidi() {
  midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  drums   = midiIO.getMidiOut(9, midioutChan);
  bass    = midiIO.getMidiOut(1, midioutChan);
  kboard  = midiIO.getMidiOut(0, midioutChan);
  //midiIO.plug(this,"noteOn",0,9);
  //midiIO.plug(this,"noteOff",0,9);
  //midiIO.plug(this,"controllerIn",0,9);
  //midiIO.plug(this,"programChange",0,9);
  drumstrack = new promidi.Track("drums", drums);
  basstrack = new promidi.Track("bass", bass);
  guitartrack = new promidi.Track("guitar", kboard);

  drumstrack.setQuantization(Q._1_16);
  basstrack.setQuantization(Q._1_16);
  guitartrack.setQuantization(Q._1_16);
}
void stop() {
  //score.stop();
}

