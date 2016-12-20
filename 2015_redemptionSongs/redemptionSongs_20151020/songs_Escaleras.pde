class Escaleras extends VZong {
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

  Escaleras() {
    lyrics = new String[1024][12];
    name = "escaleras";
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
    drumsout.sendProgramChange(new ProgramChange(0)); 
    guitarout.sendProgramChange(new ProgramChange(5));//62)); 
    //bellsout.sendProgramChange(new ProgramChange(76));//62));//76)); 
    //score.empty();
    quantization = 12;
    position = 0;
    int tempo = 120;

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
    sequencer.setLoopEndPoint(384*position/quantization);//512*bars);//
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
    for (part = -1; part<19; part++) {
      switch(part) {
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      case 1:
        part001();
        break;
      case 2:
        part002();
        break;
      case 3:
        part002b();
      case 4:
        part003();
        break;
      case 5:
        part004();
        break;
      case 6:
        part005();
        break;

      case 7:
        part002a();
        break;
      case 8:
        part002b();
      case 9:
        part003b();
        break;
      case 10:
        part004b();
        break;
      case 11:
        part005b();
        break;


        /*
      case 12:
         case 13:
         part002();
         case 14:
         part003();
         break;
         case 15:
         part004b();
         break;
         case 16:
         case 17:
         part006b();
         break;
         */
      case 12:
        part003();
        break;
      case 13:
      case 14:
      case 15:
      case 16:
        part004bmx();
        break;
        //part006b();
        //break;
      case 17://18:
        prediend();
        break;
      case 18:
        diend();
      default:
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
  void prediend() {
    for (int i=0; i<quantization; i++) {
      if (i==0) {//quantization){
        //int i=0;
        /*
      doDrums(position, i, 36, 120, 120);
         doDrums(position, i, 38, 96, 120);
         doDrums(position, i, 44, 110, 120);
         */
        doBass(position, i, 45-12, 12);
        //doKboard(position, i, mim[0], 12);doKboard(position, i, mim[1], 12);doKboard(position, i, mim[2], 12);
        doKboard(position, i, lam[0], 160);
        doKboard(position, i, lam[1], 160);
        doKboard(position, i, lam[2], 160);
        //}else{
        //riff000c();
      }
    }
    position+=quantization;
  }
  void diend() {
    //for(int i=0; i<quantization; i++){
    //if(i==quantization){
    int i=0;
    /*
      doDrums(position, i, 36, 120, 127);
     doDrums(position, i, 38, 96, 120);
     doDrums(position, i, 44, 110, 120);*/
    doBass(position, i, 45-12, 160);
    doKboard(position, i, lam[0], 160);
    doKboard(position, i, lam[1], 160);
    doKboard(position, i, lam[2], 160);
    //}else{
    //riff000c();
    //}
    //}
    position+=quantization;
  }
  void part001() {  
    for (bar=0; bar<4*4*1; bar++) {
      riff000();
    }
  }
  void part002() {  
    //for(int i=0; i<2;i++){
    for (bar=0; bar<8; bar++) {
      if (bar<4)riff000b();
      else riff001b();
    }
    //}
  }
  void part002a() {  
    //for(int i=0; i<2;i++){
    for (bar=0; bar<8; bar++) {
      if (bar<4)riff000c();
      else riff001c();
    }
    //}
  }
  void part002b() {  
    for (int i=0; i<2;i++) {
      for (bar=0; bar<8; bar++) {
        if (bar<4)riff000c();
        else riff001c();
      }
    }
  }
  void part003() {  
    for (bar=0; bar<8; bar++) {
      if (bar<4)riff002b();
      else riff001b();
    }
  }
  void part003b() {  
    for (bar=0; bar<8; bar++) {
      if (bar<4)riff002c();//2c
      else riff001c();
    }
  }
  void part004() {  
    for (bar=0; bar<8; bar++) {
      if (bar<4)riff002b();
      else if (bar<6)riff003b();
      else riff000b();
    }
  }
  void part004b() {  
    for (bar=0; bar<8; bar++) {
      if (bar<4)riff002c();
      else if (bar<6)riff003c();
      else riff000c();
    }
  }
  void part004bmx() {  
    for (bar=2; bar<8; bar++) {
      if (bar<4)riff002c();
      else if (bar<6)riff003c();
      else riff000c();
    }
  }
  void part005() {  
    for (bar=0; bar<4*2; bar++) {
      riff001b();
    }
  }
  void part005b() {  
    for (bar=0; bar<4*2; bar++) {
      riff001c();
    }
  }
  void part006() {  
    for (bar=0; bar<4*4; bar++) {
      riff001();
    }
  }
  void part006b() {  
    for (bar=0; bar<4*4; bar++) {
      riff001b();
    }
  }
  void part006c() {  
    for (bar=0; bar<4*4; bar++) {
      riff001c();
    }
  }
  void riff000() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassLam(position, i);
      kboardLam(position, i);
    }
    position+=quantization;
  }
  void riff000b() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bassLam(position, i);
      //kboardLam(position, i);
    }
    position+=quantization;
  }
  void riff000c() {
    for (int i=0; i<quantization; i++) {
      drums003(position, i);
      bassLam(position, i);
      kboardLam(position, i);
    }
    position+=quantization;
  }
  void riff001() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassMim(position, i);
      kboardMim(position, i);
    }
    position+=quantization;
  }
  void riff001b() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bassMim(position, i);
      //kboardMim(position, i);
    }
    position+=quantization;
  }
  void riff001c() {
    for (int i=0; i<quantization; i++) {
      drums003(position, i);
      bassMim(position, i);
      kboardMim(position, i);
    }
    position+=quantization;
  }
  void riff002() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassDoM(position, i);
      //kboardDoM(position, i);
    }
    position+=quantization;
  }
  void riff002b() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bassDoM(position, i);
      //kboardDoM(position, i);
    }
    position+=quantization;
  }
  void riff002c() {
    for (int i=0; i<quantization; i++) {
      drums003(position, i);
      bassDoM(position, i);
      kboardDoM(position, i);
    }
    position+=quantization;
  }
  void riff002d() {
    for (int i=0; i<quantization; i++) {
      drums003(position, i);
      bassDoM(position, i);
      kboardDoMb(position, i);
    }
    position+=quantization;
  }
  void riff003() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bassSim(position, i);
      kboardSim(position, i);
    }
    position+=quantization;
  }
  void riff003b() {
    for (int i=0; i<quantization; i++) {
      drums002(position, i);
      bassSim(position, i);
      kboardSim(position, i);
    }
    position+=quantization;
  }
  void riff003c() {
    for (int i=0; i<quantization; i++) {
      drums003(position, i);
      bassSim(position, i);
      kboardSim(position, i);
    }
    position+=quantization;
  }
  /***************************/
  void drums001(int position, int i) {
    if (i%4==0 || i%10==0)
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  }
  void drums002(int position, int i) {
    if (i%4==0 || i%10==0)
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    if (i%4==0)
      doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
    else if (i%4==2)
      doDrums(position, i, 44, 110, 120);
  }
  void drums003(int position, int i) {
    if (i%6==0)
      doDrums(position, i, 38, 96, 100);
    else if (i%4==0 || i%10==0)
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    if (i%4==0)
      doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
    else if (i%4==2)
      doDrums(position, i, 44, 110, 120);
  }
  //
  void bassLam(int position, int i) {
    //if(i==0 || i==4 || i==8 || i==12){ 
    if (i%4==0 || i%3==0) {
      doBass(position, i, 45-12, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doBass(position, i, 45+12-12, 1);
    }
  }
  void bassSim(int position, int i) {
    //if(i==0 || i==4 || i==8 || i==12){ 
    if (i%4==0 || i%3==0) {
      doBass(position, i, 45+2-12, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doBass(position, i, 45+12+2-12, 1);
    }
  }
  void bassMim(int position, int i) {
    //if(i==0 || i==4 || i==8 || i==12){ 
    if (i%4==0 || i%3==0) {
      doBass(position, i, 40+12-12, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doBass(position, i, 40+12+12-12, 1);
    }
  }
  void bassDoM(int position, int i) {
    //if(i==0 || i==4 || i==8 || i==12){ 
    if (i%4==0 || i%3==0) {
      doBass(position, i, 40+12-4-12, 1);
    }
    if (i==2 || i==6 || i==10 || i==14) {
      doBass(position, i, 40+12+12-4-12, 1);
    }
  }
  //
  void kboardLam(int position, int i) {
    i*=2;
    doKboard(position, i%quantization, lam[2-i%3], 8);
    i*=2;
    doKboard(position, i%quantization, lam[2-i%3], 8);
  }
  void kboardSim(int position, int i) {
    i*=4;
    doKboard(position, i%quantization, sim[2-i%3], 8);
  }
  void kboardMim(int position, int i) {
    i*=2;
    doKboard(position, i%quantization, mim[2-i%3], 8);
    doKboard(position, (i+2)%quantization, mim[2-i%3]+12, 8);
  }
  void kboardDoM(int position, int i) {
    i*=2;
    doKboard(position, i%quantization, doM[2-i%3], 8);
  }
  void kboardDoMb(int position, int i) {
    doKboard(position, i%quantization, doM[2-i%3], 8);
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
  void checkLyrics(int bar, int frame) {
    if (bar==8 && frame==0)presing(bar, frame, "rapiña coronada de rapiña", true);
    if (bar==10 && frame==0)presing(bar, frame, "devora todo a tu paso", true);
    if (bar==12 && frame==0)presing(bar, frame, "te desmembras y caes", true);
    if (bar==14 && frame==0)presing(bar, frame, "desde el cielo envenenado", true);
    if (bar==16 && frame==0)presing(bar, frame, "en nuestra ambición", true);
    if (bar==18 && frame==0)presing(bar, frame, "las columnas c levantan", true);
    if (bar==20 && frame==0)presing(bar, frame, "sobre el valle", true);
    if (bar==22 && frame==0)presing(bar, frame, "de agua irrespirable", true);  

    if (bar==24 && frame==0)presing(bar, frame, "condoro arcano", false);
    if (bar==26 && frame==0)presing(bar, frame, "error preconcebido", false);
    if (bar==28 && frame==0)presing(bar, frame, "ungido en tu emblema", false);
    if (bar==30 && frame==0)presing(bar, frame, "de muerte", false);
    if (bar==32 && frame==0)presing(bar, frame, "cobija el grito", false); 
    if (bar==34 && frame==0)presing(bar, frame, "impronunciable de la vida", false);
    if (bar==36 && frame==0)presing(bar, frame, "abre tus alas y guía", false);
    if (bar==38 && frame==0)presing(bar, frame, "mi caminar ciego en las escaleras", false);

    if (bar==56 && frame==0)presing(bar, frame, "la ambicion marcada en la sangre");
    if (bar==58 && frame==0)presing(bar, frame, "devora todo a su paso");
    if (bar==60 && frame==0)presing(bar, frame, "te desmembra y caes");
    if (bar==62 && frame==0)presing(bar, frame, "desde un cielo envenenado");

    if (bar==72 && frame==0)presing(bar, frame, "condoro arcano", true);
    if (bar==74 && frame==0)presing(bar, frame, "error preconcebido", true);
    if (bar==76 && frame==0)presing(bar, frame, "ungido en tu emblema", true);
    if (bar==78 && frame==0)presing(bar, frame, "de muerte", true);
    if (bar==80 && frame==0)presing(bar, frame, "cobija el grito", true); 
    if (bar==82 && frame==0)presing(bar, frame, "impronunciable de la vida", true);
    if (bar==84 && frame==0)presing(bar, frame, "abre tus alas y guía", true);
    if (bar==86 && frame==0)presing(bar, frame, "mi caminar ciego en las escaleras", true);

    if (bar==88 && frame==0)presing(bar, frame, "la ambicion marcada en la sangre", false);
    if (bar==90 && frame==0)presing(bar, frame, "devora todo a su paso", false);
    if (bar==92 && frame==0)presing(bar, frame, "te desmembra y caes", false);
    if (bar==94 && frame==0)presing(bar, frame, "desde un cielo envenenado", false);

    if (bar==112 && frame==0)presing(bar, frame, "cobija el grito", true); 
    if (bar==114 && frame==0)presing(bar, frame, "impronunciable de la vida", true);
    if (bar==116 && frame==0)presing(bar, frame, "abre tus alas y guía", true);
    if (bar==118 && frame==0)presing(bar, frame, "mi caminar ciego en las escaleras", true);

    if (bar==128 && frame==0)presing(bar, frame, "rapiña coronada de rapiña", true);
    if (bar==130 && frame==0)presing(bar, frame, "devora todo a tu paso", false);
    if (bar==132 && frame==0)presing(bar, frame, "te desmembras y caes", true);
    if (bar==134 && frame==0)presing(bar, frame, "desde el cielo envenenado", false);
    if (bar==136 && frame==0)presing(bar, frame, "en nuestra ambición", true);
    if (bar==138 && frame==0)presing(bar, frame, "las columnas c levantan", false);
    if (bar==140 && frame==0)presing(bar, frame, "sobre el valle", true);
    if (bar==142 && frame==0)presing(bar, frame, "de agua irrespirable", false);  

    if (bar==144 && frame==0)presing(bar, frame, "condoro arcano", false);
    if (bar==146 && frame==0)presing(bar, frame, "error preconcebido", true);
    if (bar==148 && frame==0)presing(bar, frame, "ungido en tu emblema", false);
    if (bar==150 && frame==0)presing(bar, frame, "de muerte", true);
    if (bar==152 && frame==0)presing(bar, frame, "cobija el grito", false); 
    if (bar==154 && frame==0)presing(bar, frame, "impronunciable de la vida", true);
    if (bar==156 && frame==0)presing(bar, frame, "abre tus alas y guía", false);
    if (bar==158 && frame==0)presing(bar, frame, "mi caminar ciego en las escaleras", true);
  }
  //158

  void presing(int i, int j, String l, boolean isfemale) {
    i+=2;
    lyrics[i][j] =l;
    //println(auxposition+" "+i+" "+l);
  }
  void presing(int i, int j, String l) {
    i+=2;
    lyrics[i][j] =l;
    //println(auxposition+" "+i+" "+l);
  }
}
