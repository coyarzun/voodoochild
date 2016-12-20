class LEteIndien extends VZong {
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

  //int quantization;
  int position;

  String[] lyricsbase;
  int lyricLine;

  int part = -1;
  //int bar;
  //int frame;
  //int bar = 0, frame = 0, cframe = 0;
  int auxposition;

  int[] lam = {
    69, 72, 76
  };
  int[] mim = {
    67, 71, 76
  };
  int[] doM = {
    67, 72, 76
  };
  int[] sim = {
    71, 74, 78
  };

  LEteIndien() {
    lyrics = new String[1024][16];
    name = "LEteIndien";
    makeSong();
    //vplayer.println("song "+name+" loaded!");
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
    guitarout.sendProgramChange(new ProgramChange(5)); 

    quantization = 16;
    position = 0;
    int tempo = 110;

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
    for (part = -2; part<11; part++) {
      switch(part) {
      case -1:
        counter();
        break;
      case 6:
        part00();
        break;
      case 0:
      case 3:
      case 7:
        part01();
        break;
      case 1:
      case 2:
      case 4:
      case 5:
      case 8:
        part02();
        break;
      case 9:
        part00x();
        break;
      case 10:
      case -2:
        silence();
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
  void part00x() {  
    riff000x();//rem
  }
  void part01() {  
    for (bar=0; bar<8; bar++) {
      if (bar==0)riff000();//rem
      if (bar==1)riff000();//rem
      if (bar==2)riff001();//solm
      if (bar==3)riff002();//laM
      if (bar==4)riff000();//rem
      if (bar==5)riff000();//rem
      if (bar==6)riff001();//solm
      if (bar==7)riff002();//laM
    }
  }
  void part02() {  
    for (bar=0; bar<16; bar++) {
      if (bar==0)riff000();//rem
      if (bar==1)riff000();//rem
      if (bar==2)riff002();//laM
      if (bar==3)riff002();//laM
      if (bar==4)riff000M();//reM
      if (bar==5)riff000M();//reM
      if (bar==6)riff001();//solm
      if (bar==7)riff001();//solm
      if (bar==8)riff003();//sib
      if (bar==9)riff003();//sib
      if (bar==10)riff000();//rem
      if (bar==11)riff000();//rem
      if (bar==12)riff004();//mi
      if (bar==13)riff004();//mi
      if (bar==14)riff002();//la7
      if (bar==15)riff002();//la7
    }
  }
  void danceDrum(int position, int i) {
    if (i%4==0)doDrums(position, i, 36, 110, 120);
    if (i%4==2) {
      doDrums(position, i, 44, 110, 120);   
      doDrums(position, i+1, 44, 110, 120);
    }
    else {
      doDrums(position, i, 44, 110, 120);
    }
    if (i%8==4)doDrums(position, i, 38, 110, 120);
  }
  void danceBass(int position, int i, int pitch, int mode) {
    if (i%4==0) {
      doBass(position, i, pitch, mode==9?16:1);
      doBass(position, i+1, pitch, mode==9?16:1);
    }
    if (i%4==2) {
      doBass(position, i, pitch+12, 1);
      doBass(position, i+1, pitch+12, 1);
    }
  }
  void riff000() {//rem
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, 2, 16);
        doGuitar(position, i, 2+3, 16);
        doGuitar(position, i, 2+7, 16);
      }
      danceBass(position, i, 2, 0);
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff000x() {//rem
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, 2, 16);
        doGuitar(position, i, 2+3, 16);
        doGuitar(position, i, 2+7, 16);
        danceBass(position, i, 2, 9);
        //danceDrum(position,i);
      }
    }
    position+=quantization;
  }
  void riff000M() {//reM
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, 2, 16);
        doGuitar(position, i, 2+4, 16);
        doGuitar(position, i, 2+7, 16);
      }
      danceBass(position, i, 2, 0);
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff001() {//solm
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, -5, 16);
        doGuitar(position, i, -5+3, 16);
        doGuitar(position, i, -5+7, 16);
      }
      danceBass(position, i, -5, 0);
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff001M() {//solM
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, -5, 16);
        doGuitar(position, i, -5+4, 16);
        doGuitar(position, i, -5+7, 16);
      }
      danceBass(position, i, -5, 0);
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff002() {//laM
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, -3, 16);
        doGuitar(position, i, -3+4, 16);
        doGuitar(position, i, -3+7, 16);
      }
      danceBass(position, i, -3, 0);   
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff002m() {//lam
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, -3, 16);
        doGuitar(position, i, -3+3, 16);
        doGuitar(position, i, -3+7, 16);
      }
      danceBass(position, i, -3, 0); 
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff003() {//sibM
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, -2, 16);
        doGuitar(position, i, -2+4, 16);
        doGuitar(position, i, -2+7, 16);
      }
      danceBass(position, i, -2, 0); 
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void riff004() {//miM
    for (int i=0; i<quantization; i++) {
      if (i==0) {
        doGuitar(position, i, 4, 1);
        doGuitar(position, i, 4+4, 16);
        doGuitar(position, i, 4+7, 16);
      }
      danceBass(position, i, 4, 0);    
      danceDrum(position, i);
    }
    position+=quantization;
  }
  void doDrums(int positiom, int i, int pitch, int minv, int maxv) {
    drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
    drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
    dobeat(position+i, pitch);
  }
  void doBass(int position, int i, int pitch, int duration) {
    int basescale = 36;
    int nn = basescale+pitch;
    basstrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
    basstrack.addEvent(new Note(nn, 0, 1), position+i+duration);
    basstrack2.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
    basstrack2.addEvent(new Note(nn, 0, 1), position+i+duration);
  }
  void doGuitar(int position, int i, int pitch, int duration) {
    int basescale = 36+36;
    int nn = basescale+pitch;
    guitartrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
    guitartrack.addEvent(new Note(nn, 0, 1), position+i+duration);
  }

  void checkLyrics(int i, int j) {

    if (i==1 && j==0)presing(i, j, "Ya sabes,");
    if (i==2 && j==0)presing(i, j, "que esta noche me siento tan solo y perdido");
    if (i==3 && j==8)presing(i, j, "cuando no estás");

    if (i==5 && j==0)presing(i, j, "y esos recuerdos");
    if (i==6 && j==0)presing(i, j, "estan llenos de ti, ");
    if (i==7 && j==8)presing(i, j, "de tu primavera..");

    if (i==9 && j==0)presing(i, j, "una playa nuestra");
    if (i==10 && j==0)presing(i, j, "donde fui arena para sostenerte");
    if (i==13 && j==0)presing(i, j, "un mar nuestro");
    if (i==14 && j==0)presing(i, j, "donde fui la ola que te llevaba,");
    if (i==17 && j==0)presing(i, j, "esencia");
    if (i==18 && j==0)presing(i, j, "pequeñas cosas");
    if (i==19 && j==0)presing(i, j, "y ahora este vacio");
    if (i==21 && j==0)presing(i, j, "sin poder mirar hacia el futuro,");
    if (i==23 && j==0)presing(i, j, "solo");
    if (i==24 && j==0)presing(i, j, "sin ti..");

    if (i==25 && j==0)presing(i, j, "hacia atras");
    if (i==26 && j==8)presing(i, j, "solo puedo mirar atras");
    if (i==29 && j==0)presing(i, j, "y sentir que vuelvo a estar");
    if (i==31 && j==0)presing(i, j, "aun vivo para el amor,");
    if (i==33 && j==0)presing(i, j, "una voz,");
    if (i==34 && j==0)presing(i, j, "que viene de un atardecer ");
    if (i==37 && j==0)presing(i, j, "me hace ver");
    if (i==38 && j==8)presing(i, j, "que aun puede ser...");

    if (i==40+1 && j==0)presing(i, j, "Ya sabes,");
    if (i==40+2 && j==0)presing(i, j, "estoy muy lejos de esos recuerdos,");
    if (i==40+3 && j==8)presing(i, j, "donde estas?");

    if (i==40+5 && j==0)presing(i, j, "te acuerdas de mi ");
    if (i==40+6 && j==0)presing(i, j, "o te habras olvidado..?");
    //if(i==40+7 && j==8)presing(i, j,"de tu primavera..");

    if (i==40+9 && j==0)presing(i, j, "tal vez piensas ");
    if (i==40+10 && j==0)presing(i, j, "que fue una tonteria conocerme ");
    if (i==40+13 && j==0)presing(i, j, "que aquella arena y aquel mar ");
    if (i==40+14 && j==0)presing(i, j, "solo fueron recuerdos..");
    if (i==40+17 && j==0)presing(i, j, "cierro los ojos y te imagino!");
    if (i==40+18 && j==0)presing(i, j, "esperare un mes,un año,toda la vida");
    //if(i==40+19 && j==0)presing(i, j," ");
    if (i==40+21 && j==0)presing(i, j, "por que lo que siento");
    if (i==40+23 && j==0)presing(i, j, "no tiene tiempo,");
    if (i==40+24 && j==0)presing(i, j, " llama Amor!!");

    if (i==40+25 && j==0)presing(i, j, "hacia atras");
    if (i==40+26 && j==8)presing(i, j, "solo puedo mirar atras");
    if (i==40+29 && j==0)presing(i, j, "y sentir que vuelvo a estar");
    if (i==40+31 && j==0)presing(i, j, "aun vivo para el amor,");
    if (i==40+33 && j==0)presing(i, j, "una voz,");
    if (i==40+34 && j==0)presing(i, j, "que viene de un atardecer ");
    if (i==40+37 && j==0)presing(i, j, "me hace ver");
    if (i==40+38 && j==8)presing(i, j, "que aun puede ser...");
  }

  void presing(int i, int j, String l, boolean isfemale) {
    i+=1;
    lyrics[i][j] =l;
    //println(auxposition+" "+i+" "+l);
  }
  void presing(int i, int j, String l) {
    i+=1;
    lyrics[i][j] =l;
    //println(auxposition+" "+i+" "+l);
  }
}
