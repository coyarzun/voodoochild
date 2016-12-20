class Hey extends Zong{
  Hey(){
    int initbars = 0;//2;
    int endbars = 0;//4;
    bars = initbars+(1)+endbars;
    
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
    lyricurl = "hey_lyrics.txt";
    
    //fill "defaults" 
    /*
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
    */
    base = initbars;
    //intro
    rembase = base;
    for(int i=0;i<1;i++){
      drumpattern[rembase+i*1] = 2;
      basstab[rembase+i*1] = aa;
      basspattern[rembase+i] = 0;
      voicetab[rembase+i] = silent;
      base+=1;
    }
    /*
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
    */
    guitartab = basstab;
    guitarpattern = basspattern;

    //
    tempo = 140;
    mainlevel = 80;
    loopeable = true;
    
    basslevel = 96;
    guitarlevel = 64;
    drumlevel = 127;
    
    bassinstrument = 38;
    guitarinstrument = 28;
    
    name = "hey";
    id = 4;
  }
}
