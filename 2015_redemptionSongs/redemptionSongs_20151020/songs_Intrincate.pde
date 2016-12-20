class IntricateSpatioTemporalOrganizations extends VZong {
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

  IntricateSpatioTemporalOrganizations() {
    lyrics = new String[1024][16];
    name = "Intrincate Spatio Temporal Organizations";
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
    guitarout.sendProgramChange(new ProgramChange(109));//62));

    quantization = 16;
    position = 0;
    int tempo = 110;

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
    for (part = -1; part<12; part++) {
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
      case 1:
      case 4:
      case 8:
        part001x();
        break;
      case 3:
      case 5:
        part002();
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
  void part001x() {  
    for (bar=0; bar<4*1; bar++) {
      switch(bar%2) {
      default: 
        riff001c();
        break;
      case 1:
        riff001d();
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
  void riff001a() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001a(position, i);
      kboard001b(position, i);
    }
    position+=quantization;
  }
  void riff001b() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001b(position, i);
      kboard001a(position, i);
    }
    position+=quantization;
  }
  void riff001c() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001a(position, i);
      //kboard001a(position, i);
    }
    position+=quantization;
  }
  void riff001d() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001a(position, i);//b
      //kboard001b(position, i);
    }
    position+=quantization;
  }
  void riff002a() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001a(position, i);
      kboard002a(position, i);
    }
    position+=quantization;
  }
  void riff002b() {
    for (int i=0; i<quantization; i++) {
      drums001(position, i);
      bass001b(position, i);
      kboard002b(position, i);
    }
    position+=quantization;
  }
  /***************************/
  void drums001(int position, int i) {
    if (i%4==0 || i==1 || i==2 || i==9 || i==10 || i==12 || i==14 )
      //if(i==0 || i==3 || i==6 || i==7 || i==10 || i==13 || i==14 || i==15) 
      doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
    //if(i%
    if (i%3==1 || i%7==6) {
      doDrums(position, i, 39, 96, 96);
      doDrums(position, i+1, 39, 64, 64);
    }
    if (i%3==0) doDrums(position, i, 37, 100, 120);
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    if (i%8==4) {// ||i%12==2){
      doDrums(position, i, 38, 127, 100);
      doDrums(position, i, 44, 100, 100);
    }
  }
  void bass001a(int position, int i) {
    if (i==0)  doBass(position, i, 38, 3);
    else if (i==3)  doBass(position, i, 41, 2);
    else if (i==5)  doBass(position, i, 38, 1);
    else if (i==6)  doBass(position, i, 41, 1);
    else if (i==7)  doBass(position, i, 45, 1);
    else if (i==10) doBass(position, i, 43, 2);
    else if (i==12) doBass(position, i, 41, 1);
    else if (i==13) doBass(position, i, 43, 3);
    else if (i%3==0  && i<12) {
      doBass(position, i, 38-12, 1);
      doBass(position, i+2, 38, 1);
    }
  }
  void bass001b(int position, int i) {
    if (i==0)  doBass(position, i, 40, 3);
    else if (i==3)  doBass(position, i, 45, 2);
    else if (i==5)  doBass(position, i, 40, 4);
    else if (i==6)  doBass(position, i, 38, 1);
    else if (i==7)  doBass(position, i, 40, 2);
    else if (i==9)  doBass(position, i, 41, 3);
    else if (i==12) doBass(position, i, 41, 4);
    else if (i%3==0 && i<12) {
      doBass(position, i, 40-12, 1);
      doBass(position, i+2, 40, 1);
    }
  }
  void bass002a(int position, int i) {
    if (i==0)  doBass(position, i, 38, 1);
    else if (i==1)  doBass(position, i, 50, 1);
    else if (i==2)  doBass(position, i, 45, 3);
    else if (i==5)  doBass(position, i, 38, 2);
    else if (i==7)  doBass(position, i, 45, 2);
    else if (i==10)  doBass(position, i, 43, 2);
    else if (i==12)  doBass(position, i, 38, 2);
    else if (i==13)  doBass(position, i, 41, 2);
    //else if(i==10) doBass(position, i, 43, 2);
    //else if(i==12) doBass(position, i, 41, 1);
    //else if(i==13) doBass(position, i, 43, 3);
    else if (i%3==0) {
      doBass(position, i, 38, 1);
      doBass(position, i+2, 38+12, 1);
    }
  }
  void bass002b(int position, int i) {//0 4 6 10 12
    if (i==0)  doBass(position, i, 38, 4);
    else if (i==3)  doBass(position, i, 45-12, 2);
    else if (i==5)  doBass(position, i, 38-12, 4);
    else if (i==7)  doBass(position, i, 45, 2);
    else if (i==10)  doBass(position, i, 43-12, 2);
    else if (i==12)  doBass(position, i, 38, 2);
    else if (i==13)  doBass(position, i, 41, 2);
    else if (i%3==0) {
      doBass(position, i, 38, 1);
      doBass(position, i+2, 38+12, 1);
    }
  }
  void kboard001(int position, int i) {
    if (i%6==0)
      doKboard(position, i, 38+24, 1);
    if (i%3==1)doKboard(position, i, 38+24+(random(100)>50?3:7), 1);
    else if (i==0 || i==9 || i==12 || i==7) {
      doKboard(position, i, 38+12, 1);
      doKboard(position, i+2, 38+12, 2);
    }
  }
  void kboard001a(int position, int i) {
    if (i==0+1)  doKboard(position, i, 38+24, 4);
    //  else if(i==6+1)  doKboard(position, i, 41+24, 4);
    //  else if(i==10+1)  doKboard(position, i, 38+24, 2);
    //  else if(i==12+1)  doKboard(position, i, 45+24, 2);
    //  else if(i==14+1)  doKboard(position, i, 43+24, 2);
    //  //else if(i==10) doBass(position, i, 43, 2);
    //  //else if(i==12) doBass(position, i, 41, 1);
    //  //else if(i==13) doBass(position, i, 43, 3);
    //  else 
    if (i%3==0 && i<12) {
      doKboard(position, i, 38+24, 1);
      doKboard(position, i+2, 38+12+24, 1);
    }
  }
  void kboard001b(int position, int i) {//0 4 6 10 12
    if (i==0)  doKboard(position, i, 38+24, 4);
    //  else if(i==4)  doKboard(position, i, 45-12+24, 2);
    //  else if(i==6)  doKboard(position, i, 38-12+24, 4);
    //  else if(i==10)  doKboard(position, i, 40-12+24, 2);
    //  else if(i==14)  doKboard(position, i, 41-12+24, 2);
    //  //else if(i==12) doBass(position, i, 41, 4);
    //  else 
    if (i%3==0 && i<12) {//){
      doKboard(position, i, 38+24, 1);
      doKboard(position, i+2, 38+12+24, 1);
    }
  }
  void kboard002a(int position, int i) {
    if (i==0) {  
      doKboard(position, i, 45+24+12, 3);  
      doKboard(position, i+1, 38+24+12+12, 3);
    }
    //  else if(i==4)  doKboard(position, i, 40+24, 4);
    else if (i==6) {
      doKboard(position, i, 41+24+12+12, 1);
      doKboard(position, i+1, 38+24+12+12+12, 1);
    }
    //  else if(i==7)  doKboard(position, i, 40+24, 2);
    else if (i==9)  doKboard(position, i, 38+24+12, 3);
    else if (i==13)  doKboard(position, i, 45+24+12+12, 3);
    //  else if(i==12) doKboard(position, i, 41+24, 4);
    //  else 
    if (i%3==0 && i<12) {    
      doKboard(position, i, 41-12+24+12, 1);    
      doKboard(position, i+1, 38+24+12, 1);
    }
  }
  void kboard002b(int position, int i) {
    if (i==0) {  
      doKboard(position, i, 38+24+12, 3);  
      doKboard(position, i+1, 38+24+12+12, 3);
    }
    //  else if(i==4)  doKboard(position, i, 40+24, 4);
    else if (i==6) {
      doKboard(position, i, 38+24+12+12, 1);
      doKboard(position, i+1, 38+24+12+12+12, 1);
    }
    //  else if(i==7)  doKboard(position, i, 40+24, 2);
    else if (i==9)  doKboard(position, i, 41+24+12, 3);
    else if (i==13)  doKboard(position, i, 45+24+12+12, 3);
    //  else if(i==12) doKboard(position, i, 41+24, 4);
    //  else 
    if (i%3==0 && i<12) {    
      doKboard(position, i, 38-12+24+12, 1);    
      doKboard(position, i+1, 38+24+12, 1);
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
    if (i==14 && j==0)presing(i, j, "Intricate is just a word to say");//,true?
    if (i==16 && j==0)presing(i, j, "that is not easy to talk about this");
    if (i==18 && j==0)presing(i, j, "that nobody knows how we reach this point");
    if (i==20 && j==0)presing(i, j, "and still is a secret we reach the shore");
    //
    if (i==26 && j==0)presing(i, j, "Spatial is just a word to define");
    if (i==28 && j==0)presing(i, j, "our embodied and bleeding condition");
    if (i==30 && j==0)presing(i, j, "our aim on stay togeher");
    if (i==32 && j==0)presing(i, j, "and still the secret shore we reached");
    //
    if (i==54 && j==0)presing(i, j, "Temporal is just a word to refer");
    if (i==56 && j==0)presing(i, j, "that time has being doing his work here");
    if (i==58 && j==0)presing(i, j, "that rain and wind have fallen enogh");
    if (i==60 && j==0)presing(i, j, "to reach those secrets stills after the storm");

    if (i==62 && j==0)presing(i, j, "Organization is just a word to say");
    if (i==64 && j==0)presing(i, j, "here we found much more than chaos");
    if (i==66 && j==0)presing(i, j, "your smell remind me futures");
    if (i==68 && j==0)presing(i, j, "and something real emerges");

    if (i==74 && j==0)presing(i, j, "that rain and wind have fallen enogh");
    if (i==76 && j==0)presing(i, j, "to reach those secrets stills after the storm");
  }
  void presing(int i, int j, String l, boolean isfemale) {
    lyrics[i][j] =l;
  }
  void presing(int i, int j, String l) {
    lyrics[i][j] =l;
  }
}
