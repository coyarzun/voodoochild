class Ahardplace extends Zong{
  Ahardplace(){
    int initbars = 2;
    int endbars = 4;
    bars = initbars+8*2+4*4+4*2+4*4+4*2+4*2+4*4+4*2+8*2+endbars;
    
    int[] silent = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    
    int[] aa = {0,0,0,0,0,0,0,0,12,12,12,12,12,12,12,12};
    int[] ab = {0,0,0,0,0,0,0,0,14,14,14,14,14,14,14,14};     
    
    int[] ba = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    int[] bb = {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3};
    int[] bc = {2,2,2,2,2,2,3,3,3,3,2,2,2,2,2,2};
    
    int[] ca = {0,0,0,0,0,0,3,3,3,3,3,3,2,2,2,2};
    int[] cb = {-4,-4,-4,-4,-4,-4,5,5,5,5,5,5,5,5,5,5};
    
    int base, rembase;
    
    basstab = new int[bars][16];
    basspattern = new int[bars];
    guitartab = new int[bars][16];
    guitarpattern = new int[bars];
    drumpattern = new int[bars];
    voicetab = new int[bars][16];
    lyricurl = "ahardplace_lyrics.txt";
    
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
        basspattern[i] = 4;
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
    int[] va = {0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    voicetab[rembase] = va;
    for(int i=0;i<8;i++){
      basstab[rembase+i*2+0] = aa;
      basstab[rembase+i*2+1] = ab;
            if(i==7)drumpattern[rembase+i*2+1] = 3;
      base+=2;
    }
    //verse 1
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = ba;
      basstab[rembase+i*4+1] = ba;
      basstab[rembase+i*4+2] = bb;
      basstab[rembase+i*4+3] = bc;
      if(i==3)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //shiorus
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*2+0] = aa;
      basstab[rembase+i*2+1] = ab;
      if(i==3)drumpattern[rembase+i*2+1] = 3;
      base+=2;
    }
    //verse 2
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = ba;
      basstab[rembase+i*4+1] = ba;
      basstab[rembase+i*4+2] = bb;
      basstab[rembase+i*4+3] = bc;
      if(i==3)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //bridge
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*2+0] = ca;
      basstab[rembase+i*2+1] = cb;
      basspattern[rembase+i*2+0] = 1;
      basspattern[rembase+i*2+1] = 1;
      base+=2;
    }
    //shiorus
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*2+0] = aa;
      basstab[rembase+i*2+1] = ab;
      if(i==3)drumpattern[rembase+i*2+1] = 3;
      base+=2;
    }
    //verse 3
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = ba;
      basstab[rembase+i*4+1] = ba;
      basstab[rembase+i*4+2] = bb;
      basstab[rembase+i*4+3] = bc;
      if(i==3)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //bridge2
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*2+0] = ca;
      basstab[rembase+i*2+1] = cb;
      basspattern[rembase+i*2+0] = 1;
      basspattern[rembase+i*2+1] = 1;
      base+=2;
    }
    //outro
    rembase = base;
    for(int i=0;i<8;i++){
      basstab[rembase+i*2+0] = aa;
      basstab[rembase+i*2+1] = ab;
      if(i==7)drumpattern[rembase+i*2+1] = 3;
      base+=2;
    }
    rembase = base;
    drumpattern[base] = 9;
    basstab[base] = aa;
    basspattern[base] = 6;
    
    guitartab = basstab;
    //guitarpattern = basspattern;

    //
    tempo = 170;
    mainlevel = 80;
    loopeable = false;
    
    basslevel = 120;
    guitarlevel = 56;
    drumlevel = 127;
    
    bassinstrument = 37;
    guitarinstrument = 28;
    
    name = "aHARDpLACE";
    id = 3;
  }
}
