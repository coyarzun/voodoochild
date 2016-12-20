class Aparecido extends VZong {
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

  int part = -3;
  //int bar;
  //int frame;
  //int bar = 0, frame = 0, cframe = 0;
  int auxposition;

  Aparecido() {
    lyrics = new String[1024][16];
    name = "elAparecido";
    makeSong();
    //    vplayer.println("song "+name+" loaded!");
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
    drumsout.sendProgramChange(new ProgramChange(0)); 
    guitarout.sendProgramChange(new ProgramChange(5));//62)); 
    //bellsout.sendProgramChange(new ProgramChange(76));//62));//76)); 
    //score.empty();
    quantization = 12;
    position = 0;
    int tempo = 90;

    metacompose();

    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);
    song.addTrack(bellstrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(384*auxposition/quantization);//512*bars);//
    sequencer.setLoopCount(-1);
    sequencer.noLoop();
  }
  void metacompose() {
    for (int j=-3; j<133-24-6; j++) {
      for (int i=0; i<quantization; i++) {
        compose(i);
        checkLyrics(i);
        auxposition++;
      }
      bar++;
    }
  }
  void compose(int i) {
    switch(part) {
    case -2:
    case -3:
    default:
      silencex(i);
      break;
    case -1:
      phrase0x(i);
      break;
    case 0:
    case 1:
    case 5:
    case 6:
    case 10:
    case 11:
    case 14-2:
    case 15-2:
      //case 16-2:
      //case 17-2:
      phrase0(i);//0(i);
      break;
    case 2:
    case 7:
      phrase1(i);
      break;
    case 3:
    case 8:
      //case 12:
      phrase1_2(i);
      break;
    case 4:
    case 9:
      //case 13:
      phrase2(i);
      break;
    case 18-2-1-1:
      phrase3(i);
      break;
    }
  }
  void silencex(int i) {
    if (i==11) {
      bar=0;
      part++;
    }
  }
  void phrase0x(int i) {
    riff009(i);
    if (i==11) {
      bar=0;
      part++;
    }
  }
  void phrase0(int i) {
    switch((bar-1)%4) {
    case 0:
    default:
      riff001_2(i);
      break;
    case 1:
      riff004(i);
      break;
    case 2:
      riff002_3(i);
      break;
    case 3:
      riff001_2(i);
      if (i==11) {
        bar=0;
        part++;
      }
      break;
    }
  }
  void phrase1(int i) {
    switch((bar-1)%10) {
    case 0:
    default:
      riff001(i);
      break;
    case 1:
      riff001(i);
      break;
    case 2:
      riff002(i);
      break;
    case 3:
      riff001(i);
      break;
      //
    case 4:
      riff002(i);
      break;
    case 5:
      riff003(i);
      break;
    case 6:
      riff001(i);
      break;
    case 7:
      riff001(i);
      break;
      //
    case 8:
      riff004(i);
      break;
    case 9:
      riff001(i);
      if (i==11) {
        bar=0;
        part++;
      }
      break;
    }
  }
  void phrase1_2(int i) {
    switch((bar-1)%8) {
    case 0:
    default:
      riff001(i);
      break;
    case 1:
      riff001(i);
      break;
    case 2:
      riff002(i);
      break;
    case 3:
      riff001(i);
      break;
      //
    case 4:
      riff002(i);
      break;
    case 5:
      riff003(i);
      break;
    case 6:
      riff001(i);
      break;
    case 7:
      riff001(i);
      if (i==11) {
        bar=0;
        part++;
      }
      break;
    }
  }
  void phrase2(int i) {
    switch((bar-1)%15) {
    case 0:
    case 2:
    case 4:
    case 6:
    case 8:
    case 10:
    case 12:
    default:
      riff005(i);
      break;
    case 1:
    case 3:
    case 5:
    case 7:
    case 9:
    case 11:
      riff006(i);
      break;
    case 13:
      riff001(i); 
      break;   
    case 14:
      riff001(i); 
      if (i==11) {
        bar=0;
        part++;
      }
      break;
    }
  }
  void phrase3(int i) {
    if (bar==1)riff008(i);
    if (bar==4 && i==11) {
      bar=0;
      part++;
    }
  }

  void riff001(int i) {//mim
    doDrums(i, 0); 
    doBass(i, 0, 4);
    doGuitar(i, 1, 5, 4, 0);
  }
  void riff008(int i) {//mim
    doDrums(i, 0); 
    if (i==0) {
      doBass(i, 0, 4);
      doGuitar(i, 1, 5, 4, 0);
    }
  }
  void riff001_2(int i) {//mim otro
    doDrums(i, 0); 
    doBass(i, 1, 4);
    doGuitar(i, 1, 5, 4, 0);
  }
  void riff002(int i) {//LaM
    doDrums(i, 0); 
    doBass(i, 0, 9);
    doGuitar(i, 1, 5, 9, 1);
  }
  void riff002_3(int i) {//Lam
    doDrums(i, 0); 
    doBass(i, 0, 9);
    doGuitar(i, 0, 5, 9, 0);
  }
  void riff002_2(int i) {//LaM otro
    doDrums(i, 0); 
    doBass(i, 0, 9);
    doGuitar(i, 0, 5, 9, 1);
  }
  void riff003(int i) {//SolM otro
    doDrums(i, 0); 
    doBass(i, 0, 7);
    doGuitar(i, 0, 5, 7, 1);
  }
  void riff004(int i) {//Sim 
    doDrums(i, 0); 
    doBass(i, 0, 11);
    doGuitar(i, 0, 5, 11, 0);
  }
  void riff005(int i) {//DoM
    doDrums(i, 0); 
    doBass(i, 1, 0);
    doGuitar(i, 1, 5, 0, 1);
  }
  void riff006(int i) {//ReM 
    doDrums(i, 0); 
    doBass(i, 1, 2);
    doGuitar(i, 1, 5, 2, 1);
  }
  void riff007(int i) {//DoM -Mim
    boolean cond = i<12;
    doDrums(i, 0); 
    doBass(i, 1, cond?0:4);
    doGuitar(i, 1, 5, cond?0:4, cond?1:0);
  }
  void riff009(int i) {//just drums
    doDrums(i, 0);
  }



  void doDrums(int i, int mode) {
    if (i%2==0) {
      //drums.sendNote(new Note(42, (int)random(80,100) , 1));
      //score.addNote(i/4, 9, 0, 42, , 0.25, 0.8, 64);

      drumstrack.addEvent(new Note(42, (int)random(80, 100), 1), auxposition);
      drumstrack.addEvent(new Note(42, 0, 0), auxposition+1); 
      dobeat(auxposition, 42);
    }
    else {
      //drums.sendNote(new Note(44, (int)random(100,127) , 1));
      //score.addNote(i/4, 9, 0, 44, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);

      drumstrack.addEvent(new Note(44, (int)random(100, 127), 1), auxposition);
      drumstrack.addEvent(new Note(44, 0, 0), auxposition+1); 
      dobeat(auxposition, 44);
    }
    if (i%3==0 || i%3==0 || i%3==0 || (random(10)>5 && false)) {
      //if(true){
      //if(part>3)
      //drums.sendNote(new Note(38, int(i%2==0?random(100,110):random(110,125)), 1));
      //score.addNote(1*i/4+0*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      //score.addNote(1*i/4+2*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);
      //score.addNote(1*i/4+4*.125, 9, 0, 38, i%2==0?random(80,100):random(70,80), 0.25, 0.8, 64);

      drumstrack.addEvent(new Note(38, int(i%2==0?random(100, 110):random(110, 125)), 1), auxposition);
      drumstrack.addEvent(new Note(38, 0, 0), auxposition+1); 
      dobeat(auxposition, 38);
    }
    if (i==2||i==4||i==8||i==10) {//|| (part>4 && i==1) || (part>9 && i==5) || (part>11 && i==9) ){
      //drums.sendNote(new Note(36, (int)random(100,127), 1));
      //score.addNote(i/4, 9, 0, 36, random(120,127), 0.25, 0.8, 64);
      drumstrack.addEvent(new Note(36, (int)random(100, 127), 1), auxposition);
      drumstrack.addEvent(new Note(36, 0, 0), auxposition+1); 
      dobeat(auxposition, 36);
    }
  }
  void doBass(int i, int mode, int note) {
    int pitx;
    if (i%2==0 || i%3==0) {
      //bass.sendNote(new Note(+36+note+12*(i%3!=0?0:1), (int)random(80,100), 1 ));
      pitx = +36+note+12*(i%3!=0?0:1);
      basstrack.addEvent(new Note(pitx, (int)random(80, 100), 1), auxposition);//int(100+random(20))
      basstrack.addEvent(new Note(pitx, 0, 0), auxposition+1);
      basstrack2.addEvent(new Note(pitx, (int)random(80, 100), 1), auxposition);//int(100+random(20))
      basstrack2.addEvent(new Note(pitx, 0, 0), auxposition+1);
    }
    else if (mode==1) {
      pitx = +36+note;
      basstrack.addEvent(new Note(pitx, (int)random(80, 100), 1), auxposition);//int(100+random(20))
      basstrack.addEvent(new Note(pitx, 0, 0), auxposition+1);
      basstrack2.addEvent(new Note(pitx, (int)random(80, 100), 1), auxposition);//int(100+random(20))
      basstrack2.addEvent(new Note(pitx, 0, 0), auxposition+1);
    }
  }
  void doGuitar(int i, int mode, int scalle, int note, int gmode) {
    int xpitx;
    scalle--;
    //if(i%2==1)//random(100)>50)
    //if(i==0)
    xpitx = scalle*12+note+12*(i%3!=0?0:1);

    //kboard.sendNote(new Note(scalle*12+note+12*(i%3!=0?0:1), (int)random(80,100), 24));//32 ));
    guitartrack.addEvent(new Note(xpitx, (int)random(80, 100), 24), auxposition);//int(100+random(20))
    guitartrack.addEvent(new Note(xpitx, 0, 0), auxposition+1);

    if (mode!=1) {
      xpitx = scalle*12+note+3+(gmode==0?0:1)+12*(i%2!=0?0:1);
      //kboard.sendNote(new Note(scalle*12+note+3+(gmode==0?0:1)+12*(i%2!=0?0:1), (int)random(80,100), 16));//24 ));
      guitartrack.addEvent(new Note(xpitx, (int)random(80, 100), 16), auxposition);//int(100+random(20))
      guitartrack.addEvent(new Note(xpitx, 0, 0), auxposition+1);
    }
    xpitx = scalle*12+note+7+12*(i%4!=0?0:1);
    //kboard.sendNote(new Note(, (int)random(80,100), 1));//16 ));
    guitartrack.addEvent(new Note(xpitx, (int)random(80, 100), 1), auxposition);//int(100+random(20))
    guitartrack.addEvent(new Note(xpitx, 0, 0), auxposition+1);

    if (mode!=1) {
      xpitx = scalle*12+note+12+12*(i%4!=0?0:1);
      //kboard.sendNote(new Note(scalle*12+note+12+12*(i%4!=0?0:1), (int)random(80,100), 8));//8 ));  
      guitartrack.addEvent(new Note(xpitx, (int)random(80, 100), 8), auxposition);//int(100+random(20))
      guitartrack.addEvent(new Note(xpitx, 0, 0), auxposition+1);
    }
  }





  void checkLyrics(int i) {
    if (part==2 && bar==1 && i==0)presing(i, "abre sendas por los cerros");
    if (part==2 && bar==3 && i==0)presing(i, "deja su huella en el viento");
    if (part==2 && bar==5 && i==0)presing(i, "el aguila le da el vuelo");
    if (part==2 && bar==7 && i==0)presing(i, "y lo cobija el silencio");

    if (part==3 && bar==1 && i==0)presing(i, "nunka se quejo del frio");
    if (part==3 && bar==3 && i==0)presing(i, "nunka se quejo del suegno");
    if (part==3 && bar==5 && i==0)presing(i, "el pobre siente su paso");
    if (part==3 && bar==7 && i==0)presing(i, "y lo sigue como ciego");

    if (part==4 && bar==1 && i==0)presing(i, "correle, correle, correla");
    if (part==4 && bar==3 && i==0)presing(i, "por aqui, por alli, por alla");
    if (part==4 && bar==5 && i==0)presing(i, "correle, correle, correla");
    if (part==4 && bar==7 && i==0)presing(i, "correle que te van a matar");
    if (part==4 && bar==9 && i==0)presing(i, "correle, correle, correla");
    if (part==4 && bar==11 && i==0)presing(i, "correle que te van a matar");
    if (part==4 && bar==13 && i==0)presing(i, "correle, correle, correlaaaa");

    if (part==7 && bar==1 && i==0)presing(i, "su cabeza es rematada");
    if (part==7 && bar==3 && i==0)presing(i, "por cuervos con garras de oro");
    if (part==7 && bar==5 && i==0)presing(i, "como lo ha crucificado");
    if (part==7 && bar==7 && i==0)presing(i, "la furia del poderoso");

    if (part==8 && bar==1 && i==0)presing(i, "hijo de la rebeldia");
    if (part==8 && bar==3 && i==0)presing(i, "lo siguen veinte mas veinte");
    if (part==8 && bar==5 && i==0)presing(i, "porque regala su viiiiidaa");
    if (part==8 && bar==7 && i==0)presing(i, "ellos le quieren dar muerte");

    if (part==9 && bar==1 && i==0)presing(i, "correle, correle, correla");
    if (part==9 && bar==3 && i==0)presing(i, "por aqui, por alli, por alla");
    if (part==9 && bar==5 && i==0)presing(i, "correle, correle, correla");
    if (part==9 && bar==7 && i==0)presing(i, "correle que te van a matar");
    if (part==9 && bar==9 && i==0)presing(i, "correle, correle, correla");
    if (part==9 && bar==11 && i==0)presing(i, "correle que te van a matar");
    if (part==9 && bar==13 && i==0)presing(i, "correle, correle, correlaaaa");

    //  if(part==12 && bar==1 && i==0)presing(i,"hijo de la rebeldia");
    //  if(part==12 && bar==3 && i==0)presing(i,"lo siguen 20 mas 20");
    //  if(part==12 && bar==5 && i==0)presing(i,"porque regala su viiiiidaa");
    //  if(part==12 && bar==7 && i==0)presing(i,"ellos le quieren dar muerte");
    //  
    //  if(part==13 && bar==1 && i==0)presing(i,"correle, correle, correla");
    //  if(part==13 && bar==3 && i==0)presing(i,"por aqui, por allii, por alla");
    //  if(part==13 && bar==5 && i==0)presing(i,"correle, correle, correla");
    //  if(part==13 && bar==7 && i==0)presing(i,"correle que te van a matar");
    //  if(part==13 && bar==9 && i==0)presing(i,"correle, correle, correla");
    //  if(part==13 && bar==11 && i==0)presing(i,"correle que te van a matar");
    //  if(part==13 && bar==13 && i==0)presing(i,"correle, correle, correlaaa");
  }
  void presing(int i, String l) {
    lyrics[auxposition/quantization][i] =l;
    //println(auxposition+" "+i+" "+l);
  }
}
