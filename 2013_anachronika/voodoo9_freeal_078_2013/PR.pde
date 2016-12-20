class Punkrocker extends VZong{
  //Song song;

  int[] drumpads = {
    36,38,42,44,47,48,37                    };//46,47,48,42};

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

  Punkrocker(){
    lyrics = new String[1024][16];
    name = "Punkrocker";
    lyricsbase = loadStrings("session/punkrocker.txt");
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

    //bassout.sendProgramChange(new ProgramChange(65)); 
    drumsout.sendController(new Controller(0,1)); 
    drumsout.sendProgramChange(new ProgramChange(92)); 
    guitarout.sendProgramChange(new ProgramChange(4)); 
    bellsout.sendProgramChange(new ProgramChange(70)); 
    //score.empty();
    quantization = 16;
    position = 0;
    int tempo = 160;

    makePattern(3, 1, 0, 1, 0, false, false);
    makePattern(3, 1, 0, 1, 0, false, false);
    makePattern(3, 1, 0, 1, 0, false, false);
    makePattern(1, 1, 0, 1, 0, false, false);

//intro
    makePattern(0, 0, 0, 0, 0, false, false);
    makePattern(0, 0, 1, 0, 1, false, false);
    makePattern(0, 0, 2, 0, 2, false, false);
    makePattern(0, 0, 2, 0, 2, false, false);
    
    makePattern(0, 0, 0, 0, 0, false, false);
    makePattern(0, 0, 1, 0, 3, false, false);
    makePattern(0, 0, 2, 0, 4, false, false);
    makePattern(0, 0, 2, 0, 4, false, false);
    
    makePattern(0, 0, 0, 0, 0, false, false);
    makePattern(0, 0, 1, 0, 1, false, false);
    makePattern(0, 0, 2, 0, 2, false, false);
    makePattern(0, 0, 2, 0, 2, false, false);
    
    makePattern(0, 0, 0, 0, 0, false, false);
    makePattern(0, 0, 1, 0, 5, false, false);
    makePattern(0, 0, 2, 0, 4, false, false);
    makePattern(0, 0, 2, 0, 4, false, false);
    
//verse 1
    for(int i=0; i<6; i++){
    int d = i>=4 ? 4 : 0;
    boolean b = i>=2 ? true : false;
    makePattern(d, 0, 0, 1, 0, true, b);
    makePattern(d, 0, 1, 1, 0, false, b);
    makePattern(d, 0, 2, 1, 0, false, b);
    makePattern(d, 0, 2, 1, 0, false, b);
    }
//chorus
    for(int i=0; i<2; i++){
    makePattern(5, 0, 0, 1, 0, true, false);
    makePattern(5, 0, 1, 1, 0, false, false);
    makePattern(5, 0, 2, 1, 0, false, false);
    makePattern(5, 0, 2, 1, 0, false, false);
    }
//bridge tmp
    makePattern(0, 0, 0, 0, 0, false, false);
    makePattern(0, 0, 1, 0, 3, false, false);
    makePattern(0, 0, 2, 0, 4, false, false);
    makePattern(0, 0, 2, 0, 4, false, false);
    
    makePattern(0, 0, 0, 0, 0, false, false);
    makePattern(0, 0, 1, 0, 1, false, false);
    makePattern(0, 0, 2, 0, 2, false, false);
    makePattern(0, 0, 2, 0, 2, false, false);
//verse 2
    for(int i=0; i<6; i++){
    int d = i>=4 ? 4 : 0;
    boolean b = i>=2 ? true : false;
    makePattern(d, 0, 0, 1, 0, true, b);
    makePattern(d, 0, 1, 1, 0, false, b);
    makePattern(d, 0, 2, 1, 0, false, b);
    makePattern(d, 0, 2, 1, 0, false, b);
    }
//chorus 2
    for(int i=0; i<2; i++){
    makePattern(5, 0, 0, 1, 0, true, false);
    makePattern(5, 0, 1, 1, 0, false, false);
    makePattern(5, 0, 2, 1, 0, false, false);
    makePattern(5, 0, 2, 1, 0, false, false);
    }
        //    
    //makePattern(1, 1, 0, 1, 0, false, false);
//++chorus 2
    makePattern(5, 0, 0, 0, 0, true, false);
    makePattern(5, 0, 1, 0, 1, false, false);
    makePattern(5, 0, 2, 0, 2, false, false);
    makePattern(5, 0, 2, 0, 2, false, false);
    
    makePattern(4, 0, 0, 0, 0, true, false);
    makePattern(4, 0, 1, 0, 3, false, false);
    makePattern(4, 0, 2, 0, 4, false, false);
    makePattern(4, 0, 2, 0, 4, false, false);
//bridge 2
    makePattern(0, 0, 0, 1, 0, false, false);
    makePattern(0, 0, 1, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    
    makePattern(0, 0, 0, 1, 0, false, false);
    makePattern(0, 0, 1, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    
    makePattern(0, 0, 0, 1, 0, false, false);
    makePattern(0, 0, 1, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    
    makePattern(0, 0, 0, 1, 0, false, false);
    makePattern(0, 0, 1, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
    makePattern(0, 0, 2, 1, 0, false, false);
//verse 3
    for(int i=0; i<6; i++){
    int d = i>=4 ? 4 : 0;
    boolean b = i>=2 ? true : false;
    makePattern(d, 0, 0, 1, 0, true, b);
    makePattern(d, 0, 1, 1, 0, false, b);
    makePattern(d, 0, 2, 1, 0, false, b);
    makePattern(d, 0, 2, 1, 0, false, b);
    }
//chorus
    for(int i=0; i<2; i++){
    makePattern(5, 0, 0, 1, 0, true, false);
    makePattern(5, 0, 1, 1, 0, false, false);
    makePattern(5, 0, 2, 1, 0, false, false);
    makePattern(5, 0, 2, 1, 0, false, false);
    }
//++chorus
    makePattern(5, 0, 0, 0, 0, true, false);
    makePattern(5, 0, 1, 0, 1, false, false);
    makePattern(5, 0, 2, 0, 2, false, false);
    makePattern(5, 0, 2, 0, 2, false, false);
    
    makePattern(5, 0, 0, 0, 0, true, true);
    makePattern(5, 0, 1, 0, 3, false, true);
    makePattern(5, 0, 2, 0, 4, false, true);
    makePattern(5, 0, 2, 0, 4, false, true);
//++to end
    makePattern(4, 0, 0, 0, 0, false, true);
    makePattern(4, 0, 1, 0, 1, false, true);
    makePattern(4, 0, 2, 0, 2, false, true);
    makePattern(4, 0, 2, 0, 2, false, true);
    
    makePattern(4, 0, 0, 0, 0, false, true);
    makePattern(4, 0, 1, 0, 3, false, true);
    makePattern(4, 0, 2, 0, 4, false, true);
    makePattern(4, 0, 2, 0, 4, false, true);
//zuákate
    makePattern(2, 2, 0, 2, 0, false, false);    
    for(int i=0;i<3;i++)makePattern(3, 1, 0, 1, 0, false, false);

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
          drumstrack.addEvent(new Note(drumpads[j], int(120+random(7)), 80), auxposition);
          drumstrack.addEvent(new Note(drumpads[j], 0, 0), auxposition+1); 
          dobeat(auxposition, drumpads[j]);
        }
      }
      String hxtep = basspatterns[bassIndex].substring(i,i+1);
      if(!hxtep.equals("-")){
        int note = 24+bassnotes[bassNoteIndex][i];
        int pitx = note+unhex(hxtep);
        basstrack.addEvent(new Note(pitx, 120+(int)random(7), 80), auxposition);//int(100+random(20))
        basstrack.addEvent(new Note(pitx, 0, 0), auxposition+1);
      }
      String xhxtep = kbpatterns[kbIndex].substring(i,i+1);
      if(!xhxtep.equals("-")){
        int xnote = 48+kbnotes[kbNoteIndex][i];
        int xpitx = xnote+unhex(xhxtep);
        guitartrack.addEvent(new Note(xpitx, 80+(int)random(7), 80), auxposition);//int(100+random(20))
        guitartrack.addEvent(new Note(xpitx, 0, 0), auxposition+16);
      }
      if(bells){
        int ypitx = 96;
        int zpitx = 0;
        if(i%2==0){
          if(i==2 || i==6 || i==10 || i==14){
            zpitx = bellsnotes[0];
          }
          if(i==4 || i==12){
            zpitx = bellsnotes[2];
          }
          if(i==8 || i==0){
            zpitx = bellsnotes[1];
          }

        } 
        ypitx+=zpitx;
        bellstrack.addEvent(new Note(ypitx, 50+(int)random(2), 80), auxposition);//int(100+random(20))
        bellstrack.addEvent(new Note(ypitx, 0, 0), auxposition+1);
      }
      //score.addCallback(float(position+i)/4, 1);//
    }
    if(singa){
      //vplayer.println(lyricsbase[lyricLine]);
      lyrics[int(position/16)][0] = lyricsbase[lyricLine];
      lyricLine++;
      lyricLine%=lyrics.length;
    }

    //    position+=16;
    bars++;
    position+=quantization;
  }
  void definePatterns(){
    drumspatterns = new String[6][drumpads.length];

    drumspatterns[0][0]="X-------X-X-----";
    drumspatterns[0][1]="----X-------X---";
    drumspatterns[0][2]="X-X-X-X-X-X-X-X-";//"----------------";//"X-X-X-X-X-X-X-X-";
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
    
    drumspatterns[4][0]="X-------X-X-----";
    drumspatterns[4][1]="X---X---X---X---";
    drumspatterns[4][2]="X-X-X-X-X-X-X-X-";//"----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[4][3]="----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[4][4]="----------------";
    drumspatterns[4][5]="----------------";
    drumspatterns[4][6]="----------------";
    
    drumspatterns[5][0]="X---X---X-X-----";
    drumspatterns[5][1]="--X---X---X---X-";
    drumspatterns[5][2]="X-X-X-X-X-X-X-X-";//"----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[5][3]="----------------";//"X-X-X-X-X-X-X-X-";
    drumspatterns[5][4]="----------------";
    drumspatterns[5][5]="----------------";
    drumspatterns[5][6]="----------------";

    basspatterns = new String[3];
    basspatterns[0]=    "0-0-0-0-0-0-0-0-";
    basspatterns[1]=    "----------------";
    basspatterns[2]=    "0---------------";

    bassnotes = new int[3][16];
    int[] b0 = {
      17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17           };
    int[] b1 = {
      10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10           };
    int[] b2 = {
      14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14          };

    bassnotes[0] = b0;
    bassnotes[1] = b1;
    bassnotes[2] = b2;
    
    kbpatterns = new String[3];
    kbpatterns[0]=    "0-0-0-0-0-0-0-0-";
    kbpatterns[1]=    "----------------";
    kbpatterns[2]=    "0---------------";
    
    kbnotes = new int[6][16];
    int[] k0 = {
      17,17,17,17,17,17,17,17,17,17,17,17,17,19,19,19         };
    int[] k1 = {
      21,21,21,21,21,21,21,21,21,21,21,21,21,29,29,29         };
    int[] k2 = {
      26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26         };
    int[] k3 = {
      10,10,10,10,10,10,10,10,10,10,10,10,10,17,17,17         };
    int[] k4 = {
      14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14         };
    int[] k5 = {
      10,10,10,10,10,10,10,10,10,10,10,10,10,7,7,7            };

      
    kbnotes[0] = k0;
    kbnotes[1] = k1;
    kbnotes[2] = k2;
    kbnotes[3] = k3;
    kbnotes[4] = k4;
    kbnotes[5] = k5;
    
    bellsnotes = new int[3];
    bellsnotes[0] = 9;
    bellsnotes[1] = 7;
    bellsnotes[2] = 5;
  }
  void rock(){
    //score.play();
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










