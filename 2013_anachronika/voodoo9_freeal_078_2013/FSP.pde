class PFlowRZong extends VZong{
  //Song song;

  int[] drumpads = {
    36,38,42,44,47,48,37                      };//46,47,48,42};

  String[][] drumspatterns;
  String[] basspatterns;
  int [][] bassnotes;

  String[] kbpatterns;
  int [][] kbnotes;

  int[] bellsnotes;

  int quantization;
  int position;

  String[] lyricsbase;
  int lyricLine;
  
  int baaseepitch = -1;

  PFlowRZong(){
    lyrics = new String[1024][16];
    name = "POST FS";
    lyricsbase = loadStrings("session/freshwidow2010.txt");
    definePatterns();
    makeSong();
    vplayer.println("song "+name+" loaded!");
  }

  void makeSong(){
    beatMap = new BeatMap();
    //score.empty();
    drumstrack = new promidi.Track("drums", drumsout);
    basstrack = new promidi.Track("bass", bassout);
    guitartrack = new promidi.Track("kboard", guitarout);
    bellstrack = new promidi.Track("bells", bellsout);

    drumstrack.setQuantization(Q._1_16);
    basstrack.setQuantization(Q._1_16);
    guitartrack.setQuantization(Q._1_16);
    bellstrack.setQuantization(Q._1_16);

    bassout.sendProgramChange(new ProgramChange(62)); 
    guitarout.sendProgramChange(new ProgramChange(33));//62)); 
    bellsout.sendProgramChange(new ProgramChange(32));//62));//76)); 
    //score.empty();
    quantization = 16;
    position = 0;
    int tempo = 90;//117;

    makePattern(3, 1, 0, 1, 0, false, false);
    makePattern(3, 1, 0, 1, 0, false, false);
    makePattern(3, 1, 0, 1, 0, false, false);
    makePattern(1, 1, 0, 1, 0, false, false);


    //verse 1
    for(int i=0; i<128; i++){
      makePattern(1, 1, 0, 1, 0, true, true);
      //if(i%2==0 || true)baaseepitch--;//++;
      if(i%8==0)baaseepitch=-1;
      else if(i%8==1)baaseepitch=2;
      else if(i%8==4)baaseepitch=6;
      else if(i%8==5)baaseepitch=4;
      //baaseepitch%=128;
      if(baaseepitch>11)baaseepitch=-1;
    }
    //zuákate
    /*
    makePattern(2, 2, 0, 2, 0, false, false);    
     for(int i=0;i<3;i++)makePattern(3, 1, 0, 1, 0, false, false);
     */
    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(guitartrack);
    song.addTrack(bellstrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*bars);
    sequencer.setLoopCount(-1);
  }
  void makePattern(int drumIndex, int bassIndex, int bassNoteIndex , int kbIndex, int kbNoteIndex, boolean singa, boolean bells){// 
    for(int i=0; i<16; i++){
      int auxposition = position+i;

      for(int j=0; j<drumpads.length; j++){
        if(!drumspatterns[drumIndex][j].substring(i,i+1).equals("-")){
          //score.addNote(float(position+i)/4, 9, 0, drumpads[j], 80+random(40), 0.25, 0.8, 64);
          drumstrack.addEvent(new Note(drumpads[j], int(100+random(20)), 80), auxposition);
          drumstrack.addEvent(new Note(drumpads[j], 0, 0), auxposition+1); 
          dobeat(auxposition, drumpads[j]);
        }
      }
      String hxtep = basspatterns[bassIndex].substring(i,i+1);
      if(i%2==0 || true){//if(!hxtep.equals("-")){
        int note = 24+bassnotes[bassNoteIndex][i];
        //int pitx = note+unhex(hxtep);
        int pitx = i%4==0 ? 24+12+baaseepitch : (int)score.pcRandomWalk(24+12+baaseepitch, 3, score.MINOR);
        basstrack.addEvent(new Note(pitx, 110+(int)random(7), 80), auxposition);//int(100+random(20))
        basstrack.addEvent(new Note(pitx, 0, 0), auxposition+1);
      }
      String xhxtep = kbpatterns[kbIndex].substring(i,i+1);
      if(i%8==0){//if(!xhxtep.equals("-")){
        //int xnote = 48+12+kbnotes[kbNoteIndex][i];
        //int xpitx = xnote+unhex(xhxtep);
                int xpitx = i%16==0 ? 48+12+baaseepitch : (int)score.pcRandomWalk(48+12+baaseepitch, 7, score.MINOR);
        guitartrack.addEvent(new Note(xpitx, 90+(int)random(7), 80), auxposition);//int(100+random(20))
        guitartrack.addEvent(new Note(xpitx, 0, 0), auxposition+16);
      }
      if(bells){
        int ypitx = 96-12;
        int zpitx = 0;
        if(i%8==0 || i%3==0){
          ypitx = (int)score.pcRandomWalk(96-12+baaseepitch, 24, score.MINOR);

          int vvv = 90+(int)random(2);
          
          bellstrack.addEvent(new Note(ypitx, vvv, 80), auxposition);
          bellstrack.addEvent(new Note(ypitx, 0, 0), auxposition+1+(int)random(16));
          bellstrack.addEvent(new Note(ypitx+12, vvv, 80), auxposition+2);
          bellstrack.addEvent(new Note(ypitx+12, 0, 0), auxposition+1+2+(int)random(16));

        } 

      }
      //score.addCallback(float(position+i)/4, 1);//
    }
    if(singa){
      //vplayer.println(lyricsbase[lyricLine]);
      lyrics[int(position/16)][0] = "";//CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC";//"RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR";//"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM";//lyricsbase[lyricLine];
      lyricLine++;
      lyricLine%=lyrics.length;
    }

    //    position+=16;
    bars++;
    position+=quantization;
  }
  void definePatterns(){
    drumspatterns = new String[6][drumpads.length];

    drumspatterns[0][0]="X---X---X---X---";
    drumspatterns[0][1]="----X-------X---";
    drumspatterns[0][2]="--XX--XX--XX--XX";//"----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[0][3]="----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[0][4]="----------------";
    drumspatterns[0][5]="----------------";
    drumspatterns[0][6]="----------------";

    drumspatterns[1][0]="----------------";
    drumspatterns[1][1]="----------------";
    drumspatterns[1][2]="----------------";
    drumspatterns[1][3]="----------------";
    drumspatterns[1][4]="----------------";
    drumspatterns[1][5]="----------------";
    drumspatterns[1][6]="X---X---X---X---";

    drumspatterns[2][0]="X---------------";
    drumspatterns[2][1]="X---------------";
    drumspatterns[2][2]="X---------------";
    drumspatterns[2][3]="----------------";
    drumspatterns[2][4]="----------------";
    drumspatterns[2][5]="----------------";
    drumspatterns[2][6]="----------------";

    drumspatterns[3][0]="----------------";
    drumspatterns[3][1]="----------------";
    drumspatterns[3][2]="----------------";
    drumspatterns[3][3]="----------------";
    drumspatterns[3][4]="----------------";
    drumspatterns[3][5]="----------------";
    drumspatterns[3][6]="----------------";

    drumspatterns[4][0]="XXXXXXXXXXXXXXXX";
    drumspatterns[4][1]="X---X---X---X---";//"----------------";//
    drumspatterns[4][2]="XXXXXXXXXXXXXXXX";//"----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[4][3]="----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[4][4]="----------------";
    drumspatterns[4][5]="----------------";
    drumspatterns[4][6]="----------------";

    drumspatterns[5][0]="XX--XX--XX--XX--";
    drumspatterns[5][1]="--X---X---X---X-";
    drumspatterns[5][2]="XXXXXXXXXXXXXXXX";//"----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[5][3]="----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[5][4]="----------------";
    drumspatterns[5][5]="----------------";
    drumspatterns[5][6]="----------------";

    basspatterns = new String[3];
    basspatterns[0]=    "0-C-0-C-0-C-0-C-";//0-3-0-5-0-7-0-5-";
    basspatterns[1]=    "----------------";
    basspatterns[2]=    "0---------------";

    bassnotes = new int[5][16];

    int[] b0 = {
      14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14               };
    int[] b1 = {
      9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9              };
    int[] b2 = {
      10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10      }; 
    int[] b3 = {
      10,10,10,10,10,10,10,10,10,10,10,10,9,9,9,9      }; 
    int[] b4 = {
      10,10,10,10,10,10,10,10,10,10,10,10,12,12,12,12      }; 

    bassnotes[0] = b0;
    bassnotes[1] = b1;
    bassnotes[2] = b2;
    bassnotes[3] = b3;
    bassnotes[4] = b4;


    kbpatterns = new String[3];
    kbpatterns[0]=    "0-7-0-3-0-5-0-3-";//"0-3-0-5-0-7-0-5-" ;//"0-CC0-CC0-CC0-CC";//"0-3-0-5-0-7-0-5-" ;//"0-C-0-C-0-C-0-C-";//0-3-0-5-0-7-0-5-";
    kbpatterns[1]=    "----------------";//"0--C---7--5-0---";//"----------------";//"C-3---5---7-0-0-";//"0-3-7-5---7-0-0-";//"C-3---5---7-0-0-";//"C-----5---7-0---";
    kbpatterns[2]=    "0---------------";

    kbnotes = new int[6][16];

    int[] k0 = {
      14,14,14,14,14,14,14,14,9,9,9,9,9,9,9,9             };
    int[] k1 = {
      9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9     };
    int[] k2 = {
      10,10,10,10,10,10,10-1,10,10,10,10+2,10,10,10,10-1,10     };
    int[] k3 = {
      9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9     };
    int[] k4 = {
      10,10,10,10,10,10,10-1,10,10,10,10+2,10,10+12,10,10-1,10     };
    int[] k5 = {
      14,14,14,14,14,14,14,14,9,9,9,9,9,9,9,9             };

    kbnotes[0] = k0;
    kbnotes[1] = k1;
    kbnotes[2] = k2;
    kbnotes[3] = k3;
    kbnotes[4] = k4;
    kbnotes[5] = k5;

    bellsnotes = new int[4];
    bellsnotes[0] = 0;//3;
    bellsnotes[1] = 5;//3;
    bellsnotes[2] = 0;//7;
    bellsnotes[3] = 12;//5;
  }
  void rock(){
    sequencer.start();
    rocking = true;
    vplayer.println("song "+name+" rocking!");
  }
  void stop(){
    sequencer.stop();
    rocking = false;
    bar = 0; 
    frame = 0; 
    cframe = 0;
    vplayer.println("song "+name+" stopped");
  }
  void draw(){
    //if(!//score.playing)stop();
  }
  void checksong(){
    if(rocking){
      bar = int(sequencer.getTickPosition()/512);
      frame = int((sequencer.getTickPosition()%512)/32);

      if(oldbar!=bar || oldframe!=frame){

        if(lyrics[bar][frame]!=null){
          donmiguel.sing(lyrics[bar][frame]);
          vadmin.cscreen.addLyric(lyrics[bar][frame]);
        }
      };
      if(!false && bar<oldbar){
        stop();
      }    

      oldbar=bar;
      oldframe=frame;
    }
  }
}











