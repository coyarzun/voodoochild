class Reptile extends VZong {
  //Song song;

  int[] drumpads = {
    36, 38, 42, 44, 47, 48, 37
  };//46,47,48,42};

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

  Reptile() {
    lyrics = new String[1024][16];
    name = "Reptile";
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

    //bassout.sendProgramChange(new ProgramChange(11)); 
    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(3)); 
    guitarout.sendProgramChange(new ProgramChange(5));//62)); 
    //bellsout.sendProgramChange(new ProgramChange(76));//62));//76)); 
    //score.empty();
    quantization = 16;
    position = 0;
    int tempo = 140;//140;

    //metacompose();
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
    sequencer.setLoopStartPoint(4);
    sequencer.setLoopEndPoint(512*position/quantization);//512*bars);//
    sequencer.setLoopCount(-1);
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
    for (part = -1; part<14; part++) {
      switch(part) {
      case -1:
        //case 9:
        silence();
        break;
      case 0:
        counter();
        break;
      case 1:
      case 9:
        part000x();
        break;
      case 2:
      case 5:
      case 10:
        part000xx();
        break;
      case 3:
      case 6:
      case 11:
        part000();
        break;
      case 4:
      case 7:
      case 12:
        part001();
        break;
      case 8:
        part002(); 
        break; 
      default:
        part001();
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
  void part000() {  
    for (bar=0; bar<4*4; bar++) {
      if (bar%4==0)riff000a();
      if (bar%4==1)riff000b();
      if (bar%4==2)riff000c();
      if (bar%4==3)riff000d();
    }
  }
  void part000x() {  
    for (bar=0; bar<4*2; bar++) {
      if (bar%4==0)riff000ax();
      if (bar%4==1)riff000bx();
      if (bar%4==2)riff000cx();
      if (bar%4==3)riff000dx();
    }
  }
  void part000xx() {  
    for (bar=0; bar<4*2; bar++) {
      if (bar%4==0)riff000axx();
      if (bar%4==1)riff000bxx();
      if (bar%4==2)riff000cxx();
      if (bar%4==3)riff000dxx();
    }
  }
  void part001() {  
    for (bar=0; bar<4*4; bar++) {
      if (bar%4==0)riff001a();
      if (bar%4==1)riff001b();
      if (bar%4==2)riff001c();
      if (bar%4==3)riff001d();
    }
  }
  void part002() {  
    for (bar=0; bar<4*4; bar++) {
      if (bar%4==0)riff002a();
      if (bar%4==1)riff002b();
      if (bar%4==2)riff002c();
      if (bar%4==3)riff002d();
    }
  }
  void riff000a() {
    for (int i=0; i<quantization; i++) {
      drums000b(position, i);
      bass000a(position, i);
      kboard000a(position, i);
    }
    position+=quantization;
  }
  void riff000b() {
    for (int i=0; i<quantization; i++) {
      drums000b(position, i);
      bass000b(position, i);
      kboard000b(position, i);
    }
    position+=quantization;
  }
  void riff000c() {
    for (int i=0; i<quantization; i++) {
      drums000b(position, i);
      bass000c(position, i);
      kboard000c(position, i);
    }
    position+=quantization;
  }
  void riff000d() {
    for (int i=0; i<quantization; i++) {
      drums000b(position, i);
      bass000d(position, i);
      kboard000d(position, i);
    }
    position+=quantization;
  }

  void riff000ax() {
    for (int i=0; i<quantization; i++) {
      drums000x(position, i);

      kboard000a(position, i);
    }
    position+=quantization;
  }
  void riff000bx() {
    for (int i=0; i<quantization; i++) {
      drums000x(position, i);

      kboard000b(position, i);
    }
    position+=quantization;
  }
  void riff000cx() {
    for (int i=0; i<quantization; i++) {
      drums000x(position, i);

      kboard000c(position, i);
    }
    position+=quantization;
  }
  void riff000dx() {
    for (int i=0; i<quantization; i++) {
      drums000x(position, i);

      kboard000d(position, i);
    }
    position+=quantization;
  }

  void riff000axx() {
    for (int i=0; i<quantization; i++) {
      drums000xx(position, i);

      kboard000a(position, i);
    }
    position+=quantization;
  }
  void riff000bxx() {
    for (int i=0; i<quantization; i++) {
      drums000xx(position, i);

      kboard000b(position, i);
    }
    position+=quantization;
  }
  void riff000cxx() {
    for (int i=0; i<quantization; i++) {
      drums000xx(position, i);

      kboard000c(position, i);
    }
    position+=quantization;
  }
  void riff000dxx() {
    for (int i=0; i<quantization; i++) {
      drums000xx(position, i);

      kboard000d(position, i);
    }
    position+=quantization;
  }

  void riff001a() {
    for (int i=0; i<quantization; i++) {
      drums000(position, i);
      bass001a(position, i);
      kboard000a(position, i);
    }
    position+=quantization;
  }
  void riff001b() {
    for (int i=0; i<quantization; i++) {
      drums000(position, i);
      bass001b(position, i);
      kboard000b(position, i);
    }
    position+=quantization;
  }
  void riff001c() {
    for (int i=0; i<quantization; i++) {
      drums000(position, i);
      bass001c(position, i);
      kboard000c(position, i);
    }
    position+=quantization;
  }
  void riff001d() {
    for (int i=0; i<quantization; i++) {
      drums000(position, i);
      bass001d(position, i);
      kboard000d(position, i);
    }
    position+=quantization;
  }

  void riff002a() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bass002a(position, i);
    }
    position+=quantization;
  }
  void riff002b() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bass002b(position, i);
    }
    position+=quantization;
  }
  void riff002c() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bass002c(position, i);
    }
    position+=quantization;
  }
  void riff002d() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bass002d(position, i);
    }
    position+=quantization;
  }

  /***************************/
  int raska;

  void drums000(int position, int i) {
    if (i%4==0) doDrums(position, i, 36, 110, 120);
    if (i%8==4) doDrums(position, i, 38, 110, 120);
    doDrums(position, i, 44, 110, 120);
  }
  void drums000b(int position, int i) {
    if (i%4==0) doDrums(position, i, 36, 110, 120);
    //if (i%8==4) doDrums(position, i, 38, 110, 120);
    doDrums(position, i, 44, 110, 120);
  }
  void drums000x(int position, int i) {
    //if (i%4==0) doDrums(position, i, 36, 110, 120);
    //if (i%8==4) doDrums(position, i, 38, 110, 120);
    doDrums(position, i, 44, 110, 120);
  }
  void drums000xx(int position, int i) {
    if (i%4==0) doDrums(position, i, 36, 110, 120);
    //if (i%8==4) doDrums(position, i, 38, 110, 120);
    doDrums(position, i, 44, 110, 120);
  }

  void drums002(int position, int i) {
    if (i%8==0) doDrums(position, i, 36, 110, 120);
    if (i%16==8) doDrums(position, i, 38, 110, 120);
    doDrums(position, i, 44, 110, 120);
  }

  void bass000a(int position, int i) {
    if (i==0)  doBass(position, i, 43-12, 4);
    if (i==4)  doBass(position, i, 43-12, 6);
    if (i==10)  doBass(position, i, 43+2-12, 2);
    if (i==12) doBass(position, i, 43+5-12, 2);
    if (i==14)  doBass(position, i, 43+7-12, 6);
  }
  void bass000b(int position, int i) {
    if (i==4)  doBass(position, i, 43+7-12, 4);
    if (i==8)  doBass(position, i, 43+7-12, 2);
    if (i==10) doBass(position, i, 43+5-12, 4);
    if (i==14)  doBass(position, i, 43+3-12, 2);
  }
  void bass000c(int position, int i) {
    if (i==0)  doBass(position, i, 43+5-12, 2);
    if (i==4)  doBass(position, i, 43+8-12, 2);
    if (i==6) doBass(position, i, 43-12, 10+16);
  }
  void bass000d(int position, int i) {
  }

  void bass001a(int position, int i) {
    if (i%2==0)  doBass(position, i, 43-12, 4);
  }
  void bass001b(int position, int i) {
    if (i%2==0)  doBass(position, i, 43-2-12, 4);
  }
  void bass001c(int position, int i) {
    if (i%2==0)  doBass(position, i, 43+8-12, 4);
  }
  void bass001d(int position, int i) {
    if (i%2==0)  doBass(position, i, 43+8-12, 4);
  }

  void bass002a(int position, int i) {
    if (i%4==0)  doBass(position, i, 43-12, 4);
  }
  void bass002b(int position, int i) {
    if (i%4==0)  doBass(position, i, 43+2-12, 4);
  }
  void bass002c(int position, int i) {
    if (i%4==0)  doBass(position, i, 43-2-12, 4);
  }
  void bass002d(int position, int i) {
    if (i%4==0)  doBass(position, i, 43-12, 4);
  }

  void kboard000a(int position, int i) {
    if (i==0)  doKboard(position, i, 79, 1);
    if (i==4)  doKboard(position, i, 79+3, 1);
    if (i==8)  doKboard(position, i, 79+2, 1);
    if (i==12) doKboard(position, i, 79+3, 1);
  }
  void kboard000b(int position, int i) {
    if (i==0)  doKboard(position, i, 79, 1);
    if (i==4)  doKboard(position, i, 79+3, 1);
    if (i==6 || i==10)  doKboard(position, i, 79+2, 1);
    if (i==12) doKboard(position, i, 79+3, 1);
  }
  void kboard000c(int position, int i) {
    if (i==0)  doKboard(position, i, 79-4, 1);
    if (i==4)  doKboard(position, i, 79+3, 1);
    if (i==8)  doKboard(position, i, 79+2, 1);
    if (i==12) doKboard(position, i, 79+3, 1);
  }
  void kboard000d(int position, int i) {
    if (i==0)  doKboard(position, i, 79-4, 1);
    if (i==4)  doKboard(position, i, 79+3, 1);
    if (i==6 || i==10)  doKboard(position, i, 79+2, 1);
    if (i==12) doKboard(position, i, 79+3, 1);
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

    //if (i==18 && j==0)presing(i, j, "deben ser las decepciones");//,true?
    if (i==20 && j==0)presing(i, j, "Too dangerous to keep");
    if (i==25 && j==0)presing(i, j, "Too feeble to let go");
    if (i==29 && j==0)presing(i, j, "And you want to bite the hand");
    if (i==32 && j==0)presing(i, j, "Shoulda stopped this long ago");

    if (i==34 && j==0)presing(i, j, "Go now, you've been set free");
    if (i==36 && j==0)presing(i, j, "Another month or so you'll be poisoning me");
    if (i==38 && j==0)presing(i, j, "Looooveeeeely smile");
    if (i==42 && j==0)presing(i, j, "I see you slither away with your skin and your tail");
    if (i==44 && j==0)presing(i, j, "Your flickering tounge and your rattling scales");
    if (i==46 && j==0)presing(i, j, "Like a real");
    if (i==48 && j==0)presing(i, j, "reptile");

    if (i==40+20 && j==0)presing(i, j, "Had you coiled around my arm");
    if (i==40+25 && j==0)presing(i, j, "How could you ever know");
    if (i==40+29 && j==0)presing(i, j, "How I loved your diamond eyes");
    if (i==40+32 && j==0)presing(i, j, "But that was long ago");

    if (i==40+34 && j==0)presing(i, j, "Go now, you've been set free");
    if (i==40+36 && j==0)presing(i, j, "Another month or so you'll be poisoning me");
    if (i==40+38 && j==0)presing(i, j, "Looooveeeeely smile");
    if (i==40+42 && j==0)presing(i, j, "I see you slither away with your skin and your tail");
    if (i==40+44 && j==0)presing(i, j, "Your flickering tounge and your rattling scales");
    if (i==40+46 && j==0)presing(i, j, "Like a real");
    if (i==40+48 && j==0)presing(i, j, "reptile");

    if (i==64+40+20+1-1 && j==0)presing(i, j, "And I should have believed Eve");
    if (i==64+40+25+1-1 && j==0)presing(i, j, "She said we had to blow");
    if (i==64+40+29+1-1 && j==0)presing(i, j, "She was the apple of my eye");
    if (i==64+40+32+1-1 && j==0)presing(i, j, "It wasn't long ago");

    if (i==64+40+34+1-1 && j==0)presing(i, j, "Go now, you've been set free");
    if (i==64+40+36+1-1 && j==0)presing(i, j, "Another month or so you'll be poisoning me");
    if (i==64+40+38+1-1 && j==0)presing(i, j, "Looooveeeeely smile");
    if (i==64+40+42+1-1 && j==0)presing(i, j, "I see you slither away with your skin and your tail");
    if (i==64+40+44+1-1 && j==0)presing(i, j, "Your flickering tounge and your rattling scales");
    if (i==64+40+46+1-1 && j==0)presing(i, j, "Like a real");
    if (i==64+40+48+1-1 && j==0)presing(i, j, "reptile");
  }
  void presing(int i, int j, String l, boolean isfemale) {
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    lyrics[i][j] =l;
  }
}



