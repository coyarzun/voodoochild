void doDrums(int i, int mode){
  if(i%2==0){
        drums.sendNote(new Note(42, (int)random(80,100) , 1));
        //score.addNote(i/4, 9, 0, 42, , 0.25, 0.8, 64);
    }else{
        drums.sendNote(new Note(44, (int)random(100,127) , 1));
        //score.addNote(i/4, 9, 0, 44, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    }
    if(i%3==0 || (random(10)>5 && false)){
      drums.sendNote(new Note(38, int(i%2==0?random(100,110):random(110,125)), 1));
      //score.addNote(1*i/4+0*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      //score.addNote(1*i/4+2*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      //score.addNote(1*i/4+4*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
    }
    if(i==2||i==4||i==8||i==10){
      drums.sendNote(new Note(35, (int)random(100,127), 1));
      //score.addNote(i/4, 9, 0, 36, random(120,127), 0.25, 0.8, 64);
    }
    if(i%2==0 || i%3==0){
      bass.sendNote(new Note(32+12*(i%3!=0?0:1), (int)random(80,100), 1 ));
      //score.addNote(i/4, 0, 0, 32+12*(i%3!=0?0:1), random(80,100), 0.25, 0.8, 64);
    }
}
void doGuitar(int i, int mode){
    //if(i%2==1)//random(100)>50)
    //if(i==0)
    {
    kboard.sendNote(new Note(64+12*(i%3!=0?0:1), (int)random(80,100), 32 ));
    kboard.sendNote(new Note(64+3+12*(i%2!=0?0:1), (int)random(80,100), 24 ));
    kboard.sendNote(new Note(64+7+12*(i%4!=0?0:1), (int)random(80,100), 16 ));
    kboard.sendNote(new Note(64+12+12*(i%4!=0?0:1), (int)random(80,100), 8 ));
    }
}
