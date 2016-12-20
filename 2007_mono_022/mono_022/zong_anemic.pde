class Anemiccoverkover extends Zong{
  Anemiccoverkover(){
    int initbars = 2;
    int endbars = 4;
    bars = initbars+(2+22+4)*4+endbars;
    
    int[] silent = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    
    int[] aa = {7,7,7,7,9,9,9,9,9,9,9,9,9,9,9,9};
    int[] ab = {7,7,7,7,4,4,4,4,4,4,4,4,4,4,4,4};     
    
    int base, rembase;
    
    basstab = new int[bars][16];
    basspattern = new int[bars];
    guitartab = new int[bars][16];
    guitarpattern = new int[bars];
    drumpattern = new int[bars];
    voicetab = new int[bars][16];
    lyricurl = "anemic_lyrics.txt";
    
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
    for(int i=0;i<2;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = aa;
      basstab[rembase+i*4+2] = ab;
      basstab[rembase+i*4+3] = ab;
      if(i==1)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //lyric
    rembase = base;
    for(int i=0;i<22;i++){
      basstab[rembase+i*4+0] = aa;
        int[] aux = {2*i,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
        voicetab[rembase+i*4+0] = aux;
      basstab[rembase+i*4+1] = aa;
      basstab[rembase+i*4+2] = ab;
        int[] aux2 = {2*i+1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
        voicetab[rembase+i*4+2] = aux2;
      basstab[rembase+i*4+3] = ab;
      if(i==21)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    //end
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = aa;
      basstab[rembase+i*4+2] = ab;
      basstab[rembase+i*4+3] = ab;
      if(i==3)drumpattern[rembase+i*4+3] = 3;
      base+=4;
    }
    rembase = base;
    drumpattern[base] = 9;
    basstab[base] = aa;
    basspattern[base] = 6;
    
    guitartab = basstab;
    guitarpattern = basspattern;

    //
    tempo = 150;
    mainlevel = 80;
    loopeable = false;
    
    basslevel = 96;
    guitarlevel = 64;
    drumlevel = 127;
    
    bassinstrument = 38;
    guitarinstrument = 28;
    
    name = "anemicCoverKover";
    id = 1;
  }
}
