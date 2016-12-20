void doDrums(int i, int mode) {
  //if (i%4!=2) {
  drums.sendNote(new Note(42, (int)random(80, 100), 1));
  //}
  /*
  else {
   drums.sendNote(new Note(44, (int)random(100, 127), 1));
   }*/
  if (i%8==4){// || (random(10)>5)) {//(i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)){//i%7==3 || 
    drums.sendNote(new Note(38, int(i%2==0?random(100, 110):random(110, 125)), 1));
  }
  if (i%8==0 || i%16==7 || i%8==6) {//|| i%4==3) {//(i==0 || i==1){//
    drums.sendNote(new Note(36, (int)random(100, 127), 1));
  }
}
void doBass(int i, int mode, int note) {
  //
  //mode =3 ;
  int basescale = 24;
  if (i==0)      bass.sendNote(new Note(basescale+note, (int)random(100, 120), 8 ));//<--
  if(mode>=1)if (i==2)      bass.sendNote(new Note(basescale+note, (int)random(80, 100), 1 ));
  if (mode>=2) {
    if (i==1)      bass.sendNote(new Note(basescale+note+12+5, (int)random(80, 100), 1 ));
    if (i==3)      bass.sendNote(new Note(basescale+note+7, (int)random(80, 100), 1 ));
  }
  if (i==4)      bass.sendNote(new Note(basescale+note+12, (int)random(100, 120), 1 ));//<--
  if(mode>=1)if (i==6)      bass.sendNote(new Note(basescale+note+24, (int)random(80, 100), 1 ));
  if (mode>=3) {
    if (i==5)      bass.sendNote(new Note(basescale+note+24, (int)random(80, 100), 1 ));
  }
  if (i==7)      bass.sendNote(new Note(basescale+note+12+1, (int)random(100, 120), 1 ));//<--
  if(mode>=2)if (i==9)      bass.sendNote(new Note(basescale+note+7, (int)random(80, 100), 1 ));
  if (mode>=3) {
    if (i==8)      bass.sendNote(new Note(basescale+note+5, (int)random(80, 100), 1 ));
    
  }
  if (i==10)     bass.sendNote(new Note(basescale+note+10, (int)random(100, 120), 1 ));//<--
  if (mode>=2) {
    if (i==11)     bass.sendNote(new Note(basescale+note+7, (int)random(80, 100), 1 ));
  }
  if (i==12)     bass.sendNote(new Note(basescale+note+12, (int)random(100, 120), 1 ));//<--
  if (mode>=3) {
    if (i==13)     bass.sendNote(new Note(basescale+note+13, (int)random(80, 100), 1 ));
    if (i==14)     bass.sendNote(new Note(basescale+note+0+5, (int)random(80, 100), 1 ));
    if (i==15)     bass.sendNote(new Note(basescale+note+0+7, (int)random(80, 100), 1 ));
  }
}
void doGuitar(int i, int mode, int scalle, int note, int gmode) {
  //scalle;
  scalle+=2;
  //scalle--;
  int basescale = scalle*12;
  {
    if(i%2==0)kboard.sendNote(new Note(basescale+note+12*(i%3!=0?0:1), (int)random(80,100), 1));//32 ));
    //kboard.sendNote(new Note(basescale+note+12+i==0?0:i==4?12:i==10?10:12, (int)random(80,100), 32));//32 ));
    //kboard.sendNote(new Note(basescale+note+12*(i%3!=0?0:1), (int)random(80,100), 32));//32 ));
    if(i%2==1){
      kboard.sendNote(new Note(basescale+note+1*(i%4!=0?7:random(100)>50?9:12), (int)random(80,100), 1));//32 ));
    }else{
      /*
      if (i==0 && random(100)>90)      kboard.sendNote(new Note(basescale+note, (int)random(60, 80), 32 ));//<--
      if (i==4 && random(100)>80)      kboard.sendNote(new Note(basescale+note+12, (int)random(60, 80), 32 ));//<--
      */
      if (i==7 && random(100)>50)      kboard.sendNote(new Note(basescale+note+12+1, (int)random(60, 80), 1 ));//<--
      /*
      if (i==10 && random(100)>90)     kboard.sendNote(new Note(basescale+note+10, (int)random(60, 80), 32 ));//<--
      if (i==12 && random(100)>90)     kboard.sendNote(new Note(basescale+note+12, (int)random(60, 80), 32 ));//<--
      */
     }
  }
}
void checkLyrics(int i) {
  //  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
  String rnd = ""+random(127);
  //if(i%quantization==0)donmiguel.sing(rnd);
}

