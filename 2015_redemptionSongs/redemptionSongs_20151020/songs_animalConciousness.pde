class AnimalConciousness extends VZong {
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

  AnimalConciousness() {
    lyrics = new String[1024][16];
    name = "Animal Conciousness";
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
    guitarout.sendProgramChange(new ProgramChange(77));//62));

    quantization = 16;
    position = 0;
    int tempo = 90;

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
    for (part = -1; part<11; part++) {
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
      case 4:
      case 6:
        part002();
        break;
      case 9:
        part003();
        break; 
      case 10:
        finalx();
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
  void finalx() {
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doDrums(position, i, 36, 120, 127);
        doDrums(position, i, 38, 120, 127);
        doDrums(position, i, 49, 120, 127);
        doKboard(position, i, 33, 16);
      }
    }
    position+=quantization;
  }
  void part001() {  
    for (bar=0; bar<4*2; bar++) {
      switch(bar%2) {
      default: 
        riff001a();
        break;
      case 1:
        riff001b();
      }
    }
  }
  void part002() {  
    for (bar=0; bar<4*2; bar++) {
      switch(bar%2) {
      default: 
        riff002a();
        break;
      case 1:
        riff002b();
      }
    }
  }
  void part003() {  
    for (bar=0; bar<4*2; bar++) {
      switch(bar%2) {
      default: 
        riff003a();
        break;
      case 1:
        riff003b();
      }
    }
  }
  void riff001a() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001a(position, i);
      kboard001a(position, i);
    }
    position+=quantization;
  }
  void riff001b() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001b(position, i);
      kboard001b(position, i);
    }
    position+=quantization;
  }
  void riff002a() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      //bass001a(position, i);
      kboard001a(position, i);
    }
    position+=quantization;
  }
  void riff002b() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      //bass001b(position, i);
      kboard001b(position, i);
    }
    position+=quantization;
  }
  void riff003a() {
    for (int i=0; i<quantization; i++) {
      drums004(position, i);
      //bass001a(position, i);
      kboard001a(position, i);
    }
    position+=quantization;
  }
  void riff003b() {
    for (int i=0; i<quantization; i++) {
      drums004(position, i);
      //bass001b(position, i);
      kboard001b(position, i);
    }
    position+=quantization;
  }
  /***************************/
  void drums001(int position, int i) {
    if (i==0 || i==40 || i==6 || i==8 || i==11 || i==14)
      doDrums(position, i, 36, 120, 127);
    if (i==3 || i==5 || i==10 || i==13) {// ||i%12==2){
      doDrums(position, i, 38, 127, 100);
      doDrums(position, i, 46, 100, 100);
    }
    else {
      doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    }
  }
  void drums002(int position, int i) {
    if (i==0 || i==40 || i==6 || i==8 || i==12 || i==14)
      doDrums(position, i, 36, 120, 127);
    if (i==3 || i==5 || i==11 || i==13) {// ||i%12==2){
      doDrums(position, i, 38, 127, 100);
      doDrums(position, i, 46, 100, 100);
    }
    else {
      doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    }
  }
  void drums003(int position, int i) {
    if (i==0 || i==40 || i==6 || i==8 || i==12 || i==14)
      doDrums(position, i, 36, 120, 127);
    if (i==3 || i==5 || i==11 || i==13) {// ||i%12==2){
      doDrums(position, i, 38, 127, 100);
      doDrums(position, i, 46, 100, 100);
    }
    else if (i%2==0 || i==15) {
      doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    }
  }
  void drums004(int position, int i) {
    if (i==0 || i==40 || i==6 || i==8 || i==11 || i==14)
      doDrums(position, i, 36, 120, 127);
    if (i==3 || i==5 || i==10 || i==13) {// ||i%12==2){
      //doDrums(position, i, 38, 127, 100);
      doDrums(position, i, 46, 100, 100);
    }
    else if (i%2==0 || i==15) {
      doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    }
  }
  void bass001a(int position, int i) {
    if (i==0) {
      doBass(position, -2, 28+24, 1);
      doBass(position, i, 31+24, 1);
    }
    else if (i==1 || i==9)  doBass(position, i, 33+24, 2);
    else if (i==3 || i==10)  doBass(position, i, 40+24, 3);
    else if (i==6 )  doBass(position, i, 31+24, 1);
    else if (i==7)  doBass(position, i, 33+24, 8);
    else if (i==14)  doBass(position, i, 28+24, 1);
  }
  void bass001b(int position, int i) {
    if (i==0) {
      doBass(position, i, 31+24, 1);
    }
    else if (i==1 || i==9)  doBass(position, i, 33+24, 2);
    else if (i==3 || i==10)  doBass(position, i, 31+5+24, 3);
    else if (i==6 )  doBass(position, i, 31+2+24, 1);
    else if (i==7)  doBass(position, i, 33+24, 8);
  }

  void kboard001a(int position, int i) {
    if (i==0)  doKboard(position, i, 33, 16);
  }
  void kboard001b(int position, int i) {
    if (i==0)  doKboard(position, i, 33+3, 12);
    if (i==12)  doKboard(position, i, 33+3+2, 4);
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
    if (i==2 && j==0)presing(i, j, "Evidencia convergente indica que los animales no humanos");
    if (i==4 && j==0)presing(i, j, "poseen los substratos neuroanatómicos,");
    if (i==6 && j==0)presing(i, j, "neuroquímicos y neurofisiológicos de estados conscientes");
    if (i==8 && j==0)presing(i, j, "así como la capacidad de exhibir comportamientos deliberados.");

    if (i==18 && j==0)presing(i, j, "Por consiguiente, el peso de la evidencia");
    if (i==20 && j==0)presing(i, j, "indica que los seres humanos");
    if (i==22 && j==0)presing(i, j, "no son los únicos que poseen");
    if (i==24 && j==0)presing(i, j, "los sustratos neurológicos necesarios para generar conciencia");

    if (i==34 && j==0)presing(i, j, "Evidencia convergente indica que los animales no humanos");
    if (i==36 && j==0)presing(i, j, "poseen los substratos neuroanatómicos,");
    if (i==38 && j==0)presing(i, j, "neuroquímicos y neurofisiológicos de estados conscientes");
    if (i==40 && j==0)presing(i, j, "así como la capacidad de exhibir comportamientos deliberados.");

    if (i==50 && j==0)presing(i, j, "Por consiguiente, el peso de la evidencia");
    if (i==52 && j==0)presing(i, j, "indica que los seres humanos");
    if (i==54 && j==0)presing(i, j, "no son los únicos que poseen");
    if (i==56 && j==0)presing(i, j, "los sustratos neurológicos necesarios para generar conciencia");

    if (i==58 && j==0)presing(i, j, "Animales no humanos,");
    if (i==60 && j==0)presing(i, j, "incluyendo todos los mamíferos y pájaros,");
    if (i==62 && j==0)presing(i, j, "y muchas otras criaturas, incluyendo los pulpos,");
    if (i==64 && j==0)presing(i, j, "también poseen estos sustratos neurológicos");
  }
  void presing(int i, int j, String l, boolean isfemale) {
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    lyrics[i][j] =l;
  }
}
