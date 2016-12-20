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
  delay(1000);
  score.tempo(90);
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
int part = -1;;

void compose(int i){
  switch(part){
    case -1:
    phrase0x(i);
    break;
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
      phrase3(i);
      break;
  }
}
void phrase0x(int i){
  riff009(i);
  if(i==11){bar=0;part++;}
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
void phrase3(int i){
  if(bar==1)riff008(i);
  if(bar==4 && i==11){bar=0;part++;}
}

void riff001(int i){//mim
    doDrums(i,0); 
    doBass(i,0,4);
    doGuitar(i,1,5,4,0);
}
void riff008(int i){//mim
    doDrums(i,0); 
    if(i==0){
      doBass(i,0,4);
      doGuitar(i,1,5,4,0);
    }
}
void riff001_2(int i){//mim otro
    doDrums(i,0); 
    doBass(i,1,4);
    doGuitar(i,1,5,4,0);
}
void riff002(int i){//LaM
    doDrums(i,0); 
    doBass(i,0,9);
    doGuitar(i,1,5,9,1);
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
    doBass(i,1,2);
    doGuitar(i,1,5,2,1);
}
void riff007(int i){//DoM -Mim
    boolean cond = i<12;
    doDrums(i,0); 
    doBass(i,1,cond?0:4);
    doGuitar(i,1,5,cond?0:4,cond?1:0);
}
void riff009(int i){//just drums
    doDrums(i,0); 
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
void doDrums(int i, int mode){
  if(i%2==0){
        drums.sendNote(new Note(42, (int)random(80,100) , 1));
        //score.addNote(i/4, 9, 0, 42, , 0.25, 0.8, 64);
    }else{
        drums.sendNote(new Note(44, (int)random(100,127) , 1));
        //score.addNote(i/4, 9, 0, 44, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    }
    if(i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)){
      //if(true){
      //if(part>3)
      drums.sendNote(new Note(38, int(i%2==0?random(100,110):random(110,125)), 1));
      //score.addNote(1*i/4+0*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      //score.addNote(1*i/4+2*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      //score.addNote(1*i/4+4*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    }
    if(i==2||i==4||i==8||i==10){//|| (part>4 && i==1) || (part>9 && i==5) || (part>11 && i==9) ){
      drums.sendNote(new Note(36, (int)random(100,127), 1));
      //score.addNote(i/4, 9, 0, 36, random(120,127), 0.25, 0.8, 64);
    }
}
void doBass(int i, int mode, int note){
    if(i%2==0 || i%3==0){
      bass.sendNote(new Note(+36+note+12*(i%3!=0?0:1), (int)random(80,100), 1 ));
      //score.addNote(i/4, 0, 0, 32+12*(i%3!=0?0:1), random(80,100), 0.25, 0.8, 64);
    }else if(mode==1){
      bass.sendNote(new Note(+36+note, (int)random(80,100), 1 ));
    }
}
void doGuitar(int i, int mode, int scalle, int note, int gmode){
  scalle--;
    //if(i%2==1)//random(100)>50)
    //if(i==0)
    {
    kboard.sendNote(new Note(scalle*12+note+12*(i%3!=0?0:1), (int)random(80,100), 24));//32 ));
    if(mode!=1)kboard.sendNote(new Note(scalle*12+note+3+(gmode==0?0:1)+12*(i%2!=0?0:1), (int)random(80,100), 16));//24 ));
    kboard.sendNote(new Note(scalle*12+note+7+12*(i%4!=0?0:1), (int)random(80,100), 1));//16 ));
    if(mode!=1)kboard.sendNote(new Note(scalle*12+note+12+12*(i%4!=0?0:1), (int)random(80,100), 8));//8 ));  
    }
}
void checkLyrics(int i){
  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
  if(part==2 && bar==3 && i==0)donmiguel.sing("deja su huella en el viento");
  if(part==2 && bar==5 && i==0)donmiguel.sing("el aguila le da el vuelo");
  if(part==2 && bar==7 && i==0)donmiguel.sing("y lo cobija el silencio");
  
  if(part==3 && bar==1 && i==0)donmiguel.sing("nunka se quejó del frío");
  if(part==3 && bar==3 && i==0)donmiguel.sing("nunka se quejó del sueño");
  if(part==3 && bar==5 && i==0)donmiguel.sing("el pobre siente su paso");
  if(part==3 && bar==7 && i==0)donmiguel.sing("y lo sigue como ciego");
  
  if(part==4 && bar==1 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==4 && bar==3 && i==0)donmiguel.sing("por aquí, por allí, por allá");
  if(part==4 && bar==5 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==4 && bar==7 && i==0)donmiguel.sing("correlé que te van a matar");
  if(part==4 && bar==9 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==4 && bar==11 && i==0)donmiguel.sing("correlé que te van a matar");
  if(part==4 && bar==13 && i==0)donmiguel.sing("correlé, correlé, correláaaa");
  
  if(part==7 && bar==1 && i==0)donmiguel.sing("su cabeza es rematada");
  if(part==7 && bar==3 && i==0)donmiguel.sing("por cuervos con garras de oro");
  if(part==7 && bar==5 && i==0)donmiguel.sing("como lo ha crucificado");
  if(part==7 && bar==7 && i==0)donmiguel.sing("la furia del poderoso");
  
  if(part==8 && bar==1 && i==0)donmiguel.sing("hijo de la rebeldía");
  if(part==8 && bar==3 && i==0)donmiguel.sing("lo siguen veinte más veinte");
  if(part==8 && bar==5 && i==0)donmiguel.sing("porque regala su viiiiidaa");
  if(part==8 && bar==7 && i==0)donmiguel.sing("ellos le quieren dar muerte");
  
  if(part==9 && bar==1 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==9 && bar==3 && i==0)donmiguel.sing("por aquí, por allí, por allá");
  if(part==9 && bar==5 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==9 && bar==7 && i==0)donmiguel.sing("correlé que te van a matar");
  if(part==9 && bar==9 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==9 && bar==11 && i==0)donmiguel.sing("correlé que te van a matar");
  if(part==9 && bar==13 && i==0)donmiguel.sing("correlé, correlé, correláaaa");
  
  if(part==12 && bar==1 && i==0)donmiguel.sing("hijo de la rebeldía");
  if(part==12 && bar==3 && i==0)donmiguel.sing("lo siguen 20 más 20");
  if(part==12 && bar==5 && i==0)donmiguel.sing("porque regala su viiiiidaa");
  if(part==12 && bar==7 && i==0)donmiguel.sing("ellos le quieren dar muerte");
  
  if(part==13 && bar==1 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==13 && bar==3 && i==0)donmiguel.sing("por aquí, por allí, por allá");
  if(part==13 && bar==5 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==13 && bar==7 && i==0)donmiguel.sing("correlé que te van a matar");
  if(part==13 && bar==9 && i==0)donmiguel.sing("correlé, correlé, correlá");
  if(part==13 && bar==11 && i==0)donmiguel.sing("correlé que te van a matar");
  if(part==13 && bar==13 && i==0)donmiguel.sing("correlé, correlé, correláaa");
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
  void sing(String $1){
    try{
      //if(random(100)>50){
      //  speech1.speak($1);
      //}else{
        speech2.speak($1);
      //}
    }
    catch(Exception e){
    }
  }
}

