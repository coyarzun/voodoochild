void doDrums(int i, int mode) {
  //if (i%4!=2) {
  drums.sendNote(new Note(42, (int)random(80, 100), 1));
  //}
  /*
  else {
   drums.sendNote(new Note(44, (int)random(100, 127), 1));
   }*/
  if (i==3 || i==11 ){//|| i==0 || i==8//// || (random(10)>5)) {//(i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)){//i%7==3 || 
    if(mode>1)drums.sendNote(new Note(38, int(i%2==0?random(100, 110):random(110, 125)), 1));
  }
  if(i%3==0 || random(100)>80){
    if(mode>3)drums.sendNote(new Note(71, int(i%2==0?random(60, 80):random(60, 80)), 1));
  }
  if(i%3==2  || random(100)>80 ){
    if(mode>3)drums.sendNote(new Note(72, int(i%2==0?random(60, 80):random(60, 80)), 1));
  }
    if(mode>4&&i%2==0)drums.sendNote(new Note(i%2==0?73:74, int(i%3==0?random(80, 90):random(110, 125)), 1));
    if(mode>2)drums.sendNote(new Note(random(100)>50?60:61, (int)random(120, 127), 1));
  if(i==5 || i==6 || i==7 ||  i==8 || i==9 || i==14){
    if(mode>1)drums.sendNote(new Note(39, int(i%2==0?random(100, 110):random(110, 125)), 1));
  }
  if (i==15 || i==2 || i==9 || i==11 || i==13) {//i==2 ||i==10 ||// (i%8==0 || i%16==7 || i%8==6) {//|| i%4==3) {//(i==0 || i==1){//
    if(mode>0 && part<=40)drums.sendNote(new Note(36, (int)random(100, 127), 1));
  }
}
void doBass(int i, int mode, int note) {
  //
  //mode =3 ;
  int basescale = 24+12*2;
  if (i==0)     bass.sendNote(new Note(basescale+note+12*(random(100)>50?1:0), (int)random(100, 120), 1));//8 ));//<--
  if (i==1)     bass.sendNote(new Note(basescale+note+12*(random(100)>50?1:0), (int)random(100, 120), 1));//8 ));//<--
  //if (i==1)     bass.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//8 ));//<--
  //if (i==2)     bass.sendNote(new Note(basescale+note, (int)random(100, 120), 1));//2 ));//<--
  //if (i==3)     bass.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//8 ));//<--
  //if (i==4)      bass.sendNote(new Note(basescale+note+12, (int)random(100, 120), 1));//8 ));//<--
  //if (i==5)      bass.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//8 ));//<--
  if (i==6)      bass.sendNote(new Note(basescale+note+12+1+12*(random(100)>50?1:0), (int)random(100, 120), 1));//4 ));//<--
  if (i==7)      bass.sendNote(new Note(basescale+note+12+1+12+12*(random(100)>50?1:0), (int)random(100, 120), 1));//4 ));//<--
  //if (i==8)      bass.sendNote(new Note(basescale+note+12+1+12, (int)random(100, 120), 1));//4 ));//<--
  //if (i==9)      bass.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//4 ));//<--
  if (i==10)     bass.sendNote(new Note(basescale+note+10+12*(random(100)>50?1:0), (int)random(100, 120), 1));//8 ));//<--
  if (i==12)     bass.sendNote(new Note(basescale+note+10+12*(random(100)>50?1:0), (int)random(100, 120), 1));//8 ));//<--
  if (i==13)     bass.sendNote(new Note(basescale+note+10+12*(random(100)>50?1:0), (int)random(100, 120), 1));//8 ));//<--
  //if (i==11)      bass.sendNote(new Note(basescale+note+10+12, (int)random(100, 120), 1));//4 ));//<--
  //if (i==12)      bass.sendNote(new Note(basescale+note+10+12, (int)random(100, 120), 1));//4 ));//<--
  //if (i==13)      bass.sendNote(new Note(basescale+note+10+12+1, (int)random(100, 120),1));// 4 ));//<--
  //if (i==14)     bass.sendNote(new Note(basescale+note+12, (int)random(100, 120), 1));//8 ));//<--
  if (i==14)     bass.sendNote(new Note(basescale+note+12*(random(100)>50?1:0), (int)random(100, 120), 1));//8 ));//<--
}
void doGuitar(int i, int mode, int scalle, int note, int gmode) {
  //scalle;
  //scalle++;
  scalle-=3;
  int basescale = scalle*12;
  //i++;
  //i%=16;
  if (i==0)     kboard.sendNote(new Note(basescale+note, (int)random(100, 120), 1));//8 ));//<--
  if (i==1)     kboard.sendNote(new Note(basescale+note, (int)random(100, 120), 1));//8 ));//<--
  //if (i==1)     bass.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//8 ));//<--
  if (i==2)     kboard.sendNote(new Note(basescale+note, (int)random(100, 120), 1));//2 ));//<--
  if (i==3)     kboard.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//8 ));//<--
  if (i==4)      kboard.sendNote(new Note(basescale+note+12, (int)random(100, 120), 1));//8 ));//<--
  if (i==5)      kboard.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//8 ));//<--
  
  if (i==6)      kboard.sendNote(new Note(basescale+note+12+1, (int)random(100, 120), 1));//4 ));//<--
  if (i==7)      kboard.sendNote(new Note(basescale+note+12+1+12, (int)random(100, 120), 1));//4 ));//<--
  
  if (i==8)      kboard.sendNote(new Note(basescale+note+12+1+12, (int)random(100, 120), 1));//4 ));//<--
  if (i==9)      kboard.sendNote(new Note(basescale+note+12+12, (int)random(100, 120), 1));//4 ));//<--
  
  if (i==10)     kboard.sendNote(new Note(basescale+note+10, (int)random(100, 120), 1));//8 ));//<--
  if (i==12)     kboard.sendNote(new Note(basescale+note+10, (int)random(100, 120), 1));//8 ));//<--
  if (i==13)     kboard.sendNote(new Note(basescale+note+10, (int)random(100, 120), 1));//8 ));//<--
  
  if (i==11)      kboard.sendNote(new Note(basescale+note+10+12, (int)random(100, 120), 1));//4 ));//<--
  if (i==12)      kboard.sendNote(new Note(basescale+note+10+12, (int)random(100, 120), 1));//4 ));//<--
  if (i==13)      kboard.sendNote(new Note(basescale+note+10+12+1, (int)random(100, 120),1));// 4 ));//<--
  //if (i==14)     bass.sendNote(new Note(basescale+note+12, (int)random(100, 120), 1));//8 ));//<--
  if (i==14)     kboard.sendNote(new Note(basescale+note, (int)random(100, 120), 1));//8 ));//<--
}
void checkLyrics(int i) {
  //  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
  String rnd = ""+(part);//random(127);
  if(i%quantization==0)donmiguel.sing(rnd);
}

