class AdaptiveRadiation extends VZong {
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

  int[] solM = {
    71-1*12, 67-1*12, 74-1*12, 79-1*12
  };
  int[] doM  = {
    72-1*12, 64-1*12, 67-1*12, 60-1*12
  };
  int[] sim  = {
    71-1*12, 74-1*12, 66-1*12, 59+1*12
  };

  AdaptiveRadiation() {
    lyrics = new String[1024][16];
    name = "AdaptativeRadiation";
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
    drumsout.sendProgramChange(new ProgramChange(1)); 
    guitarout.sendProgramChange(new ProgramChange(69));


    quantization = 16;
    position = 0;
    int tempo = 96;

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
    for (part = -1; part<24; part++) {
      switch(part) {
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      case 1:
      case 3:
        //case 5:
        part001();
        break;
      case 2:
        //case 4:
        part002();
        //silence();
        break;
      default:
        part003();
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

  void prediend() {
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doBass(position, i, 45-12, 12);
        doKboard(position, i, solM[0], 160);
        doKboard(position, i, solM[1], 160);
        doKboard(position, i, solM[2], 160);
      }
    }
    position+=quantization;
  }
  void diend() {
    int i=0;
    doKboard(position, i, solM[0], 160);
    doKboard(position, i, solM[1], 160);
    doKboard(position, i, solM[2], 160);
    position+=quantization;
  }
  void part001() {  
    for (bar=0; bar<4*4; bar++) {
      switch(bar%4) {
      default: 
        riff000();
        break;
      case 1:
        riff002();
        break;
      }
    }
  }
  void part002() {  
    for (bar=0; bar<4*2; bar++) {
      switch(bar%4) {
      case 0: 
        riff001();
        break;
      case 1:
        riff002();
        break;
      default:
        riff000();
        break;
      }
    }
  }
  void part003() {  
    for (bar=0; bar<4*2; bar++) {
      riff001();
      break;
    }
  }
  void riff000() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassSolM(position, i);
      kboardSolM(position, i);
    }
    position+=quantization;
  }
  void riff001() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassSim(position, i);
      kboardSim(position, i);
    }
    position+=quantization;
  }
  void riff002() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassDoM(position, i);
      kboardDoM(position, i);
    }
    position+=quantization;
  }
  /***************************/
  void drums001(int position, int i) {
    if (i%4==0)// || i%10==0)
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    if (i%3==0) {
      doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
      doDrums(position, i+1, 44, i%6==0?127:96, i%6==0?127:96);
    }
    else
      doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);

    if (i%8==4)
      doDrums(position, i, 38, 96, 100);
  }
  void drums002(int position, int i) {
    if (i%4==0 )//|| i%10==0)
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    if (i%3==0)
      doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
    else //if(i%4==2)
    doDrums(position, i, 42, 110, 120);
    if (i%8==4)
      doDrums(position, i, 38, 96, 100);
  }
  void drums003(int position, int i) {
    if (i%8==0)
      doDrums(position, i, 38, 96, 100);
    else if (i%4==0 || i%10==0)
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    if (i%3==0)
      doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
    else if (i%4==2)
      doDrums(position, i, 42, 110, 120);
  }
  //
  void bassSolM(int position, int i) {
    int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
    if (i%2==0) {
      doBass(position, i, 43-12, 1);
    }
    else doBass(position, i, 43, 1);//doBass(position, i, 43-24, 1);
  }
  void bassSim(int position, int i) {
    int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
    if (i%2==0) {
      doBass(position, i, 47-12, 1);
    }
    //else doBass(position, i, 47, 1);//doBass(position, i, 47-24, 1);
  }
  void bassDoM(int position, int i) {
    int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
    if (i%2==0) {
      doBass(position, i, 36-12, 1);
    }
    else      doBass(position, i, 36, 1);//doBass(position, i, 36-12, 1);
  }
  //
  void kboardSolM(int position, int i) {
    //if(i%2==0)// || i%3==0)
    //doKboard(position, i%quantization, solM[3-i%4], 8);
    //if(i%2==1)
    // if(i==0) 
    //  doKboard(position, i, solM[0], 16);
    int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
    if (i%6==0) {
      doKboard(position, i, 43-12+24, 1);
    }
    else if (i==0 || i==6 || i==10 || i==13) {
      doKboard(position, i, 43+xtra+24, 2);
    }
    //else if(i%3==0)  doKboard(position, i+1, 43+24, 1);
  }
  void kboardSim(int position, int i) {
    //if(i%2==1)
    //  if(i==0) 
    //  doKboard(position, i, sim[0], 16);
    int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
    if (i%3==0) {
      doKboard(position, i, 47-12+24, 1);
    }
    else if (i==6) {//2 || i==6 || i==10 || i==13) {
      doKboard(position, i, 47+xtra+24, 1);
      if (xtra!=0) {
        xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
        doKboard(position, i+1, 47+xtra+24, 1);
      }
    }
    else doKboard(position, i+1, 47+xtra+24, 1);//doBass(position, i, 47-24, 1);
  }
  void kboardDoM(int position, int i) {
    //if(i%2==0 || i%3==0)
    //  if(i==0) 
    //  doKboard(position, i, doM[0], 16);
    int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
    if (i%3==0) {
      doKboard(position, i, 36+24, 1);
    }
    else if (i==2 || i==6 || i==10 || i==13) {
      doKboard(position, i, 36+12+xtra+24, 2);
    }
    //else      doKboard(position, i, 36+7+24, 1);
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
    //18
    //22
    //26?30?34?48
    //42 -->
    //50
    //60 last
    if (i==14 && j==0)presing(i, j, "hijos de la luz");
    if (i==15 && j==0)presing(i, j, "benditos hijos míos");
    if (i==16 && j==0)presing(i, j, "pequeños y sabrosos");
    if (i==17 && j==0)presing(i, j, "alegrense hoy");

    if (i==18 && j==0)presing(i, j, "Elevaremos los brazos hacia el sol");
    if (i==20 && j==0)presing(i, j, "y abriremos los caminos y los futuros");
    if (i==22 && j==0)presing(i, j, "y radiaremos en espiral nuestros caminos ");
    if (i==24 && j==0)presing(i, j, "como hojas de un mismo árbol");

    if (i==38 && j==0)presing(i, j, "hijos de la luz");
    if (i==39 && j==0)presing(i, j, "benditos hijos míos");
    if (i==40 && j==0)presing(i, j, "pequeños y sabrosos");
    if (i==41 && j==0)presing(i, j, "alegrense hoy");

    if (i==42 && j==0)presing(i, j, "Elevaremos los brazos hacia el sol");
    if (i==44 && j==0)presing(i, j, "y abriremos los caminos y los futuros");
    if (i==46 && j==0)presing(i, j, "y radiaremos en espiral nuestros caminos ");
    if (i==48 && j==0)presing(i, j, "como hojas al viento");
    if (i==49 && j==0)presing(i, j, "hijos de la luz");
    if (i==50 && j==0)presing(i, j, "benditos hijos míos");
    if (i==51 && j==0)presing(i, j, "pequeños y sabios");
    if (i==52 && j==0)presing(i, j, "alegrense que hoy");  
    if (i==53 && j==0)presing(i, j, "hijos de la luz");
    if (i==54 && j==0)presing(i, j, "benditos hijos míos");
    if (i==55 && j==0)presing(i, j, "pequeños y sabios");
    if (i==56 && j==0)presing(i, j, "alegrense que hoy");    
    if (i==57 && j==0)presing(i, j, "hijos de la luz");
    if (i==58 && j==0)presing(i, j, "benditos hijos míos");
    if (i==59 && j==0)presing(i, j, "pequeños y sabios");
    if (i==60 && j==0)presing(i, j, "alegrense que hoy");
    if (i==61 && j==0)presing(i, j, "somos como el choclo");
  }
  void presing(int i, int j, String l, boolean isfemale) {
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    lyrics[i][j] =l;
  }
}
