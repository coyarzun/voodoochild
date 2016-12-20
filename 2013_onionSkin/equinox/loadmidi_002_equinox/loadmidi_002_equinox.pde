import arb.soundcipher.*;

SCScore score  = new SCScore();
SoundCipher sc = new SoundCipher(this);

int somecounter;

void setup(){


  score.addCallbackListener(this);
  score.empty();
  score.addMidiFile("/Users/coyarzun/Documents/Processing/voodoochild/onionSkin/equinox/loadmidi_002_equinox/data/equinox.mid");//tempo 180
  println(score.numerator+"/"+score.denominator);
  score.tempo(220);
  for(int i=0; i<32*150; i++){
    double pos = i/score.denominator;//+.125;
    score.addCallback(pos, 1);
    //score.addNote( i,9,0,42,int(random(120,127)),0.125,1,64 );
    //if((i+5)%4==0 )score.addNote(pos,9,0,36,int(random(120,127)),0.25,1,64 );//|| i%2==0&&(random(100)>50)
    //sif(i%8==0 || random(100)>500)score.addNote(pos,9,0,38,int(random(120,127)),0.25,1,64 );
  }
  score.setMidiDeviceOutput(4);
  score.play();
}
void loop(){
  //score.tempo(180*3);
}
void keyPressed(){
  //if(keyCode==32)score.play();
}
void handleCallbacks(int callbackID) {
  if(callbackID==1){
    //println(somecounter+"\t"+somecounter%16);
    somecounter++;
    //sc.playNote(0, 9,0,42,120,0.125,1,64);
  }
}
