void doDrums(int i, int mode) {
  if (i%4!=2) {
    drums.sendNote(new Note(42, (int)random(80, 100), 1));
  }
  else {
    drums.sendNote(new Note(44, (int)random(100, 127), 1));
  }
  if (i%8==4) {//(i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)){
    drums.sendNote(new Note(38, int(i%2==0?random(100, 110):random(110, 125)), 1));
  }
  if (i%4==0 || i%3==0) {//(i==0 || i==1){//
    drums.sendNote(new Note(36, (int)random(100, 127), 1));
  }
}
void doBass(int i, int mode, int note) {
  //
  if (i%2==0 || i%3==0) {
    bass.sendNote(new Note(+36+note+12*(i%3!=0?0:1), (int)random(80, 100), 1 ));
    //score.addNote(i/4, 0, 0, 32+12*(i%3!=0?0:1), random(80,100), 0.25, 0.8, 64);
  }
  //if (random(100)>90)bass.sendNote(new Note(+36+note+7+12*(i%3!=0?0:1), (int)random(80, 100), 1 ));
  //
}
void doGuitar(int i, int mode, int scalle, int note, int gmode) {
  scalle--;
  {
    kboard.sendNote(new Note(scalle*12+note+12*(i%3!=0?0:1), (int)random(80,100), 1));//32 ));
    if(i%2==1)kboard.sendNote(new Note(scalle*12+note+1*(i%4!=0?7:random(100)>50?9:12), (int)random(80,100), 8));//32 ));
    // kboard.sendNote(
    if(i%3==0)kboard.sendNote(
    new Note((scalle+1)*12+int(modeQuantize(random(12, 12), sc.MINOR, note)), (int)random(110,127), int(random(32)))
    );
  }
}
void checkLyrics(int i) {
  //  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
  String rnd = ""+random(127);
  if(i%quantization==0)donmiguel.sing(rnd);
}

