class Features extends VZong {
  //int quantization;
  int position;

  String[] lyricsbase;
  int lyricLine;

  int part = -3;
  int auxposition;

  int bars = 93;

  Features() {
    lyrics = new String[1024][16];
    name = "features";
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

    //bassout.sendProgramChange(new ProgramChange(11)); 
    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(3)); 
    guitarout.sendProgramChange(new ProgramChange(29));//62)); 
    //bellsout.sendProgramChange(new ProgramChange(76));//62));//76)); 
    //score.empty();
    quantization = 16;
    position = 0;
    int tempo = 117;

    featuresCompose();//metacompose();

    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);
    song.addTrack(bellstrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*bars);//512*bars);//
    sequencer.setLoopCount(-1);
    sequencer.noLoop();
  }
  void featuresCompose() {
    for (part = -1; part<2; part++) {
      switch(part) {
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      default:
        demopart();
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
        doDrums(position, i, 37, 120);//, 120);
      }
    }
    position+=quantization;
  }
  void demopart() {
    int     gbasePitch           = 24+12*0+2;
    int     gpitches[]           = {
      0, 2, 3, 5, 8, 10, 12, 14, 15, 17, 20, 22
    };
    boolean ncase, bcase, kcase, vcase;
    int     n, b, k;
    int     mode =0;

    ncase=bcase=kcase=vcase=false;
    n=b=k=0;

    int mainsqnce[] = {//5,5,5,5,5,5,5,5,
      //2,2,2,2,2,2,2,2,
      0, 0, 0, 0, 0, 0, 0, 0, 
      1, 1, 1, 1, 1, 1, 1, 1, 
      //6,6,6,6,6,6,6,6,
      0, 0, 0, 0, 0, 0, 0, 0, 
      1, 1, 1, 1, 1, 1, 1, 1, 
      //6,6,6,6,6,6,6,6,
      //0,0,0,0,0,0,0,0,
      1, 4, 0, 4, 
      1, 4, 0, 4, 
      1, 4, 0, 4, 
      1, 4, 0, 4, 
      3, 3, 3, 3, 3, 3, 3, 3, 
      3, 3, 3, 3, 3, 3, 3, 3, 
      //4,4,4,4,4,4,4,4,
      1, 4, 0, 4, 
      1, 4, 0, 4, 
      1, 4, 0, 4, 
      1, 4, 0, 4, 

      6, 6, 6, 6, 6, 6, 6, 6
    };

    for (bar=0; bar<mainsqnce.length; bar++) {
      mode = mainsqnce[bar];
      int shift = 4;
      for (int i=shift; i<quantization+shift; i++) {  
        boolean kcondition = i%3==0 || mode%2!=0 || mode==6;
        switch(mode) {
        case 0:
          n = i%8==0?38:i%4==0?36:random(10)>3?46:44;
          b = gbasePitch+((i%3)==0?12:0);//+gpitches[random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;//i%2==0 || i%3==0;
          kcase = false;
          vcase = i==0;
          break;
        case 1:
          n = i%8==0?38:i%4==0?36:44;
          b = gbasePitch+((i%3)==0?12:0);//+gpitches[random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;//i%2==0 || i%3==0;
          kcase = kcondition;//i%3==0;//i%4!=0;
          vcase = i==0;
          break;
        case 2:
          n = i%8==0?38:i%4==0?36:44;
          b = gbasePitch;//+gpitches[random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = i%2==0 || i%3==0;
          bcase = true;
          kcase = false;//kcondition;//i%3==0;//i%4!=0;
          vcase = i==0;
          break;
        case 3:
          n = i%8==0?38:i%4==0?36:44;
          //b = gbasePitch+gpitches[(int)random(6)];
          b = gbasePitch+((i%3)==0?12:0);//+gpitches[random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = i%8==0;//i%2==0 || i%3==0;
          bcase = true;
          kcase = false;//i%4!=0;
          vcase = i==0;
          break;
        case 9:
          n = i%8==0?38:i%4==0?36:44;
          b = gbasePitch+gpitches[(int)random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = i%8==0;//i%2==0 || i%3==0;
          bcase = true;
          kcase = kcondition;//false;//i%4!=0;
          vcase = i==0;
          break;
        case 4:
          n = i%4==0?36:44;
          b = gbasePitch+gpitches[(int)random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;
          kcase = kcondition;//i%3==0;//i%4!=0;
          vcase = i==0;
          break;
        case 5:
          n = i%3==0? 46:44;
          b = gbasePitch+gpitches[(int)random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;
          kcase = kcondition;//i%3==0;//i%4!=0;
          vcase = i==0;
          break;
        case 6:
          n = i%3==0? 38:44;
          //b = gbasePitch+gpitches[(int)random(6)];
          b = gbasePitch+((i%3)==0?12:0);//+gpitches[random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;
          kcase = false;//kcondition;//i%3==0;//i%4!=0;
          vcase = i==0;
          break;
        case 7:
          n = i%3==0? 38:36+(int)random(12);
          b = gbasePitch+gpitches[(int)random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;
          kcase = false;//kcondition;//i%3==0;//i%4!=0;
          vcase = i==0;
          break;
        case 8:
          n = 36+(int)random(12);
          b = gbasePitch+gpitches[(int)random(6)];
          k = gbasePitch+48+gpitches[(int)random(12)];

          ncase = true;
          bcase = true;
          kcase = true;
          vcase = i==0;
          break;
        }
        if (ncase) doDrums(position, i-shift, n, n==36?127:(int)random(100, (int)random(100, 127)));
        if (bcase)  doBass(position, i-shift, b, (int)random(100, (int)random(64, 127)));
        if (kcase)doKboard(position, i-shift, k, (int)random(100, (int)random(64, 127)));
        //if(vcase) speakjet.println(random(255));
        checkLyrics(bar, i-shift);
      }
      //bar++;
      position+=quantization;
    }
  }
  void doDrums(int position, int i, int pitch, int vel) {
    drumstrack.addEvent(new Note(pitch, vel, 1), position+i);
    drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
    dobeat(position+i, pitch);
  }
  void doBass(int position, int i, int pitch, int vel) {
    basstrack.addEvent(new Note(pitch, vel, 1), position+i);
    basstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
    basstrack2.addEvent(new Note(pitch, vel, 1), position+i);
    basstrack2.addEvent(new Note(pitch, 0, 1), position+i+1);
  }
  void doKboard(int position, int i, int pitch, int vel) {
    guitartrack.addEvent(new Note(pitch, vel, (int)pow(2, (int)random(4))), position+i);
    guitartrack.addEvent(new Note(pitch, 0, 1), position+i+1);
  }

  void checkLyrics(int bar, int frame) {
    if (bar==10 && frame==0)presing("come on!");
    if (bar==11 && frame==0)presing("our voices are vices");
    if (bar==12 && frame==0)presing("cheating us");
    if (bar==13 && frame==0)presing("with the purpose of disguise");
    if (bar==14 && frame==0)presing("it's all okey");
    if (bar==15 && frame==0)presing("we are just screaming");
    if (bar==16 && frame==0)presing("and crying for nothing");
    if (bar==17 && frame==0)presing("surrounded by sirens and tear gases");

    if (bar==26 && frame==0)presing("behind your face");
    if (bar==27 && frame==0)presing("behind your words");
    if (bar==28 && frame==0)presing("i will protect and hide you again 'cause");
    if (bar==29 && frame==0)presing("it's just a harm fool");
    if (bar==30 && frame==0)presing("it's just a harmful time");
    if (bar==31 && frame==0)presing("I'm gonna be your scream");
    if (bar==32 && frame==0)presing("I'm gonna be your shouting mouth");
    if (bar==33 && frame==0)presing("I’ll take your breath and make it song");

    if (bar==34 && frame==0)presing("this is a harm fool");
    if (bar==35 && frame==0)presing("and this a harmful time");
    if (bar==36 && frame==0)presing("it's just a harm fool");
    if (bar==37 && frame==0)presing("it's just a harmful time");

    if (bar==38 && frame==0)presing("this is a harm fool");
    if (bar==39 && frame==0)presing("and this a harmful time");
    if (bar==40 && frame==0)presing("it's just a harm fool");
    if (bar==41 && frame==0)presing("it's just a harmful time");

    if (bar==42 && frame==0)presing("this is a harm fool");
    if (bar==43 && frame==0)presing("and this a harmful time");
    if (bar==44 && frame==0)presing("it's just a harm fool");
    if (bar==45 && frame==0)presing("hey!");

    if (bar==46 && frame==0)presing("this is a harm fool");
    if (bar==47 && frame==0)presing("and this a harmful time");
    if (bar==48 && frame==0)presing("it's just a fool!");
    if (bar==49 && frame==0)presing("it's just time!");

    if (bar>=58 && bar<66 && frame==0)presing("hey!");
    if (bar>=58 && bar<66 && frame==8)presing("hooo");

    if (bar==66 && frame==0)presing("this is a harm fool");
    if (bar==67 && frame==0)presing("and this a harmful time");
    if (bar==68 && frame==0)presing("it's just a harm fool");
    if (bar==69 && frame==0)presing("it's just a harmful time");

    if (bar==70 && frame==0)presing("this is a harm fool");
    if (bar==71 && frame==0)presing("and this a harmful time");
    if (bar==72 && frame==0)presing("it's just a harm fool");
    if (bar==73 && frame==0)presing("it's just a harmful time");

    if (bar==74 && frame==0)presing("this is a harm fool");
    if (bar==75 && frame==0)presing("and this a harmful time");
    if (bar==76 && frame==0)presing("it's just a harm fool");
    if (bar==77 && frame==0)presing("hey!");

    if (bar==78 && frame==0)presing("this is a harm fool");
    if (bar==79 && frame==0)presing("and this a harmful time");
    if (bar==80 && frame==0)presing("it's just a fool!");
    if (bar==81 && frame==0)presing("it's just time! just time!");

    if (bar==82 && frame==0)presing("repeat until you ceased hearing me!", false);
    if (bar==83 && frame==0)presing("repeat until you ceased hearing me!", true);
    if (bar==84 && frame==0)presing("repeat until you ceased hearing me!", false);
    if (bar==85 && frame==0)presing("repeat until you ceased hearing me!", true);
    if (bar==86 && frame==0)presing("repeat until you ceased hearing me!", false);
    if (bar==87 && frame==0)presing("repeat until you ceased hearing me!", true);
    if (bar==88 && frame==0)presing("repeat until you ceased hearing me!", false);
    if (bar==89 && frame==0)presing("repeat until you ceased hearing me!", true);
  }


  void presing(String l) {
    lyrics[bar][0] =l;//    lyrics[auxposition/quantization][i] =l;
    //println(auxposition+" "+i+" "+l);
  }
  void presing(String l, boolean f) {
    lyrics[bar][0] =l;//    lyrics[auxposition/quantization][i] =l;
    //println(auxposition+" "+i+" "+l);
  }
}
