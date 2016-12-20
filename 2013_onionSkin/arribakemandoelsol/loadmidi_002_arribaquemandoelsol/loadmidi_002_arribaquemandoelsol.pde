import arb.soundcipher.*;

SCScore score  = new SCScore();
SoundCipher sc = new SoundCipher(this);

int somecounter;
int teempo = 320;
void setup(){
  score.addCallbackListener(this);
  score.empty();
  score.addMidiFile("/Users/coyarzun/Documents/Processing/voodoo/wishloadamidi/loadmidi_002/data/arribaquemandoelsol.mid");//tempo 180
  //println(score.numerator+"/"+score.denominator);
  //KORG A12 ARPG ON
  //BOSS U001 U19 FLANGE
  score.tempo(teempo);
  for(int i=0; i<965*4; i+=4){
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
  score.setMidiDeviceOutput(1);
  sc.setMidiDeviceOutput(1);
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
    somecounter++;
    //sc.playNote(0, 9,0,42,int(random(100,120)),0.125,1,64);
  }else
  if(callbackID==2){
    //sc.playNote(0, 9,0,38,int(random(100,120)),0.125,1,64);
  }
}
