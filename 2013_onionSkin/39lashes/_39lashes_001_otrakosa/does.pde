void doDrums(int i, int mode){
  if(i%2==0){
        drums.sendNote(new Note(42, (int)random(80,100) , 1));
    }else{
        drums.sendNote(new Note(44, (int)random(100,127) , 1));
    }
    if(i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)){
      //drums.sendNote(new Note(38, int(i%2==0?random(100,110):random(110,125)), 1));
    }
    if(i==2||i==4||i==8||i==10){//|| (part>4 && i==1) || (part>9 && i==5) || (part>11 && i==9) ){
      drums.sendNote(new Note(36, (int)random(100,127), 1));
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
    {
    //kboard.sendNote(new Note(scalle*12+note+12*(i%3!=0?0:1), (int)random(80,100), 24));//32 ));
    }
}
void checkLyrics(int i){
  //  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
}
