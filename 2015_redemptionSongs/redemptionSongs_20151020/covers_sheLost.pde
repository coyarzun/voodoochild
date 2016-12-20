class SheLost extends VZong {
  int[] drumpads = {
    36, 38, 42, 44, 47, 48, 31
  };//46,47,48,42};

  String[][] drumspatterns;
  String[] basspatterns;
  int [][] bassnotes;

  //int quantization;
  int position;

  String[] lyricsbase;
  int lyricLine;

  SheLost() {
    lyrics = new String[1024][16];
    name = "SheLost";
    lyricsbase = loadStrings("shelostlyrics.txt");
    definePatterns();
    makeSong();
  }

  void makeSong() {
    beatMap = new BeatMap();
    //score.empty();
    drumstrack = new promidi.Track("drums", drumsout);
    basstrack = new promidi.Track("bass", guitarout);//bassout);
    basstrack2 = new promidi.Track("bass", bassout2);//guitarout);
    guitartrack = new promidi.Track("guitar", bassout);//guitarout);
    

    drumstrack.setQuantization(Q._1_16);
    basstrack.setQuantization(Q._1_16);
    basstrack2.setQuantization(Q._1_16);
    guitartrack.setQuantization(Q._1_16);

    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(0)); 
    guitarout.sendProgramChange(new ProgramChange(65)); 
    //score.empty();
    quantization = 16;
    position = 0;
    int tempo = 140;

    makePattern(6, 2, 0, false, true);
    makePattern(6, 2, 0, false, true);
    makePattern(6, 2, 0, false, true);
    makePattern(4, 2, 0, false, true);

    for (int i=0; i<2; i++) {
      makePattern(0, 2, 0, false, true);
      makePattern(1, 2, 0, false, true);
    }

    for (int i=0; i<2; i++) {
      makePattern(0, 0, 0, false, true);
      makePattern(1, 0, 0, false, true);
      makePattern(0, 0, 0, false, true);
      makePattern(1, 0, 0, false, true);
    }
    for (int i=0; i<8;i++) {
      makePattern(0, 0, 0, true, false);
      makePattern(0, 0, 0, false, false);
    }  
    for (int i=0; i<8;i++) {
      makePattern(0, 0, 0, true, false);
      makePattern(0, 0, 0, false, false);
    }  
    for (int i=0; i<4;i++) {
      makePattern(2, 1, 0, true, true);
      makePattern(3, 1, 0, false, true);
    }     
    for (int i=0; i<2;i++) {//makePattern(0, 0, 0);
      makePattern(1, 1, 1, false, false);
      makePattern(3, 1, 2, false, true);
      makePattern(1, 1, 3, false, false);
      makePattern(3, 1, 3, false, true);//
      makePattern(1, 1, 1, false, false);
      makePattern(3, 1, 2, false, true);
      makePattern(1, 1, 4, false, false);
      makePattern(3, 1, 4, false, true);
    }

    for (int i=0; i<2; i++) {
      makePattern(0, 0, 0, false, true);
      makePattern(1, 0, 0, false, true);
      makePattern(0, 0, 0, false, true);
      makePattern(1, 0, 0, false, true);
    }  
    for (int i=0; i<8;i++) {
      makePattern(0, 0, 0, true, false);
      makePattern(0, 0, 0, false, false);
    }  
    for (int i=0; i<4;i++) {
      makePattern(2, 1, 0, true, true);
      makePattern(3, 1, 0, false, true);
    }     
    for (int i=0; i<2;i++) {//makePattern(0, 0, 0);
      makePattern(1, 1, 1, false, false);
      makePattern(3, 1, 2, false, true);
      makePattern(1, 1, 3, false, false);
      makePattern(3, 1, 3, false, true);//
      makePattern(1, 1, 1, false, false);
      makePattern(3, 1, 2, false, true);
      makePattern(1, 1, 4, false, false);
      makePattern(3, 1, 4, false, true);
    }
    for (int i=0; i<2;i++) {//makePattern(0, 0, 0);
      makePattern(2, 1, 1, false, false);
      makePattern(3, 1, 2, false, true);
      makePattern(2, 1, 3, false, false);
      makePattern(3, 1, 3, false, true);//
      makePattern(2, 1, 1, false, true);
      makePattern(3, 1, 2, false, true);
      makePattern(2, 1, 4, false, true);
      makePattern(3, 1, 4, false, true);
    }
    for (int i=0; i<4;i++) {
      makePattern(2, 1, 0, true, true);
      makePattern(3, 1, 0, false, true);
    }     

    makePattern(5, 3, 0, false, true);
    for (int i=0;i<3;i++)makePattern(6, 2, 0, false, true);


    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*bars);
    sequencer.setLoopCount(-1);
    sequencer.noLoop();
  }
  void makePattern(int drumIndex, int bassIndex, int bassNoteIndex, boolean singa, boolean bells) {
    for (int i=0; i<16; i++) {
      int auxposition = position+i;

      for (int j=0; j<drumpads.length; j++) {
        if (!drumspatterns[drumIndex][j].substring(i, i+1).equals("-")) {
          //score.addNote(float(position+i)/4, 9, 0, drumpads[j], 80+random(40), 0.25, 0.8, 64);
          drumstrack.addEvent(new Note(drumpads[j], int(120+random(7)), 80), auxposition);
          drumstrack.addEvent(new Note(drumpads[j], 0, 0), auxposition+1); 

          dobeat(auxposition, drumpads[j]);
        }
      }
      String hxtep = basspatterns[bassIndex].substring(i, i+1);
      if (!hxtep.equals("-")) {
        int note = 24+bassnotes[bassNoteIndex][i];
        int pitx = note+unhex(hxtep);
        basstrack.addEvent(new Note(pitx, 120+(int)random(7), 80), auxposition);//int(100+random(20))
        basstrack.addEvent(new Note(pitx, 0, 0), auxposition+1);
        basstrack2.addEvent(new Note(pitx, 120+(int)random(7), 80), auxposition);//int(100+random(20))
        basstrack2.addEvent(new Note(pitx, 0, 0), auxposition+1);
        //score.addNote(float(position+i)/4, 0, 38, pitx, 80+random(40), 0.25, 0.8, 64);
      }
      if (bells) {
        int pitch = (int)score.pcRandomWalk(60+2+12*3, 12, score.MINOR_PENTATONIC);//INDIAN);
        //println(pitch);
        ////score.addNote(i/4, 1, 96, pitch, 60+random(20), random(.5,2.5), 0.5, 64);
        float v1 = 48+random(20);
        guitartrack.addEvent(new Note(pitch, int(v1), 80), auxposition);
        guitartrack.addEvent(new Note(pitch, 0, 0), auxposition+1);//+(int)random(2,5));
        //score.addNote(float(position+i)/4, 1, 38, pitch, 10+random(10), random(5,8), 0.1, 64);
      }
      //score.addCallback(float(position+i)/4, 1);//
    }
    if (singa) {
      ////vplayer.println(lyricsbase[lyricLine]);
      lyrics[int(position/16)][0] = lyricsbase[lyricLine];
      lyricLine++;
      lyricLine%=lyrics.length;
    }

    //    position+=16;
    bars++;
    position+=quantization;
  }
  void definePatterns() {
    drumspatterns = new String[7][drumpads.length];

    drumspatterns[0][0]="X-X-X---X-X-X---";
    drumspatterns[0][1]="----X-------X-X-";
    drumspatterns[0][2]="----------------";
    drumspatterns[0][3]="----------------";
    drumspatterns[0][4]="X-X------XX--X--";
    drumspatterns[0][5]="----------------";
    drumspatterns[0][6]="----------------";

    drumspatterns[1][0]="X-X-X---X-X-X---";
    drumspatterns[1][1]="----X-------X-X-";
    drumspatterns[1][2]="--XX--XX--XX--XX";
    drumspatterns[1][3]="----------------";
    drumspatterns[1][4]="X-X------XX--X--";
    drumspatterns[1][5]="----------------";
    drumspatterns[1][6]="----------------";

    drumspatterns[2][0]="X-X-X---X-X-X---";
    drumspatterns[2][1]="X---X---X---X---";
    drumspatterns[2][2]="--XX--XX--XX--XX";
    drumspatterns[2][3]="X-X------XX--X--";
    drumspatterns[2][4]="-X-X------XX--X-";
    drumspatterns[2][5]="--X--X-X------XX";
    drumspatterns[2][6]="----------------";

    drumspatterns[3][0]="X-X-X---X-X-X---";
    drumspatterns[3][1]="X---X--X-XX-X-X-";
    drumspatterns[3][2]="XXXXXXXXXXXXXXXX";
    drumspatterns[3][3]="----------------";
    drumspatterns[3][4]="----------------";
    drumspatterns[3][5]="----------------";
    drumspatterns[3][6]="----------------";

    drumspatterns[4][0]="----------------";
    drumspatterns[4][1]="----------------";
    drumspatterns[4][2]="----------------";
    drumspatterns[4][3]="----------------";
    drumspatterns[4][4]="----------------";
    drumspatterns[4][5]="----------------";
    drumspatterns[4][6]="X---X---X---X---";

    drumspatterns[5][0]="X---------------";
    drumspatterns[5][1]="X---------------";
    drumspatterns[5][2]="X---------------";
    drumspatterns[5][3]="X---------------";
    drumspatterns[5][4]="X---------------";
    drumspatterns[5][5]="X---------------";
    drumspatterns[5][6]="----------------";

    drumspatterns[6][0]="----------------";
    drumspatterns[6][1]="----------------";
    drumspatterns[6][2]="----------------";
    drumspatterns[6][3]="----------------";
    drumspatterns[6][4]="----------------";
    drumspatterns[6][5]="----------------";
    drumspatterns[6][6]="----------------";

    basspatterns = new String[4];
    basspatterns[0]=    "0-0-0-0-0-0-0-0-";
    basspatterns[1]=    "0-CC0-CC0-CC0-CC";
    basspatterns[2]=    "----------------";
    basspatterns[3]=    "0---------------";

    bassnotes = new int[5][16];
    int[] b0 = {
      //14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14                                            };  
      2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
    };
    int[] b1 = {
      7, 7, 7, 7, 7, 7, 7, 7, 9, 9, 9, 9, 9, 9, 9, 9
    };
    int [] b2 = {
      10, 10, 10, 10, 10, 10, 10, 10, 12, 12, 12, 12, 12, 12, 12, 12
    };
    int[] b3 = {
      14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14
    };  
    int[] b4 = {
      9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
    };  

    bassnotes[0] = b0;
    bassnotes[1] = b1;
    bassnotes[2] = b2;
    bassnotes[3] = b3;
    bassnotes[4] = b4;
  }
  //void rock(){
  //    //score.play();
  //    sequencer.start();
  //    rocking = true;
  //    //vplayer.println("song "+name+" rocking!");
  //  }
  //  void stop(){
  //    sequencer.stop();
  //    rocking = false;
  //    bar = 0; 
  //    frame = 0; 
  //    cframe = 0;
  //    //vplayer.println("song "+name+" stopped");
  //  }
  //  void draw(){
  //    //if(!//score.playing)stop();
  //  }
  //  void checksong(){
  //    if(rocking){
  //      bar = int(sequencer.getTickPosition()/512);
  //      frame = int((sequencer.getTickPosition()%512)/32);
  //
  //      if(oldbar!=bar || oldframe!=frame){
  //        
  //        if(lyrics[bar][frame]!=null){
  //          donmiguel.sing(lyrics[bar][frame]);
  //          vadmin.cscreen.addLyric(lyrics[bar][frame]);
  //        }
  //      };
  //      if(!false && bar<oldbar){
  //        stop();
  //      }    
  //
  //      oldbar=bar;
  //      oldframe=frame;
  //    }
  //  }
}







