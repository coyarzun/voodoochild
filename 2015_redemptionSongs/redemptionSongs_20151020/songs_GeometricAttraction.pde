class GeometricAttraction extends VZong {
  int[] drumpads = {
    36, 38, 42, 44, 47, 48, 37
  };

  String[][] drumspatterns;
  String[] basspatterns;
  int [][] bassnotes;

  String[] kbpatterns;
  int [][] kbnotes;

  int[] bellsnotes;

  //int quantization;
  int position;

  String[] lyricsbase;
  int lyricLine;

  int part = -1;

  GeometricAttraction() {
    lyrics = new String[1024][16];
    name = "Geometric Attraction";
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
    drumsout.sendProgramChange(new ProgramChange(3)); 
    guitarout.sendProgramChange(new ProgramChange(42));
    quantization = 16;
    position = 0;
    int tempo = 170;

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
    sequencer.setLoopEndPoint(512*(position)/quantization);//
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
    for (part = -1; part<30; part++) {
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
        part001();
        break;
      case 4:
        part001b();
        break;
      case 5:
      case 6:
      case 7:
        part001();
        break;
      case 8:
        part001b();
        break;
      case 9:
      case 10:
      case 11:
      case 12:
        part002();
        break;

      case 13:
      case 14:
      case 15:
        part001();
        break;
      case 16:
        part001b();
        break;


      case 17:
      case 18:
      case 19:
        part002();
        break;
      case 20:
        part003();
        break;

      case 21:
      case 22:
      case 23:
        part001();
        break;
      case 24:
        part001b();
        break;
        //  part001();
        //  break;
      case 25:
      case 26:
      case 27:
      case 28:
        part001b();
        break;

      case 29:
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
  void part00() {
    position+=quantization;
    bar=0;
  }

  void part001() {  
    for (bar=0; bar<4; bar++) {
      if (bar==0)riff000();
      if (bar==1)riff000();
      if (bar==2)riff001();
      if (bar==3)riff002();
    }
  }
  void part001b() {  
    for (bar=0; bar<4; bar++) {
      if (bar==0)riff000();
      if (bar==1)riff000();
      if (bar==2)riff001b();
      if (bar==3)riff002b();
    }
  }
  void part002() {  
    for (bar=0; bar<4; bar++) {
      if (bar==0)riff002();
      if (bar==1)riff003();
      if (bar==2)riff000b();
      if (bar==3)riff000b();
    }
  }
  void part003() {  
    for (bar=0; bar<8; bar++) {
      if (bar==0)riff002();
      if (bar==1)riff003();
      if (bar==2)riff002();
      if (bar==3)riff003();

      if (bar==4)riff002();
      if (bar==5)riff003();
      if (bar==6)riff000bx();
      if (bar==7)riff000bx();
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
      keyb002(position, i);
    }
    position+=quantization;
  }
  void riff000b() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001b(position, i);
      keyb001(position, i);
    }
    position+=quantization;
  }
  void riff000bx() {
    for (int i=0; i<quantization; i++) {
      drums001f(position, i);
      bass001b(position, i);
      keyb001(position, i);
    }
    position+=quantization;
  }
  void riff001() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass002(position, i);
      keyb002(position, i);
    }
    position+=quantization;
  }
  void riff001b() {
    for (int i=0; i<quantization; i++) {
      drums001f(position, i);
      bass002(position, i);
    }
    position+=quantization;
  }
  void riff002() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass003(position, i);
      keyb002(position, i);
    }
    position+=quantization;
  }
  void riff002b() {
    for (int i=0; i<quantization; i++) {
      drums001f(position, i);
      bass003(position, i);
      keyb001(position, i);
    }
    position+=quantization;
  }
  void riff003() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass004(position, i);
      keyb002(position, i);
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
  /***************************/

  void drums001(int position, int i) {
    if (i%8==0 || i%16==10) {//(i==0 || i==8 || i==10){
      doDrums(position, i, 36, 110, 120);
    }
    if (i==4 || i==12) {
      doDrums(position, i, 38, 110, 120);
    }
    if (i%2==0) {
      //doDrums(position, i, 42, 110, 120);
      doDrums(position, i, 44, 110, 120);
    }
    //raska++;
  }
  void drums001f(int position, int i) {
    if (i%4==0) {//(i==0 || i==8 || i==10){
      doDrums(position, i, 36, 110, 120);
    }
    doDrums(position, i, 38, 110+int(random(16)), 120);
    if (true) {
      doDrums(position, i, i%4==3?42:44, 110, 120);
    }
  }
  void bass001(int position, int i) {
    if (i%2==0)
      doBass(position, i, 38+2, 1);
  }
  void bass001b(int position, int i) {
    if (i%2==0)
      doBass(position, i, 38-12+2, 1);
  }
  void bass002(int position, int i) {
    if (i%2==0)
      doBass(position, i, 31+2, 1);
  }
  void bass003(int position, int i) {
    if (i%2==0)
      doBass(position, i, 34+2, 1);
  }
  void bass004(int position, int i) {
    if (i%2==0)
      doBass(position, i, 33+2, 1);
  }

  void bass003f(int position, int i) {
    if (i%2==0)
      doBass(position, i, 38+2, 8);
  }
  void bass004f(int position, int i) {
    if (i%2==0)
      doBass(position, i, 34+2, 1);
  }

  void keyb001(int position, int i) {
    if (i%3==0)
      doGuitar(position, i, 59+24, 1);
  }
  void keyb002(int position, int i) {
    if (i%3==0)
      doGuitar(position, i, 59+24, 1);
    else if (i%2==0)
      if (random(100)>30)
        doGuitar(position, i, 59+24+12, 1);
      else if (random(100)>50)
        doGuitar(position, i, 59+24+12-2, 1);
      else
        doGuitar(position, i, 59+24+12-5, 1);
  }
  void doBass(int position, int i, int pitch, int duration) {
    basstrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    basstrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
    basstrack2.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    basstrack2.addEvent(new Note(pitch, 0, 1), position+i+duration);
  }
  void doGuitar(int position, int i, int pitch, int duration) {
    guitartrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    guitartrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
  }
  void doDrums(int positiom, int i, int pitch, int minv, int maxv) {
    drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
    drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
    dobeat(position+i, pitch);
  }

  void presing(int i, int j, String l, boolean isfemale) {
    //i+=1;
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    //i+=1;
    lyrics[i][j] =l;
  }

  void checkLyrics(int i, int j) {
    //i-=2;
    if (i==34 && j==0)presing(i, j, "I'm always impressed by you");
    if (i==36 && j==0)presing(i, j, "and your colorfully forms");
    if (i==38 && j==0)presing(i, j, "the way your contours curves");
    if (i==40 && j==0)presing(i, j, "and starts again");
    if (i==42 && j==0)presing(i, j, "It's that your hair?");
    if (i==44 && j==0)presing(i, j, "or is the sun shining");
    if (i==46 && j==0)presing(i, j, "exceptionally today");
    if (i==48 && j==0)presing(i, j, "around you and your teeths");

    if (i==50 && j==0)presing(i, j, "in a flaming shape");
    if (i==52 && j==0)presing(i, j, "you turn my sweetness");
    if (i==54 && j==0)presing(i, j, "and in a growing wave");
    if (i==56 && j==0)presing(i, j, "we spin my sweetness");
    if (i==58 && j==0)presing(i, j, "and as the night embraces the earth");
    if (i==60 && j==0)presing(i, j, "we kiss the shore and rest");
    if (i==62 && j==0)presing(i, j, "and in a flaming shape");
    if (i==64 && j==0)presing(i, j, "my love will spin my sweetness");

    if (i==66 && j==0)presing(i, j, "I really like the way we fits");
    if (i==68 && j==0)presing(i, j, "the palette we mix");
    if (i==70 && j==0)presing(i, j, "the mountains and seas we draw");
    if (i==72 && j==0)presing(i, j, "yo make me start again");
    if (i==74 && j==0)presing(i, j, "Are those your eyes?");
    if (i==76 && j==0)presing(i, j, "or is the sky shining");
    if (i==78 && j==0)presing(i, j, "exceptionally tonight");
    if (i==80 && j==0)presing(i, j, "around you and your teeths");
    if (i==82 && j==0)presing(i, j, "and your tongue and your lips");
    if (i==84 && j==0)presing(i, j, "and the fire in your clit");

    if (i==102 && j==0)presing(i, j, "in a flaming shape");
    if (i==104 && j==0)presing(i, j, "you turn my sweetness");
    if (i==106 && j==0)presing(i, j, "and in a growing wave");
    if (i==108 && j==0)presing(i, j, "we spin my sweetness");
    if (i==110 && j==0)presing(i, j, "and as the night embraces the earth");
    if (i==112 && j==0)presing(i, j, "we kiss the shore and rest");
    if (i==114 && j==0)presing(i, j, "and in a flaming shape");
    if (i==116 && j==0)presing(i, j, "my love will spin my sweetness");
    if (i==118 && j==0)presing(i, j, "and in a flaming shape");
    if (i==120 && j==0)presing(i, j, "my love will spin my sweetness");
  }
}
