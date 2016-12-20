class AForest extends VZong {
  //Song song;
  Drummer drummer;
  Bassplayer bassplayer, bassplayer2;
  Guitarplayer guitarplayer;

  int[] drumpads = {
    36, 38, 42, 44, 47, 48, 37
  };//46,47,48,42};

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
  /******************************/
  int basstab[][];
  int basspattern[];
  int basslevel, bassinstrument;
  int guitartab[][];
  int guitarpattern[];
  int guitarlevel, guitarinstrument;
  int drumpattern[];
  int drumlevel;
  int voicetab[][];
  String lyricurl;
  int tempo, bars;
  int mainlevel;

  boolean loopeable;

  //String name;
  int id;

  String alllyrics[];
  /******************************/
  AForest() {
    drummer = new Drummer("drumpatterns.txt");
    bassplayer = new Bassplayer("basspatterns.txt");
    bassplayer2 = new Bassplayer("basspatterns.txt");
    guitarplayer = new Guitarplayer("guitarpatterns.txt");


    lyrics = new String[1024][16];
    name = "aForest";
    makeSong();
  }
  void doAForestFromPast() {
    //this is a kover
    int initbars = 2;
    int endbars = 4;
    bars = initbars+(4+4+4)*4+((4)*4+8)+((4)*4+8)+4*4+((4)*4+8)+(16)*4+(2+4)*4+endbars;

    int[] silent = {
      -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
    };

    int[] aa = {
      9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
    };
    int[] ab = {
      12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12
    };
    int[] ac = {
      5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    };
    int[] ad = {
      14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14
    };

    int[] ba = {
      11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11
    };
    int[] bb = {
      12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12
    };
    int[] bc = {
      18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18
    };
    int[] bd = {
      6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    };
    int[] be = {
      5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    };

    int base, rembase;

    basstab = new int[bars][16];
    basspattern = new int[bars];
    guitartab = new int[bars][16];
    guitarpattern = new int[bars];
    drumpattern = new int[bars];
    voicetab = new int[bars][16];
    lyricurl = "aforest_lyrics.txt";
    alllyrics = loadStrings(lyricurl);
    //fill "defaults" 
    guitarpattern[0] = 0;
    basspattern[0] = 0;
    drumpattern[0] = 0;
    basstab[0] = silent;
    voicetab[0] = silent;

    guitarpattern[1] = 0;
    basspattern[1] = 0;
    drumpattern[1] = 1;
    basstab[1] = silent;
    voicetab[1] = silent;

    for (int i=initbars;i<bars-endbars;i++) {
      guitarpattern[i] = 1;
      basspattern[i] = 2;
      drumpattern[i] = 2;
      voicetab[i] = silent;
    };   
    for (int i=bars-endbars;i<bars;i++) {
      guitarpattern[i] = 0;
      basspattern[i] = 0;
      drumpattern[i] = 0;
      voicetab[i] = silent;
    };

    base = initbars;
    //intro
    rembase = base;
    for (int i=0;i<4;i++) {
      basspattern[rembase+i*4+0] = 0;
      basspattern[rembase+i*4+1] = 0;
      basspattern[rembase+i*4+2] = 0;
      basspattern[rembase+i*4+3] = 0;
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    //come closer and see...
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;

      int[] aux = {
        2*i, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
      };
      voicetab[rembase+i*4+0] = aux;

      basstab[rembase+i*4+1] = ab;
      int[] aux2 = {
        -1, -1, -1, -1, -1, -1, -1, -1, 2*i+1, -1, -1, -1, -1, -1, -1, -1
      };
      voicetab[rembase+i*4+1] = aux2;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }

    rembase = base;

    basstab[rembase+0] = ba;
    basstab[rembase+1] = bb;
    basstab[rembase+2] = bc;
    basstab[rembase+3] = bb;
    basstab[rembase+4] = ba;
    basstab[rembase+5] = bb;
    basstab[rembase+6] = bd;
    basstab[rembase+7] = be;
    base+=8;

    //I hear her voice...
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;
      int[] aux = {
        2*i+9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
      };
      voicetab[rembase+i*4+0] = aux;
      basstab[rembase+i*4+1] = ab;
      int[] aux2 = {
        -1, -1, -1, -1, -1, -1, -1, -1, 2*i+9+1, -1, -1, -1, -1, -1, -1, -1
      };
      voicetab[rembase+i*4+1] = aux2;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    rembase = base;

    basstab[rembase+0] = ba;
    basstab[rembase+1] = bb;
    basstab[rembase+2] = bc;
    basstab[rembase+3] = bb;
    basstab[rembase+4] = ba;
    basstab[rembase+5] = bb;
    basstab[rembase+6] = bd;
    basstab[rembase+7] = be;
    int[] aux4 = {
      -1, -1, -1, -1, -1, -1, -1, -1, 18, -1, -1, -1, -1, -1, -1, -1
    };
    voicetab[rembase+7] = aux4;
    base+=8;

    //into the trees...
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    //suddenly i stop...
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;

      int[] aux = {
        2*i+20, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
      };
      voicetab[rembase+i*4+0] = aux;

      basstab[rembase+i*4+1] = ab;
      int[] aux2 = {
        -1, -1, -1, -1, -1, -1, -1, -1, 2*i+20+1, -1, -1, -1, -1, -1, -1, -1
      };
      voicetab[rembase+i*4+1] = aux2;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }

    rembase = base;

    basstab[rembase+0] = ba;
    basstab[rembase+1] = bb;
    basstab[rembase+2] = bc;
    basstab[rembase+3] = bb;
    basstab[rembase+4] = ba;
    basstab[rembase+5] = bb;
    basstab[rembase+6] = bd;
    basstab[rembase+7] = be;
    base+=8;
    //
    rembase = base;
    for (int i=0;i<16;i++) {
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      if ((i+1)%4==0)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //
    rembase = base;
    for (int i=0;i<2;i++) {
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      basspattern[rembase+i*4+0] = 7;
      basspattern[rembase+i*4+1] = 7;
      basspattern[rembase+i*4+2] = 7;
      basspattern[rembase+i*4+3] = 7;
      drumpattern[rembase+i*4+0] = 7;
      drumpattern[rembase+i*4+1] = 7;
      drumpattern[rembase+i*4+2] = 7;
      drumpattern[rembase+i*4+3] = 7;
      base+=4;
    }    
    //
    rembase = base;
    for (int i=0;i<4;i++) {
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      basspattern[rembase+i*4+0] = 7;
      basspattern[rembase+i*4+1] = 7;
      basspattern[rembase+i*4+2] = 7;
      basspattern[rembase+i*4+3] = 7;
      guitarpattern[rembase+i*4+0] = 0;
      guitarpattern[rembase+i*4+1] = 0;
      guitarpattern[rembase+i*4+2] = 0;
      guitarpattern[rembase+i*4+3] = 0;
      drumpattern[rembase+i*4+0] = 8;
      drumpattern[rembase+i*4+1] = 8;
      drumpattern[rembase+i*4+2] = 8;
      drumpattern[rembase+i*4+3] = 8;
      base+=4;
    }

    quantization =16;
    rembase = base;
    drumpattern[base] = 9;
    basstab[base] = aa;
    basspattern[base] = 7;

    guitartab = basstab;
    //guitarpattern = basspattern;
    tempo = 90;//160;
    mainlevel = 127;//80;
    loopeable = false;

    basslevel = 127;//96;
    guitarlevel = 127;//64;
    drumlevel = 127;

    bassinstrument = 1;
    guitarinstrument = 29;

    name = "aFOREST";
    id = 2;
  }
  void renderAll() {
    bassplayer.tab = basstab;
    bassplayer.kurrent = basspattern;
    bassplayer.setVolume(basslevel);
    bassplayer.setInstrument(bassinstrument);
    bassplayer.parsePatterns();
    
    bassplayer2.tab = basstab;
    bassplayer2.kurrent = basspattern;
    bassplayer2.setVolume(basslevel);
    //bassplayer2.setInstrument(bassinstrument);
    bassplayer2.parsePatterns();

    guitarplayer.tab = guitartab;
    guitarplayer.kurrent = guitarpattern;
    guitarplayer.setVolume(guitarlevel);
    guitarplayer.setInstrument(guitarinstrument);
    guitarplayer.parsePatterns();

    drummer.kurrent = drumpattern;
    drummer.setVolume(drumlevel);
    drummer.parsePatterns();


    println("all rendered");
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

    doAForestFromPast();
    dolyrics();

    //bassout.sendProgramChange(new ProgramChange(11)); 
    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(bassinstrument)); 
    guitarout.sendProgramChange(new ProgramChange(guitarinstrument));//62)); 
    //bellsout.sendProgramChange(new ProgramChange(76));//62));//76)); 
    //score.empty();
    quantization = 16;
    position = 0;
    //int 
    tempo = 160;//140;

    //metacompose();
    //compose();

    //now render 2014
    renderAll();
    //dolyrics();
    //
    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);
    song.addTrack(bellstrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(4);
    sequencer.setLoopEndPoint(512*bars);//512*position/quantization);//512*bars);//
    sequencer.setLoopCount(-1);
    sequencer.noLoop();
  }
  void dolyrics() {
    println("-->do lyrics");
    for (int i=0; i<bars; i++) {
      for (int j=0; j<quantization; j++) {
        checkLyrics(i, j);
      }
    }
  }
  void compose() {
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


  /***************************/

  void doDrums(int position, int i, int pitch, int minv, int maxv) {
    drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
    drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
    dobeat(position+i, pitch);
  }
  void doDrumsAForest(int position, int pitch, int minv, int maxv) {
    drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position);
    drumstrack.addEvent(new Note(pitch, 0, 1), position+1);
    dobeat(position, pitch);
  }
  void doBass(int position, int i, int pitch, int duration) {
    basstrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    basstrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
    basstrack2.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
    basstrack2.addEvent(new Note(pitch, 0, 1), position+i+duration);
  }
  void doBassAForest(int position, int pitch, int duration) {
    basstrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position);
    basstrack.addEvent(new Note(pitch, 0, 1), position+duration);
    basstrack2.addEvent(new Note(pitch, (int)random(100, 120), duration), position);
    basstrack2.addEvent(new Note(pitch, 0, 1), position+duration);
  }
  void doKboardAForest(int position, int pitch, int duration) {
    guitartrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position);
    guitartrack.addEvent(new Note(pitch, 0, 1), position+duration);
  }
  void checkLyrics(int i, int j) {
    int index = voicetab[i][j];
    if (index!=-1)       presing(i, j, alllyrics[index]);//,true?
  }


  void presing(int i, int j, String l, boolean isfemale) {
    //i+=2;

    lyrics[i][j] =l;
    //println(auxposition+" "+i+" "+l);
  }
  void presing(int i, int j, String l) {

    lyrics[i][j] =l;
    //println(auxposition+" "+i+" "+l);
  }






  class Bassplayer {
    //  Sequencer sequencer = new Sequencer();
    //  MidiOut midiout = midiIO.getMidiOut(1,0);
    //  Track base;
    //  Song song;

    String patterns[][];

    int mastervolume = 127;
    int volume = 127;
    float tempo = 150;
    int quantization = 16;
    int kurrent[];

    int mininstrument = 32;
    int maxinstrument = 39;
    int instrument = mininstrument;

    int minnote = 24;
    int maxnote = minnote+12*3;
    int note = minnote;

    int tab[][];

    Bassplayer(String $1) {
      String txt[] = loadStrings($1);

      patterns = new String[128][16];
      int patterncounter = 0;
      int padcounter = 0;

      for (int i=0; i<txt.length; i++) {
        String linex = txt[i];
        if (linex.length()==(quantization)) {
          patterns[patterncounter][padcounter++] = linex;
        }
        else {
          patterncounter++;
        };
      };
      //luego carga un pattern x default
      tab = new int[1][16];

      kurrent = new int[1];
      kurrent[0] = 0;
      parsePatterns();
    }
    void rawInstrument(int v) {
      setInstrument(int(mininstrument+(maxinstrument-mininstrument)*v/127));
    }
    void setInstrument(int v) {
      instrument = v;
      parsePatterns();
    }
    void rawNote(int v) {
      setNote(int(minnote+(maxnote-minnote)*v/127));
    }
    void setNote(int v) {
      note = v;
      parsePatterns();
    }
    void setMasterVolume(int v) {
      mastervolume = v;
      parsePatterns();
    }
    void setVolume(int v) {
      volume = v;
      parsePatterns();
    }
    void setTempo(float t) {
      tempo = t;
      song.setTempo(t);
    }
    void parsePatterns() {
      //    base = new Track("bass", midiout);
      //    base.setQuantization(Q._1_16);
      //                   
      //    midiout.sendProgramChange(new ProgramChange(instrument));  

      for (int k=0; k<kurrent.length; k++) {

        String[] pattern = patterns[kurrent[k]];

        float a = float(mastervolume)/127;
        float b = float(volume)/127;
        float prevol = a*b;

        for (int i=0; i<pattern.length; i++) {
          if (pattern[i]!=null) {
            String linex = pattern[i];
            //int instrument = unhex(linex.substring(0,2));
            for (int j=0; j<linex.length(); j++) {
              try {
                note = minnote+tab[k][j];
                int pitx = note+unhex(linex.substring(j, j+1));
                int vol = int(prevol*127);//int(prevol*127*unhex(linex.substring(j,j+1))/15);
                int dur = 40;
                //base.addEvent(new Note(pitx, vol, dur), j+quantization*k);
                doBassAForest(j+quantization*k, pitx, dur);
                //println("did i do a bass?");
              }
              catch(Exception e) {//NullPointerException
                //println("crashed by "+e);
              };
            };
          };
        };
      };

      //    song = new Song("bass", tempo);
      //    song.addTrack(base);
      //    //song.setTempo(tempo);
      //    sequencer.setSong(song);
      //    sequencer.setLoopStartPoint(0);
      //    sequencer.setLoopEndPoint(512*tab.length);
      //    sequencer.setLoopCount(-1);
    }
  }
  /*
33.     Acoustic Bass
   34.     Electric Bass (finger)
   35.     Electric Bass (pick) 
   36.     Fretless Bass 
   37.     Slap Bass 1   
   38.     Slap Bass 2   
   39.     Synth Bass 1  
   40.     Synth Bass 2  
   */

  class Guitarplayer {
    //  Sequencer sequencer = new Sequencer();
    //  MidiOut midiout = midiIO.getMidiOut(0,0);
    //  Track base;
    //  Song song;
    //  
    String patterns[][];
    int mastervolume = 127;
    int volume = 127;
    float tempo = 150;
    int quantization = 16;
    int kurrent[];

    int mininstrument = 24;
    int maxinstrument = 31;
    int instrument = 25;//mininstrument;

    int minnote = 48;
    int maxnote = minnote+12*3;
    int note = minnote;

    int tab[][];

    Guitarplayer(String $1) {
      String txt[] = loadStrings($1);

      patterns = new String[128][16];
      int patterncounter = 0;
      int padcounter = 0;

      for (int i=0; i<txt.length; i++) {
        String linex = txt[i];
        if (linex.length()==(quantization)) {
          patterns[patterncounter][padcounter++] = linex;
        }
        else {
          patterncounter++;
        };
      };
      //luego carga un pattern x default
      tab = new int[1][16];

      kurrent = new int[1];
      kurrent[0] = 0;
      parsePatterns();
    }
    void rawInstrument(int v) {
      setInstrument(int(mininstrument+(maxinstrument-mininstrument)*v/127));
    }
    void setInstrument(int v) {
      instrument = v;
      parsePatterns();
    }
    void rawNote(int v) {
      setNote(int(minnote+(maxnote-minnote)*v/127));
    }
    void setNote(int v) {
      note = v;
      parsePatterns();
    }
    void setMasterVolume(int v) {
      mastervolume = v;
      parsePatterns();
    }
    void setVolume(int v) {
      volume = v;
      parsePatterns();
    }
    void setTempo(float t) {
      tempo = t;
      song.setTempo(t);
    }

    void parsePatterns() {
      //    base = new Track("guitar", midiout);
      //    base.setQuantization(Q._1_16);
      //                   
      //    midiout.sendProgramChange(new ProgramChange(instrument));  

      for (int k=0; k<kurrent.length; k++) {

        String[] pattern = patterns[kurrent[k]];

        float a = float(mastervolume)/127;
        float b = float(volume)/127;
        float prevol = a*b;

        for (int i=0; i<pattern.length; i++) {
          if (pattern[i]!=null) {
            String linex = pattern[i];
            //int instrument = unhex(linex.substring(0,2));
            for (int j=0; j<linex.length(); j++) {
              try {
                note = minnote+tab[k][j];
                int pitx = note+unhex(linex.substring(j, j+1));
                int vol = int(prevol*127);//int(prevol*127*unhex(linex.substring(j,j+1))/15);
                int dur = 20;
                //base.addEvent(new Note(pitx, vol, dur), j+quantization*k); 
                doKboardAForest(j+quantization*k, pitx, dur);
              }
              catch(Exception e) {//NullPointerException
                //println("crashed by "+e);
              };
            };
          };
        };
      };

      //    song = new Song("guiatr", tempo);
      //    song.addTrack(base);
      //    //song.setTempo(tempo);
      //    sequencer.setSong(song);
      //    sequencer.setLoopStartPoint(0);
      //    sequencer.setLoopEndPoint(512*tab.length);
      //    sequencer.setLoopCount(-1);
    }
  }
  /*
25.     Acoustic Guitar (nylon)       
   26.     Acoustic Guitar (steel)         
   27.     Electric Guitar (jazz)          
   28.     Electric Guitar (clean)         
   29.     Electric Guitar (muted)        
   30.     Overdriven Guitar              
   31.     Distortion Guitar            
   32.     Guitar harmonics 
   */

  class Drummer {
    //  Sequencer sequencer = new Sequencer();
    //  MidiOut midiout = midiIO.getMidiOut(9,0);
    //  Track base;
    //  Song song;
    //  
    String patterns[][];
    int mastervolume = 127;
    int volume = 127;
    float tempo = 150;
    int quantization = 16;
    int kurrent[];

    Drummer(String $1) {
      String txt[] = loadStrings($1);

      patterns = new String[128][128];
      int patterncounter = 0;
      int padcounter = 0;

      for (int i=0; i<txt.length; i++) {
        String linex = txt[i];
        if (linex.length()==(2+1+quantization)) {
          patterns[patterncounter][padcounter++] = linex;
        }
        else {
          patterncounter++;
        };
      };
      //luego carga un pattern x default
      kurrent = new int[1];
      kurrent[0] = 0;
      parsePatterns();
    }

    void setMasterVolume(int v) {
      mastervolume = v;
      parsePatterns();
    }
    void setVolume(int v) {
      volume = v;
      parsePatterns();
    }
    void setTempo(float t) {
      tempo = t;
      song.setTempo(t);
    }

    void parsePatterns() {
      //    base = new Track("drums", midiout);
      //    base.setQuantization(Q._1_16);

      for (int k=0; k<kurrent.length; k++) {

        String[] pattern = patterns[kurrent[k]];

        float a = float(mastervolume)/127;
        float b = float(volume)/127;
        float prevol = a*b;

        for (int i=0; i<pattern.length; i++) {
          if (pattern[i]!=null) {
            String linex = pattern[i];
            int instrument = unhex(linex.substring(0, 2));

            for (int j=3; j<linex.length(); j++) {
              try {
                int vol = int(prevol*127*unhex(linex.substring(j, j+1))/15);
                //base.addEvent(new Note(instrument, vol, 80), j-3+quantization*k); 
                doDrumsAForest(j-3+quantization*k, instrument, vol, vol);
              }
              catch(Exception e) {//NullPointerException
                //println("crashed by "+e);
              };
            };
          };
        };
      };

      //    song = new Song("drums", tempo);
      //    song.addTrack(base);
      //    //song.setTempo(tempo);
      //    sequencer.setSong(song);
      //    sequencer.setLoopStartPoint(0);
      //    sequencer.setLoopEndPoint(512*kurrent.length);
      //    sequencer.setLoopCount(-1);
    }
  }
  /*drums 
   27: punch breaker
   28: clap?
   29: skratch teki high
   30: skratch teki low
   31: baquetas
   32: pt'k!
   33: rim shot
   34: cencerro?
   35: bass drum low
   36: bass drum
   37: rim shot 2
   38: snare drum
   39: clap 2
   40: high snare drum
   41: high metallic tom
   42: charles
   43: mid metallic tom 
   44: charles open
   45: low metallic tom 
   46: ride?
   47: high tom?
   48: mid tom?
   49: crash
   50: tom zaund
   51: ride? + apagao
   52: platisho shino
   53: cymbal
   54: pandero
   55: platillo raro tipo crash apagao
   56: cencerro?
   57: crash?
   58: kashta�uelas
   59: platisho doble?
   60: otro tipo de cencerro o bong�
   61: tamborcillo sambero
   62: borde de tambor apagao
   63: tipo bong�
   64: tipo bong�
   65: conga
   66: low conga
   67: claves metalicas
   68: weaitas
   69: maraca
   70: especie de maraka como grillo
   71: pito
   72: pito juerte
   73: rascando?
   74: rascando low
   75: claves?
   76: brazil este
   77: brazil este low
   78: brazil membrana tipo voz de mono
   79: brazil membrana tipo voz de mono low
   80: very brilliant brazil klaves
   81: very very brilliant brazil klaves
   82: kaskabeles
   83: brazil kaskabel metaliico?
   84: palitos o kizas q cosa
   85: kasta�eteo seko
   86: cajon
   87: timbal
   */
}


