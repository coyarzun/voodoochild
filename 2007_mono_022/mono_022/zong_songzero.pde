class Zongzero extends Zong{
  Zongzero(){
    int initbars = 2;
    int endbars = 4;
    bars = initbars+4*4+16+4*4+16+4*4*2+4*4*2+endbars;
    
    int[] silent = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    
    int[] aa = {11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11};
    int[] ab = {11,11,11,11,11,11,11,14,14,14,14,14,14,14,14,14};     
    int[] ac = {17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17};
    int[] ad = {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5};
    
    int[] ba = {11,11,11,11,11,11,11,11,11,11,14,14,14,14,14,14};
    int[] bb = {9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9};
    int[] bc = {11,11,11,11,11,11,11,11,11,11,11,12,13,14,14,14};
    int[] bd = {14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14};
    int[] be = {17,17,17,17,17,17,17,17,17,17,19,19,19,19,19,19};
    
    int[] va = {0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vb = {-1,-1,-1,-1,-1,-1,-1, 1,-1,-1,-1,-1,-1,-1,-1,-1};     
    int[] vc = {-1,-1,-1,-1,-1,-1,-1, 2,-1,-1,-1,-1,-1,-1,-1,-1};
    
    int[] vd = {4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] ve = {5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vf = {6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vg = {7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};

    int[] vh = {9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vi = {10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};

    int[] vj = {12,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vk = {13,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};

    int[] vl = {15,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};

    int[] vm = {17,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vn = {18,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int[] vo = {19,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    
    int base, rembase;
    
    basstab = new int[bars][16];
    basspattern = new int[bars];
    guitartab = new int[bars][16];
    guitarpattern = new int[bars];
    drumpattern = new int[bars];
    voicetab = new int[bars][16];
    lyricurl = "songzero_lyrics.txt";
    
    //fill "defaults" 
    basspattern[0] = 0;
    drumpattern[0] = 0;
    basstab[0] = silent;
    voicetab[0] = silent;
    
    basspattern[1] = 0;
    drumpattern[1] = 1;
    basstab[1] = silent;
    voicetab[1] = silent;
    
    for(int i=initbars;i<bars-endbars;i++){
        basspattern[i] = 4;
        drumpattern[i] = 2;
        voicetab[i] = silent;
    };   
    for(int i=bars-endbars;i<bars;i++){
        basspattern[i] = 0;
        drumpattern[i] = 0;
        voicetab[i] = silent;
    };

    base = initbars;
    rembase = base;
    
    //intro
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = aa;
      basstab[rembase+i*4+3] = ac;
      
      drumpattern[rembase+i*4+0] = 10;
      drumpattern[rembase+i*4+2] = 10;
      drumpattern[rembase+i*4+3] = 11;
      base+=4;
    }
    //first verse
        voicetab[base] = va;
              drumpattern[base] = 12;
    basstab[base++] = aa;
        voicetab[base] = vb;
    basstab[base++] = ba;
    basstab[base++] = bb;
        voicetab[base] = vc;
    basstab[base++] = bb;
    
                drumpattern[base] = 10;
    basstab[base++] = aa;
                 drumpattern[base] = 10;
    basstab[base++] = bc;
        voicetab[base] = vd;
              drumpattern[base] = 11;
    basstab[base++] = bd;
              drumpattern[base] = 13;
    basstab[base++] = bd;
        voicetab[base] = ve;
        
        drumpattern[base] = 12;
    basstab[base++] = aa;
        voicetab[base] = vf;
    basstab[base++] = ba;
    basstab[base++] = bb;
        voicetab[base] = vg;
    basstab[base++] = bb;
    
             drumpattern[base] = 10;
    basstab[base++] = aa;
        voicetab[base] = vg;
                     drumpattern[base] = 10;
    basstab[base++] = bc;
                  drumpattern[base] = 11;
    basstab[base++] = bd;
              drumpattern[base] = 13;
    basstab[base++] = be;
              
    rembase = base;
    //chorus
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
              voicetab[rembase+i*4+0] = vm;
      basstab[rembase+i*4+1] = ab;
              voicetab[rembase+i*4+1] = vn;
      basstab[rembase+i*4+2] = aa;
              voicetab[rembase+i*4+2] = vo;
      basstab[rembase+i*4+3] = ac;
      drumpattern[rembase+i*4+0] = 10;
      drumpattern[rembase+i*4+2] = 10;
      drumpattern[rembase+i*4+3] = 11;
      base+=4;
    }
    //sekond verse
            voicetab[base] = vh;
              drumpattern[base] = 12;
    basstab[base++] = aa;
    basstab[base++] = ba;
            voicetab[base] = vi;
    basstab[base++] = bb;
    basstab[base++] = bb;
    
                 drumpattern[base] = 10;
                voicetab[base] = vj;
    basstab[base++] = aa;
                 drumpattern[base] = 10;
    basstab[base++] = bc;
                voicetab[base] = vk;
                  drumpattern[base] = 11;
    basstab[base++] = bd;
                  drumpattern[base] = 13;
    basstab[base++] = bd;
    
    drumpattern[base] = 12;
            voicetab[base] = vl;
    basstab[base++] = aa;
    basstab[base++] = ba;
            voicetab[base] = vl;
    basstab[base++] = bb;
    basstab[base++] = bb;
    
                  drumpattern[base] = 10;
                    voicetab[base] = vj;
    basstab[base++] = aa;
                 drumpattern[base] = 10;
    basstab[base++] = bc;
                    voicetab[base] = vk;
              drumpattern[base] = 11;
    basstab[base++] = bd;
                  drumpattern[base] = 13;
    basstab[base++] = be;
    
    rembase = base;
    //sekond chorus
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
              voicetab[rembase+i*4+0] = vm;
      basstab[rembase+i*4+1] = ab;
              voicetab[rembase+i*4+1] = vn;
      basstab[rembase+i*4+2] = aa;
              voicetab[rembase+i*4+2] = vo;
      basstab[rembase+i*4+3] = ac;
      
      drumpattern[rembase+i*4+0] = 10;
      drumpattern[rembase+i*4+2] = 10;
      drumpattern[rembase+i*4+3] = 11;
      base+=4;
    }
    rembase = base;
    //bacilando
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = aa;
      basstab[rembase+i*4+3] = ac;
      base+=4;
    }
    
    //closing
    for(int j=0;j<2;j++){
    rembase = base;
    for(int i=0;i<4;i++){
      basstab[rembase+i*4+0] = aa;
              voicetab[rembase+i*4+0] = vj;
      basstab[rembase+i*4+1] = ab;
      basstab[rembase+i*4+2] = aa;
      if(i%2==0){
        voicetab[rembase+i*4+2] = vo;
          
      }else{
        voicetab[rembase+i*4+2] = vk;
      };
      basstab[rembase+i*4+3] = ad;
              voicetab[rembase+i*4+3] = vl;
              //if(i==3 && j==1)drumpattern[rembase+i*4+3] = 3;
              
      if(j==0){
      drumpattern[rembase+i*4+0] = 10;
      drumpattern[rembase+i*4+2] = 10;
      drumpattern[rembase+i*4+3] = 11;
      }else{
      if(i<2){
              drumpattern[rembase+i*4+0] = 10;
      drumpattern[rembase+i*4+2] = 10;
      drumpattern[rembase+i*4+3] = 11;
      }else if(i<3){
        drumpattern[rembase+i*4+0] = 11;
      drumpattern[rembase+i*4+1] = 14;
      drumpattern[rembase+i*4+2] = 14;
      drumpattern[rembase+i*4+3] = 15;
      }else{
      drumpattern[rembase+i*4+0] = 14;
      drumpattern[rembase+i*4+1] = 14;
      drumpattern[rembase+i*4+2] = 15;
      drumpattern[rembase+i*4+3] = 15;
      }
      }
      base+=4;
    }
    }
    rembase = base;
    drumpattern[base] = 9;
    basstab[base] = aa;
    basspattern[base] = 6;
    
    guitartab = basstab;
    guitarpattern = basspattern;

    //
    tempo = 160;
    mainlevel = 80;
    loopeable = false;
    
    basslevel = 117;
    guitarlevel = 64;
    drumlevel = 127;
    
    bassinstrument = 38;
    guitarinstrument = 28;
    
    name = "SONGZERO";
    id = 0;
  }
}
