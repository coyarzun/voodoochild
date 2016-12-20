import processing.core.*; 
import processing.xml.*; 

import arb.soundcipher.*; 
import promidi.*; 
import rita.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class leteindien_002 extends PApplet {





PApplet p = this;
Donmiguel donmiguel;

SoundCipher sc = new SoundCipher(this);
SCScore score  = new SCScore();

int quantization = 16;
int tempo        = 110;

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
//l'ete indien
//drum u35 songzero
//bass garageBass
//fx   u02 cleanchorus
//kbd  b64? b52?
public void setup(){
  frameRate(300);
  donmiguel = new Donmiguel();
  setupMidi();
      muteall();
  makeSong();
}
public void keyPressed(){
  if (keyCode==32){
    muteall();
    sequencer.setTickPosition(512*0);
    sequencer.start();
  }
}
public void draw(){
  bar   = PApplet.parseInt(sequencer.getTickPosition()/512);
  frame = PApplet.parseInt((sequencer.getTickPosition()%512)/32);
  if(frame!=oldframe){
    println(bar+" "+frame);
    checkLyrics(bar, frame);
  }
  oldbar = bar;
  oldframe = frame;
}
public void makeSong(){
  compose();
  song = new Song("HEY", tempo);
  song.addTrack(drumstrack);
  song.addTrack(basstrack);
  song.addTrack(guitartrack);

  sequencer.setSong(song);
  sequencer.setLoopStartPoint(0);
  sequencer.setLoopEndPoint(512*(100));
  sequencer.setLoopCount(-1);
}
public void setupMidi(){
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
public void stop(){
      muteall();
  //score.stop();
}

class Donmiguel{
  RiSpeech speech1, speech2;

  Donmiguel(){
    speech1 = new RiSpeech(p); 
    speech1.setVoice("kevin");

    speech2 = new RiSpeech(p); 
    speech2.useMacTTS();
    speech2.setVoice("Kathy");

  }
  public void sing(String $1){
    try{
      if(random(100)>50){
        speech1.speak($1);
      }else{
        speech2.speak($1);
      }
    }
    catch(Exception e){
    }
  }
}
public void compose(){
  for(part = -1; part<36; part++){
    switch(part){
      case -1:
        part00();
        break;
      case 0:
      case 3:
        part01();
        break;
      case 1:
      case 2:
      case 4:
      case 5:
        part02();
        break;
    }
  }
}
public void part00(){
  position+=quantization;
  bar=0;
}
public void part01(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000();//rem
    if(bar==1)riff000();//rem
    if(bar==2)riff001();//solm
    if(bar==3)riff002();//laM
  }
}
public void part02(){  
  for(bar=0; bar<16; bar++){
    if(bar==0)riff000();//rem
    if(bar==1)riff000();//rem
    if(bar==2)riff002();//laM
    if(bar==3)riff002();//laM
    if(bar==4)riff000M();//reM
    if(bar==5)riff000M();//reM
    if(bar==6)riff001();//solm
    if(bar==7)riff001();//solm
    if(bar==8)riff003();//sib
    if(bar==9)riff003();//sib
    if(bar==10)riff000();//rem
    if(bar==11)riff000();//rem
    if(bar==12)riff004();//mi
    if(bar==13)riff004();//mi
    if(bar==14)riff002();//la7
    if(bar==15)riff002();//la7
  }
}
public void danceDrum(int position, int i){
    if(i%4==0)doDrums(position, i, 36, 110, 120);
    if(i%4==2){
      doDrums(position, i, 42, 110, 120);   
      doDrums(position, i+1, 42, 110, 120);   
    }
    if(i%8==4)doDrums(position, i, 38, 110, 120);
}
public void danceBass(int position, int i, int pitch, int mode){
  if(i%4==0){
      doBass(position,i,pitch,1);
      doBass(position,i+1,pitch,1);
  }
  if(i%4==2){
      doBass(position,i,pitch+12,1);
      doBass(position,i+1,pitch+12,1);
  }
}
public void riff000(){//rem
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,2,1);
      doGuitar(position,i,2+3,1);
      doGuitar(position,i,2+7,1);
    }
    danceBass(position,i,2,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff000M(){//reM
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,2,1);
      doGuitar(position,i,2+4,1);
      doGuitar(position,i,2+7,1);
    }
    danceBass(position,i,2,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff001(){//solm
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,-5,1);
      doGuitar(position,i,-5+3,1);
      doGuitar(position,i,-5+7,1);
    }
    danceBass(position,i,-5,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff001M(){//solM
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,-5,1);
      doGuitar(position,i,-5+4,1);
      doGuitar(position,i,-5+7,1);
    }
    danceBass(position,i,-5,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff002(){//laM
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,-3,1);
      doGuitar(position,i,-3+4,1);
      doGuitar(position,i,-3+7,1);
    }
    danceBass(position,i,-3,0);   
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff002m(){//lam
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,-3,1);
      doGuitar(position,i,-3+3,1);
      doGuitar(position,i,-3+7,1);
    }
    danceBass(position,i,-3,0); 
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff003(){//sibm
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,-2,1);
      doGuitar(position,i,-2+3,1);
      doGuitar(position,i,-2+7,1);
    }
    danceBass(position,i,-2,0); 
    danceDrum(position,i);
  }
  position+=quantization;
}
public void riff004(){//miM
  for(int i=0; i<quantization; i++){
    if(i%2==0){
      doGuitar(position,i,4,1);
      doGuitar(position,i,4+4,1);
      doGuitar(position,i,4+7,1);
    }
    danceBass(position,i,4,0);    
    danceDrum(position,i);
  }
  position+=quantization;
}
public void doDrums(int positiom, int i, int pitch, int minv, int maxv) {
  drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
  drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
}
public void doBass(int position, int i, int pitch, int duration) {
  int basescale = 36;
  int nn = basescale+pitch;
  basstrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
  basstrack.addEvent(new Note(nn, 0, 1), position+i+duration);
}
public void doGuitar(int position, int i, int pitch, int duration) {
  int basescale = 36+36;
  int nn = basescale+pitch;
  guitartrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
  guitartrack.addEvent(new Note(nn, 0, 1), position+i+duration);
}
public void checkLyrics(int i) {

}

