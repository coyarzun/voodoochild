class TheEternalCitySong extends VZong {
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

  TheEternalCitySong() {
    lyrics = new String[1024][16];
    name = "The Eternal City Song";
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
    guitarout.sendProgramChange(new ProgramChange(42));//62));

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
    for (part = -1; part<22; part++) {
      switch(part) {
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      case 1:
      case 2:
      case 3:
      case 4:

      case 9:
      case 10:
      case 11:
      case 12:
        part001();
        break;
      case 17:
      case 18:
      case 19:
      case 20:
        part001();
        break;
      case 5:
      case 6:
      case 7:
      case 8:

      case 13:
      case 14:
      case 15:
      case 16:
        part002();
        break;
      case 21:
        part001f();
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
    for (bar=0; bar<4; bar++) {
      if (bar==0)riff000();
      if (bar==1)riff001();
      if (bar==2)riff002();
      if (bar==3)riff002();
    }
  }
  void part002() {  
    for (bar=0; bar<4; bar++) {
      if (bar==0)riff003();
      if (bar==1)riff001();
      if (bar==2)riff002();
      if (bar==3)riff002();
    }
  }
  void part001f() {  
    for (bar=0; bar<4; bar++) {
      if (bar==0)riff000();
      if (bar==1)riff001();
      if (bar==2)riff002();
      if (bar==3)riff002f();
    }
  }
  void riff000() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001(position, i);
    }
    position+=quantization;
  }
  void riff001() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass002(position, i);
    }
    position+=quantization;
  }
  void riff002() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass003(position, i);
    }
    position+=quantization;
  }
  void riff002f() {
    for (int i=0; i<quantization+1; i++) {
      drums001f(position, i);
      bass003f(position, i);
    }
    position+=quantization;
  }
  void riff003() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass004(position, i);
    }
    position+=quantization;
  }
  /***************************/
  int raska;

  void drums001(int position, int i) {
    if ((raska/16)%2==0) {
      if (i%4==0) {//(i==0 || i==8 || i==10){
        doDrums(position, i, 36, 110, 120);
      }
    }
    else {
      if (i%4==0 || i==14) {//(i==0 || i==8 || i==10){
        doDrums(position, i, 36, 110, 120);
      }
    }
    if (i==4 || i==12) {
      doDrums(position, i, 38, 110, 120);
    }
    if (true) {
      //doDrums(position, i, 42, 110, 120);
      doDrums(position, i, 44, 110, 120);
    }
    raska++;
  }
  void drums001f(int position, int i) {
    if (i%4==0) {//(i==0 || i==8 || i==10){
      doDrums(position, i, 36, 110, 120);
    }
    if (i==4 || i==12 || i==8 || i==0) {
      doDrums(position, i, 38, 110, 120);
    }
    if (true) {
      doDrums(position, i, i%4==3?42:44, 110, 120);
    }
  }
  void bass001(int position, int i) {
    if (i==0 || i==4 || i==8 || i==12) {
      doKboard(position, i, 45, 1);
      doBass(position, i, 45, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doKboard(position, i, 45+12, 1);
      doBass(position, i, 45+12, 1);
    }
  }
  void bass002(int position, int i) {
    if (i==0 || i==4 || i==8 || i==12) {
      doKboard(position, i, 50, 1);
      doBass(position, i, 50, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doKboard(position, i, 50+12, 1);
      doBass(position, i, 50+12, 1);
    }
  }
  void bass003(int position, int i) {
    if (i==0 || i==4 || i==8 || i==12) {
      doKboard(position, i, 42, 1);
      doBass(position, i, 42, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doKboard(position, i, 42+12, 1);
      doBass(position, i, 42+12, 1);
    }
  }
  void bass003f(int position, int i) {
    if (i==0 || i==4 || i==8 || i==12) {
      doKboard(position, i, 42, 8);
      doBass(position, i, 42, 8);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doKboard(position, i, 42+12, 1);
      doBass(position, i, 42+12, 1);
    }
  }
  void bass004(int position, int i) {
    if (i==0 || i==4 || i==8 || i==12) {
      doKboard(position, i, 49, 1);
      doBass(position, i, 49, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doKboard(position, i, 49+12, 1);
      doBass(position, i, 49+12, 1);
    }
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
    if (i==18 && j==0)presing(i, j, "deben ser las decepciones");//,true?
    if (i==20 && j==0)presing(i, j, "habituales de un domingo");
    if (i==22 && j==0)presing(i, j, "o las fluctuations lunares");
    if (i==24 && j==0)presing(i, j, "o el atardecer sin ti");

    if (i==26 && j==0)presing(i, j, "pero esta ciudad se hace eterna");
    if (i==28 && j==0)presing(i, j, "cuando no estás");
    if (i==30 && j==0)presing(i, j, "y sueña crecer hasta alkanzarte");
    if (i==32 && j==0)presing(i, j, "y sueña florecer cada vez q vuelvas");

    if (i==50 && j==0)presing(i, j, "la vida diaria es un viaje");
    if (i==52 && j==0)presing(i, j, "una residencia que oscila");
    if (i==54 && j==0)presing(i, j, "y en las fluctuaciones lunares");
    if (i==56 && j==0)presing(i, j, "sueña el atardecer que ven tus ojos");

    if (i==58 && j==0)presing(i, j, "en esta ciudad me vuelvo eterno");
    if (i==60 && j==0)presing(i, j, "a medida que no estás");
    if (i==62 && j==0)presing(i, j, "y sueño crecer hasta alkanzarte");
    if (i==64 && j==0)presing(i, j, "y florecer cuando estés de vuelta");
  }
  void presing(int i, int j, String l, boolean isfemale) {
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    lyrics[i][j] =l;
  }
}
