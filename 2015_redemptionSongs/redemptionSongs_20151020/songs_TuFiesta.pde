class TuFiesta extends VZong {
  int[] drumpads = {
    36, 38, 42, 44, 47, 48, 37
  };

  String[][] drumspatterns;
  String[] basspatterns;
  int [][] bassnotes;

  String[] kbpatterns;
  int [][] kbnotes;

  int[] bellsnotes;

  int position;

  String[] lyricsbase;
  int lyricLine;

  int part = -3;
  int auxposition;

  TuFiesta() {
    lyrics = new String[1024][16];
    name = "Tu Fiesta";
    makeSong();
  }

  void makeSong() {
    beatMap = new BeatMap();
    //score.empty();
    drumstrack = new promidi.Track("drums", drumsout);
    basstrack = new promidi.Track("bass", bassout);
    basstrack2 = new promidi.Track("bass", bassout2);
    guitartrack = new promidi.Track("kboard", guitarout);
    bellstrack = new promidi.Track("bells", guitarout);

    drumstrack.setQuantization(Q._1_16);
    basstrack.setQuantization(Q._1_16);
    basstrack2.setQuantization(Q._1_16);
    guitartrack.setQuantization(Q._1_16);
    bellstrack.setQuantization(Q._1_16);

    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(0)); 
    guitarout.sendProgramChange(new ProgramChange(102));//62));

    quantization = 16;
    position = 0;
    int tempo = 117;

    compose();
    dolyrics();
    //
    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);
    song.addTrack(bellstrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*position/quantization);//512*bars);//
    sequencer.setLoopCount(0);
    sequencer.noLoop();
  }
  void dolyrics() {
    for (int i=0; i<position/quantization; i++) {
      for (int j=0; j<quantization; j++) {
        checkLyrics(i, j);
      }
    }
  }

  void compose() {
    for (part = -1; part<5; part++) {
      switch(part) {
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      default:
        part001();
        break;
      case 2:
        //case 4:
        part002();
      case 4:
        part002b();
        break;
      }
    }
  }
  void silence() {
    position+=quantization;
    bar=0;
  }
  void counter() {
    for (int i=0; i<quantization; i++) {
      if (i%4==0) {
        doDrums(position, i, 37, 120, 120);
      }
    }
    position+=quantization;
  }
  void part001() {  
    for (bar=0; bar<4*4; bar++) {
      switch(bar%4) {
      default: 
        riff000();
        break;
      case 2:
        //case 3: 
        riff000b();
        break;
      }
    }
  }
  void part002() {  
    for (bar=0; bar<4*2; bar++) {
      switch(bar%4) {
      default: 
        riff000c();
        break;
      case 2:
        riff001b();
        break;
      case 3:
        riff002b();
        break;
      }
    }
  }
  void part002b() {  
    for (bar=0; bar<4*4; bar++) {
      switch(bar%4) {
      default: 
        riff000c();
        break;
      case 2:
        riff001b();
        break;
      case 3:
        riff002b();
        break;
      }
    }
  }
  void riff000() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001(position, i);
      kboard001(position, i);
    }
    position+=quantization;
  }
  void riff000b() {
    for (int i=0; i<quantization; i++) {
      drums001b(position, i);
      bass001(position, i);
      kboard001(position, i);
    }
    position+=quantization;
  }
  void riff000c() {
    for (int i=0; i<quantization; i++) {
      drums002b(position, i);
      bass001(position, i);
      kboard001b(position, i);
    }
    position+=quantization;
  }
  void riff001() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bass002(position, i);
      kboard001(position, i);
    }
    position+=quantization;
  }
  void riff001b() {
    for (int i=0; i<quantization; i++) {
      drums002b(position, i);
      bass002(position, i);
      kboard002(position, i);
    }
    position+=quantization;
  }
  void riff002() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bass003(position, i);
      kboard003(position, i);
    }
    position+=quantization;
  }
  void riff002b() {
    for (int i=0; i<quantization; i++) {
      drums002b(position, i);
      bass003(position, i);
      kboard003(position, i);
    }
    position+=quantization;
  }
  /***************************/
  void drums001(int position, int i) {
    //if (i%4==0)
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    // if (i%4==2){
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    //}
    //if (i%8==4)
    //doDrums(position, i, 38, 96, 100);

    if (i%8==4) {// ||i%12==2){
      doDrums(position, i, 38, 120, 100);
      //doDrums(position, i+2, 38, 96, 100);
    }
  }
  void drums001b(int position, int i) {
    //if (i%4==0)
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    //if (i%4==2){
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    //}
    if (i%8==4)
      doDrums(position, i, 38, 96, 100);
    // if(i%2==0) doDrums(position, i, random(100)>50?53:56, 120, 127);
  }
  void drums002(int position, int i) {
    //if (i%4==0)
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    if (i%8==4) {//(i%4==2){
      doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    }
    if (i%2==0) doDrums(position, i, random(100)>50?53:56, 120, 127);
    //if (i%8==4)doDrums(position, i, 38, 96, 100);
    //doDrums(position, i, 38, int(random(80,127)), 100);
  }
  void drums002b(int position, int i) {
    //if (i%4==0)
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    //if (i%2==0){//(i%4==2){
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    //}
    if (i%8==4)doDrums(position, i, 38, 100, 127);
    else //doDrums(position, i, 38, 64, 100);
    doDrums(position, i, random(100)>50?53:56, 120, 127);
  }
  void bass001(int position, int i) {
    //if (i%2==0){
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doBass(position, i, 38+(i%4==2?12:0)-12, 1);
    else if (i%5==0)doBass(position, i, 38, 1);
    else if (i==9 || i==12) {
      doBass(position, i, 38+12, 1);
      doBass(position, i+2, 38+12, 2);
    }
  } 
  void bass002(int position, int i) {
    //if (i%2==0){
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doBass(position, i, 41+(i%4==2?12:0)-12, 1);
    else if (i%5==0)doBass(position, i, 41, 1);
    else if (i==9 || i==12) {
      doBass(position, i, 41+12, 1);
      doBass(position, i+2, 41+12, 2);
    }
  } 
  void bass003(int position, int i) {
    //if (i%2==0){
    if (i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15)   
      doBass(position, i, 40+(i%4==2?12:0)-12, 1);
    else if (i%5==0)doBass(position, i, 40, 1);
    else if (i==9 || i==12) {
      doBass(position, i, 40+12, 1);
      doBass(position, i+2, 40+12, 2);
    }
  }
  void kboard001(int position, int i) {
    //doKboard(position, i+1, 49+xtra+24, 1);//doBass(position, i, 47-24, 1);
    if (i%6==0)
      doKboard(position, i, 38+24, 1);
    //else if(i%12==2 || i%5==0)  doKboard(position, i, 38+24, 1);
    //else doKboard(position, i, 38+24+7, 1);
    if (i%3==1)doKboard(position, i, 38+24+(random(100)>50?3:7), 1);
    else if (i==0 || i==9 || i==12 || i==7) {
      doKboard(position, i, 38+12, 1);
      doKboard(position, i+2, 38+12, 2);
    }
  }

  void kboard001b(int position, int i) {
    //  //doKboard(position, i+1, 49+xtra+24, 1);//doBass(position, i, 47-24, 1);
    //  if(i%6==0)
    //    //doKboard(position, i, 38+24, 1);
    //   else if(i%4==3)
    //    //doKboard(position, i, 38+12+24+12, 1);
    //  else if(i%3==1)doKboard(position, i, 38+7+24, 1);
    //  //else doKboard(position, i, 38+7, 1);
    //  else if (i==0 || i==9 || i==7){//|| i==12 
    //      //doKboard(position, i, 38+12, 1);
    //      //doKboard(position, i+2, 38+12, 2);
    //    }
  }
  void kboard002(int position, int i) {
    //  //doKboard(position, i+1, 49+xtra+24, 1);//doBass(position, i, 47-24, 1);
    //  if(i%6==0)
    //    //doKboard(position, i, 38+24, 1);
    //   else if(i%4==3)
    //    //doKboard(position, i, 12+41+24+12, 1);
    //  else if(i%2==1) doKboard(position, i, 41+12+24, 1);
    // // else doKboard(position, i, 41+7, 1);
    //  else if (i==0 || i==9 || i==7){//|| i==12 
    //      //doKboard(position, i, 38+12, 1);
    //      //doKboard(position, i+2, 41+12, 2);
    //    }
  }
  void kboard003(int position, int i) {
    //  //doKboard(position, i+1, 49+xtra+24, 1);//doBass(position, i, 47-24, 1);
    //  if(i%6==0)
    //    //doKboard(position, i, 38+24, 1);
    //   else if(i%4==3)
    //    //doKboard(position, i, 12+40+24+12, 1);
    //    else if(i%2==1)doKboard(position, i, 38+12+24, 1);
    //   //else doKboard(position, i, 40+7, 1);
    //     else if (i==0 || i==9 || i==7){//|| i==12 
    //      //doKboard(position, i, 38+12, 1);
    //      //doKboard(position, i+2, 40+12, 2);
    //    }
  }



  void doDrums(int positiom, int i, int pitch, int minv, int maxv) {
    drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
    drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
    dobeat(position+i, pitch);
  }
  void doBass(int position, int i, int pitch, int duration) {
    basstrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    basstrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
    basstrack2.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    basstrack2.addEvent(new Note(pitch, 0, 1), position+i+duration);
  }
  void doKboard(int position, int i, int pitch, int duration) {
    guitartrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    guitartrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
  }
  void checkLyrics(int i, int j) {
    if (i==18 && j==0)presing(i, j, "mueve las caderas morena");
    if (i==20 && j==0)presing(i, j, "es por ti que bailan los breakers");
    if (i==22 && j==0)presing(i, j, "muestra tu sonrisa morena");
    if (i==24 && j==0)presing(i, j, "que en tu fiesta bailan los breakers");

    if (i==26 && j==0)presing(i, j, "mueve las caderas morena");
    if (i==28 && j==0)presing(i, j, "es por ti que bailan los sikuris");
    if (i==30 && j==0)presing(i, j, "muestra tu sonrisa morena");
    if (i==32 && j==0)presing(i, j, "que en tu fiesta bailan los sikuris");

    if (i==34 && j==0)presing(i, j, "mueve las caderas morena");
    if (i==36 && j==0)presing(i, j, "es por ti que tokan los bronces");
    if (i==38 && j==0)presing(i, j, "muestra tu sonrisa morena");
    if (i==40 && j==0)presing(i, j, "que en tu fiesta tokan los bronces");  

    if (i==58 && j==0)presing(i, j, "mueve las caderas morena");
    if (i==60 && j==0)presing(i, j, "es por ti que bailan los breakers");
    if (i==62 && j==0)presing(i, j, "muestra tu sonrisa morena");
    if (i==64 && j==0)presing(i, j, "que en tu fiesta bailan los breakers");

    if (i==66 && j==0)presing(i, j, "mueve las caderas morena");
    if (i==68 && j==0)presing(i, j, "es por ti que bailan los sikuris");
    if (i==70 && j==0)presing(i, j, "muestra tu sonrisa morena");
    if (i==72 && j==0)presing(i, j, "que en tu fiesta bailan los sikuris");
  }
  void presing(int i, int j, String l, boolean isfemale) {
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    lyrics[i][j] =l;
  }
}