public void checkLyrics(int bar, int frame){
  /*
  
  Ya sabes, 
  que esta noche me siento tan solo 
  y perdido cuando no estas 
  y esos recuerdos 
  estan llenos de ti, 
  de tu primavera..
  una playa nuestra 
  donde fui arena para sostenerte,
  un mar nuestro 
  donde fui la ola que te llevaba,
  esencia 
  peque\u00f1as cosas 
  y ahora este vacio
  sin poder mirar hacia el futuro,
  solo 
  sin ti..
  
  hacia atras 
  solo puedo mirar atras 
  y sentir que vuelvo a estar 
  aun vivo para el amor, 
  una voz, 
  que viene de un atardecer 
  me hace ver que aun puede ser...
  
  Hoy estoy muy lejos de esos recuerdos,
  donde estas? 
  te acuerdas de mi 
  o te habras olvidado..? 
  tal vez piensas que fue una tonteria conocerme 
  que aquella arena y aquel mar 
  solo fueron recuerdos.. 
 
  cierro los ojos y te imagino! 
  esperare un mes,un a\u00f1o,
  toda la vida 
  por que lo que siento no tiene tiempo, 
  se llama Amor!!
*/
  /*
  if(bar==0 && frame==15)donmiguel.sing("hey!");
  if(bar==1 && frame==8)donmiguel.sing("been trying to meet you mmmmmm hmmmmm");
  //if(bar==2 && frame==0)donmiguel.sing("mmmmmm hmmmmm");
  if(bar==4 && frame==0)donmiguel.sing("hey!");
  if(bar==4 && frame==8)donmiguel.sing("must be a devil");
  if(bar==5 && frame==0)donmiguel.sing("between us");//
  if(bar==6 && frame==0)donmiguel.sing("or whores in my head");
  if(bar==7 && frame==0)donmiguel.sing("whores at the door");
  if(bar==8 && frame==0)donmiguel.sing("whores in my bed");
  if(bar==9 && frame==0)donmiguel.sing("but hey");
  if(bar==10 && frame==0)donmiguel.sing("where");
  if(bar==11 && frame==0)donmiguel.sing("have you");
  if(bar==12 && frame==0)donmiguel.sing("been");
  if(bar==14 && frame==0)donmiguel.sing("if you go!");
  if(bar==15 && frame==0)donmiguel.sing("i will surely die");
  if(bar==16 && frame==0)donmiguel.sing("we're chained");
  if(bar==17 && frame==0)donmiguel.sing("we're chained");
  if(bar==18 && frame==0)donmiguel.sing("we're chained");
  if(bar==19 && frame==0)donmiguel.sing("we're chained");
  if(bar==20 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==21 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==22 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==23 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==24 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==25 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==26 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==27 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==28 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==29 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==47 && frame==0)donmiguel.sing("uh");
  if(bar==48 && frame==8)donmiguel.sing("said the man to the lady");
  if(bar==50 && frame==0)donmiguel.sing("mmmmmm hmmmm");
  if(bar==51 && frame==0)donmiguel.sing("uh");
  if(bar==52 && frame==8)donmiguel.sing("said the lady to the man she adored");
  if(bar==54 && frame==0)donmiguel.sing("and the whores like a choir");
  if(bar==55 && frame==0)donmiguel.sing("go uh all night");
  if(bar==56 && frame==0)donmiguel.sing("and mary ain't you tired of this");
  if(bar==56 && frame==8)donmiguel.sing("uh");
  if(bar==57 && frame==0)donmiguel.sing("is");
  if(bar==58 && frame==0)donmiguel.sing("the");
  if(bar==59 && frame==0)donmiguel.sing("sound");
  if(bar==61 && frame==0)donmiguel.sing("that THE MOTHER MAKES");
  if(bar==62 && frame==0)donmiguel.sing("when the baby breaks");
  if(bar==63 && frame==0)donmiguel.sing("we're chained");
  if(bar==64 && frame==0)donmiguel.sing("we're chained");
  if(bar==65 && frame==0)donmiguel.sing("we're chained");
  if(bar==66 && frame==0)donmiguel.sing("we're chained");
  if(bar==67 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==68 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==69 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==70 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==71 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==72 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==73 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==74 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==75 && frame==0)donmiguel.sing("we're chained");// (chained)");
  if(bar==76 && frame==0)donmiguel.sing("we're chained");// (chained)");
  */
}
public void noteOn(Note note){
  try{
  int vel = note.getVelocity();
  int pit = note.getPitch();
  println(pit+" "+vel);
  if(vel!=64)drums.sendNote(new Note(pit, vel, 2));
  }catch(Exception e){
  }
}

public void noteOff(Note note){
  try{
  int pit = note.getPitch();
  drums.sendNote(new Note(pit, 0, 0));
  }catch(Exception e){
  }
}

public void controllerIn(Controller controller){
  try{
  
    int num = controller.getNumber();
    int val = controller.getValue();
    drums.sendController(new Controller(num, val));
  }catch(Exception e){
  }
}

public void programChange(ProgramChange programChange){
  int num = programChange.getNumber();
}
public void muteall(){
  for(int i=0; i<127; i++){
      drums.sendNote(new Note(i, 0, 0));
      bass.sendNote(new Note(i, 0, 0));
      kboard.sendNote(new Note(i, 0, 0));
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "leteindien_002" });
  }
}
