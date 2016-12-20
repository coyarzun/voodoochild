class Aforest extends Zong{
  Aforest(){
    //this is a kover
    int initbars = 2;
    int endbars = 4;
    bars = initbars+(4+4+4)*4+((4)*4+8)+((4)*4+8)+4*4+((4)*4+8)+(16)*4+(2+4)*4+endbars;
    
    int[] silent = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    
    int[] aa = {9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9};
    int[] ab = {12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12};
    int[] ac = {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5};
    int[] ad = {14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14};
    
    int[] ba = {11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11};
    int[] bb = {12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12};
    int[] bc = {18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18};
    int[] bd = {6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6};
    int[] be = {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5};
    
    int base, rembase;
    
    basstab = new int[bars][16];
    basspattern = new int[bars];
    guitartab = new int[bars][16];
    guitarpattern = new int[bars];
    drumpattern = new int[bars];
    voicetab = new int[bars][16];
    lyricurl = "aforest_lyrics.txt";
    
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
    
    for(int i=initbars;i<bars-endbars;i++){
        guitarpattern[i] = 1;
        basspattern[i] = 2;
        drumpattern[i] = 2;
        voicetab[i] = silent;
    };   
    for(int i=bars-endbars;i<bars;i++){
        guitarpattern[i] = 0;
        basspattern[i] = 0;
        drumpattern[i] = 0;
        voicetab[i] = silent;
    };

    base = initbars;
    //intro
    rembase = base;
    for(int i=0;i<4;i++){
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
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    //come closer and see...
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
       
          int[] aux = {2*i,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
          voicetab[rembase+i*4+0] = aux;

      basstab[rembase+i*4+1] = ab;
        int[] aux2 = {-1,-1,-1,-1,-1,-1,-1,-1,2*i+1,-1,-1,-1,-1,-1,-1,-1};
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
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
        int[] aux = {2*i+9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
        voicetab[rembase+i*4+0] = aux;
      basstab[rembase+i*4+1] = ab;
        int[] aux2 = {-1,-1,-1,-1,-1,-1,-1,-1,2*i+9+1,-1,-1,-1,-1,-1,-1,-1};
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
        int[] aux4 = {-1,-1,-1,-1,-1,-1,-1,-1,18,-1,-1,-1,-1,-1,-1,-1};
        voicetab[rembase+7] = aux4;
      base+=8;

    //into the trees...
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      base+=4;
    }
    //suddenly i stop...
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;

        int[] aux = {2*i+20,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
        voicetab[rembase+i*4+0] = aux;

      basstab[rembase+i*4+1] = ab;
        int[] aux2 = {-1,-1,-1,-1,-1,-1,-1,-1,2*i+20+1,-1,-1,-1,-1,-1,-1,-1};
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
    for(int i=0;i<16;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = ac;
      basstab[rembase+i*4+3] = ad;
      if((i+1)%4==0)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //
    rembase = base;
    for(int i=0;i<2;i++){
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
    for(int i=0;i<4;i++){
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
    
    rembase = base;
    drumpattern[base] = 9;
    basstab[base] = aa;
    basspattern[base] = 7;
    
    guitartab = basstab;
    //guitarpattern = basspattern;

    //
    tempo = 160;
    mainlevel = 80;
    loopeable = false;
    
    basslevel = 96;
    guitarlevel = 64;
    drumlevel = 127;
    
    bassinstrument = 38;
    guitarinstrument = 28;
    
    name = "aFOREST";
    id = 2;
  }
}
