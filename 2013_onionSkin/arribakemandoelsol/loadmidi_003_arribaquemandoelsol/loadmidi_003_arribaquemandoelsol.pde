import arb.soundcipher.*;

SCScore score  = new SCScore();
SoundCipher sc = new SoundCipher(this);

int somecounter;
int teempo = 320;
void setup(){
  score.addCallbackListener(this);
  score.empty();
  score.addMidiFile("/Users/coyarzun/Documents/Processing/voodoochild/onionSkin/arribakemandoelsol/loadmidi_003_arribaquemandoelsol/data/arribaquemandoelsol.mid");//tempo 180
  //println(score.numerator+"/"+score.denominator);
  //KORG A12 ARPG ON
  //BOSS U001 U19 FLANGE
  score.tempo(teempo);
  for(int i=0; i<965*4; i+=4){
    if(i==0){
      score.addMIDIMessage(0,sc.PROGRAM_CHANGE,2,66,0);
      score.addMIDIMessage(0,sc.PROGRAM_CHANGE,0,12*8,0);
      score.addMIDIMessage(0,sc.CONTROL_CHANGE,9,0,1);
      score.addMIDIMessage(0,sc.PROGRAM_CHANGE,9,0,0);
    }
      /*
      double startBeat,
      int type,
      double channel,
      double val1,
      double val2
      */
    double pos = i/score.denominator;//+.125;
    //if(pos%4==1 || pos%4==2)
    score.addNote( pos,9,0,42,int(random(120,127)),0.125,1,64 );
    score.addNote( pos,13,0,69+random(100)>50?0:12,int(random(120,127)),0.125,1,64 );
    if(pos%4==2){//score.addCallback(pos, 2);
        score.addNote( pos,9,0,38,int(random(120,127)),0.125,1,64 );
    }
    if(pos%8==1)score.addNote( pos,9,0,36,int(random(120,127)),0.125,1,64 );
    score.update();
    score.addCallback(pos, 1);
  }
  score.update();
  score.setMidiDeviceOutput(4);
  sc.setMidiDeviceOutput(4);
  //score.play();
}
void draw(){
}
void keyPressed(){
  if(keyCode==32){
    //score.play();
    score.play();
    println("pp");
  }
}
void handleCallbacks(int callbackID) {
  if(callbackID==1){
    println(somecounter+"\t"+somecounter%16);
    score.tempo(teempo);
    //score.addMIDIMessage(0,sc.CONTROL_CHANGE,9,7,120);
    somecounter++;
    //sc.playNote(0, 9,0,42,int(random(100,120)),0.125,1,64);
  }else
  if(callbackID==2){
    //sc.playNote(0, 9,0,38,int(random(100,120)),0.125,1,64);
  }
}
