void doDrums(int i, int mode) {
  /*
  //if (i%4!=2) {
  drumstrack.addEvent(new Note(42, (int)random(80, 100), 1), part*quantization+i);
  drumstrack.addEvent(new Note(42, 0, 1), part*quantization+i+1);
  //}
  
  else {
   drums.addEvent(new Note(44, (int)random(100, 127), 1));
   }
  if (i==3 || i==11 ) {//|| i==0 || i==8//// || (random(10)>5)) {//(i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)){//i%7==3 || 
    if (mode>1) {
      drumstrack.addEvent(new Note(38, int(i%2==0?random(100, 110):random(110, 125)), 1), part*quantization+i);
      drumstrack.addEvent(new Note(38, 0, 1), part*quantization+i+1);
    }
  }
  if (i%3==0 || random(100)>80) {
    if (mode>3) {
      drumstrack.addEvent(new Note(71, int(i%2==0?random(60, 80):random(60, 80)), 1), part*quantization+i);
      drumstrack.addEvent(new Note(71, 0, 1), part*quantization+i+1);
    }
  }
  if (i%3==2  || random(100)>80 ) {
    if (mode>3) {
      drumstrack.addEvent(new Note(72, int(i%2==0?random(60, 80):random(60, 80)), 1), part*quantization+i);
      drumstrack.addEvent(new Note(72, 0, 1), part*quantization+i+1);
    }
  }
  if (mode>4&&i%2==0) {
    int nn = i%2==0?73:74;
    drumstrack.addEvent(new Note(nn, int(i%3==0?random(80, 90):random(110, 125)), 1), part*quantization+i);
    drumstrack.addEvent(new Note(nn, 0, 1), part*quantization+i+1);
  }
  if (mode>2) {
    int nn = random(100)>50?60:61;
    drumstrack.addEvent(new Note(nn, (int)random(120, 127), 1), part*quantization+i);
    drumstrack.addEvent(new Note(nn, 0, 1), part*quantization+i+1);
  }
  if (i==5 || i==6 || i==7 ||  i==8 || i==9 || i==14) {
    if (mode>1) {
      drumstrack.addEvent(new Note(39, int(i%2==0?random(100, 110):random(110, 125)), 1), part*quantization+i);
      drumstrack.addEvent(new Note(39, 0, 1), part*quantization+i+1);
    }
  }
  if (i==15 || i==2 || i==9 || i==11 || i==13) {//i==2 ||i==10 ||// (i%8==0 || i%16==7 || i%8==6) {//|| i%4==3) {//(i==0 || i==1){//
    if (mode>0 && part<=40) {
      drumstrack.addEvent(new Note(36, (int)random(100, 127), 1), part*quantization+i);
      drumstrack.addEvent(new Note(36, 0, 1), part*quantization+i+1);
    }
  }
  */
}
void doBass(int position, int i, int pitch, int duration) {
  int basescale = 32;
  int nn = basescale+pitch;//+12*(random(100)>50?1:0);
  basstrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);//8 ));//<--
  basstrack.addEvent(new Note(nn, 0, 1), position+i+duration);
}
void doGuitar(int i, int mode, int scalle, int note, int gmode) {
  //guitartrack.addEvent(new Note(basescale+note, (int)random(100, 120), 1), part*quantization+i);//8 ));//<--
  //guitartrack.addEvent(new Note(basescale+note, 0, 1), part*quantization+i+1);//8 ));//<--
}
void checkLyrics(int i) {
  //  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
  //String rnd = ""+(part);//random(127);
  //if (i%quantization==0)donmiguel.sing(rnd);
}

