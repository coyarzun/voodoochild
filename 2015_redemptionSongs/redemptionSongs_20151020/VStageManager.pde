class VStageManager {//en el futuro extender esta clase "scroll menu" o algo asi
  PGraphics pg;
  VScreen[] screens;
  VScreen cscreen;
  VLoogoo splash;
  int current;
  boolean rocking, oldrocking;

  VZong    daSong;
  String[] songNames;
  int      selectedSong;

  int bar, frame;
  int oldbar, oldframe;

  int      operationFlag;
  int      scrollPos;

  PFont font;

  VStageManager() {
    songNames     = new String[29];
    songNames[0]  = "Escaleras";
    songNames[1]  = "Fresh Widow";
    songNames[2]  = "antarctic";
    songNames[3]  = "Features";    
    songNames[4]  = "songZero";
    songNames[5]  = "aHardPlace";
    songNames[6]  = "El Aparecido";
    songNames[7]  = "Geometric Attraction";
    
    songNames[8]  = "aForest";
    songNames[9]  = "Animal Conciousness";
    songNames[10]  = "L'ete Indien";
    songNames[11] = "The Eternal City Song";
    songNames[12] = "Adaptive Radiation";
    songNames[13]  = "Tu Fiesta";
    songNames[14] = "Intricate Spatio Temporal Organizations";
    songNames[15] = "charlotteSometimes";//"aForest";
    songNames[16] = "Reptile";
    songNames[17] = "punkRocker";
    songNames[18] = "anemicKover";
    songNames[19] = "b17";
    songNames[20] = "lostman";
    songNames[21] = "loveedn";
    songNames[22] = "silverstein";
    songNames[23] = "slowlyBittingU";
    songNames[24] = "flag";
    songNames[25] = "sunlight";
    songNames[26] = "sheLost";
    songNames[27] = "OKMickeyClub";
    songNames[28] = "flowRZong";

    scrollPos = -1;

    pg = createGraphics(512, 384, P3D);
    font = loadFont("CoyarzunAtarinormal-8.vlw");
    pg.textFont(font, 8);
    splash = new VLoogoo(0, 0, 512, 384);
    screens = new VScreen[29];
    for (int i=0;i<screens.length;i++) {
      screens[i]= new Tmp(0, 0, 512, 384, color(0));
    }
    screens[0]  = new VAnemic(0, 0, 512, 384, 0 );
    screens[1]  = new VFreshwidow(0, 0, 512, 384, 0) ;
    screens[2]  = new VAntarctic(0, 0, 512, 384, 0);
    screens[3]  = new VFeatures(0, 0, 512, 384, 0);
    screens[4]  = new VSongzero(0, 0, 512, 384, 0);//
    screens[5]  = new VAhardplace(0, 0, 512, 384, 0);
    screens[6]  = new VElAparecido(0, 0, 512, 384, 0 );
    screens[7]  = new FlowRVisuals(0, 0, 512, 384, 0 );  
    
    screens[8]  = new Tmp(0, 0, 512, 384, 0);
    screens[9]  = new VSilverstein(0, 0, 512, 384, 0 );
    screens[10]  = new Tmp(0, 0, 512, 384, 0);
    screens[11]  = new VTheEternalCity(0, 0, 512, 384, 0);
    //    screens[11] = new FlowRVisuals(0,0,512,384, 0 );//Tmp(0,0,512,384, color(240,255,255) );
    //    screens[9]  = new Tmp(0,0,512,384, 0);
    //    screens[10] = new VAnemic(0,0,512,384, 0) ;
    //    screens[11] = new Tmp(0,0,512,384, 0 );
    //    screens[12] = new Tmp(0,0,512,384, 0 );
    //    screens[13] = new VPunkrocker(0,0,512,384, 0);
    //    screens[14] = new VAhardplace(0,0,512,384, color(0,255,255));
    //    screens[15] = new VAnemic(0,0,512,384, 0) ;
    //    screens[16] = new VAnemic(0,0,512,384, 0) ;
    screens[17] = new VPunkrocker(0,0,512,384, 0);
    screens[18]  = new VAnemic(0, 0, 512, 384, 0 );
    //    screens[18] = new Tmp(0,0,512,384, 0 );
    //    screens[19] = new VAntarctic(0,0,512,384, 0);
    //  screens[20] = new VLostmanSuperstar(0,0,512,384, 0);
    //    screens[21] = new Tmp(0,0,512,384, 0 );
    //    screens[22] = new VSilverstein(0,0,512,384, 0);
    //    screens[23] = new Tmp(0,0,512,384, 0 );
    //    screens[24]  = new Tmp(0,0,512,384, 0 );
    //    screens[25] = new VSunlight(0,0,512,384, color(240,230,0));
    //    screens[26] = new Tmp(0,0,512,384, 0 );
    //screens[27] = new VOkeyMickey(0,0,512,384, 0) ;
    screens[28] = new FlowRVisuals(0, 0, 512, 384, 0 );

    splash.fadein();
  }
  void initSong(int i) {
    if (daSong!=null)if (daSong.sequencer.isRunning())daSong.sequencer.stop();
    if (midiManager.outputChan!=-1) {

      songNames[0]  = "Escaleras";
      songNames[1]  = "Fresh Widow";
      songNames[2]  = "antarctic";
      songNames[3]  = "Features";    
      songNames[4]  = "songZero";
      songNames[5]  = "aHardPlace";
      songNames[6]  = "El Aparecido";
      songNames[7]  = "Geometric Attraction";
      
      
      if (i==0)    daSong   = new Escaleras();
      if (i==1)    daSong   = new FreshWeedow();
      if (i==2)    daSong   = new XMLZong("xml/antarctic.xml");
      if (i==3)    daSong   = new Features();
      if (i==4)    daSong   = new XMLZong("xml/songzero.xml");
      if (i==5)    daSong   = new XMLZong("xml/ahardplace_eng.xml");
      if (i==6)    daSong   = new Aparecido();
      if (i==7)    daSong   = new GeometricAttraction();
      
      if (i==8)   daSong   = new AForest();
      if (i==9)    daSong   = new AnimalConciousness();
      if (i==10)    daSong   = new LEteIndien();
      if (i==11)    daSong   = new TheEternalCitySong();
      
      if (i==12)   daSong   = new AdaptiveRadiation();
      if (i==13)   daSong   = new TuFiesta();
      if (i==14)   daSong   = new IntricateSpatioTemporalOrganizations();
      if (i==15)   daSong   = new XMLZong("xml/charlottesometimes.xml");
      if (i==16)   daSong   = new Reptile();
      if (i==17)   daSong   = new Punkrocker();
      
      if (i==18)   daSong   = new XMLZong("xml/anemickover3.xml");
      if (i==19)   daSong   = new XMLZong("xml/b17.xml");
      if (i==20)   daSong   = new XMLZong("xml/lostman.xml");
      if (i==21)   daSong   = new XMLZong("xml/loveedn.xml");
      if (i==22)   daSong   = new XMLZong("xml/silverstein.xml");
      if (i==23)   daSong   = new XMLZong("xml/slowlybittingU.xml");
      if (i==24)   daSong   = new XMLZong("xml/flag.xml");
      if (i==25)   daSong   = new XMLZong("xml/sunlight.xml");
      if (i==26)   daSong   = new SheLost();
      if (i==27)   daSong   = new OKeymickey();
      if (i==28)   daSong   = new FlowRZong();


      selectedSong = i;

      //      score.writeMidiFile("/Users/coyarzun/Documents/Processing/voodoochild/tokatas/2015/_posternuraSuperstar/theEternalCityFL016_superstar_20150403x/saved/"+
      //      daSong.name+".mid");
    }
  }
  void draw() {



    switch(operationFlag) {
    case 0:
      drawSplash();
      drawSelectSong();
      break;
    case 1:
      drawWhileRocking();
      drawSplash();
      break;
    default:
      break;
    }
  }
  void drawSplash() {
    splash.fade();
    if (splash.alfa>1) {
      splash.draw(this.pg);
      pushMatrix();
      scale(wscalef);
      translate(0, ydisplacement);
      tint(255, splash.alfa);
      image(this.pg, 0, 0);
      noTint();
      popMatrix();
    }
  }
  void drawWhileRocking() {
    int f = (daSong.quantization==12)?384:512;
    if (daSong!=null) {
      rocking = daSong.sequencer.isRunning();

      if (rocking!=oldrocking) {
        resetGeometry();
        if (!rocking) {
          splash.fadein();
        }
        else {
          splash.fadeout();//
        }
      }
      oldrocking=rocking;

      if (daSong.sequencer.isRunning()) {
        bar = int(daSong.sequencer.getTickPosition()/f);
        frame = int((daSong.sequencer.getTickPosition()%f)/32);
        if (oldbar!=bar || oldframe!=frame) {
          if (daSong.lyrics[bar][frame]!=null) {
            donmiguel.sing(daSong.lyrics[bar][frame]);
            //vadmin.cscreen.addLyric(lyrics[bar][frame]);
            screens[selectedSong].addLyric(daSong.lyrics[bar][frame]);
          }
        }

        daSong.beatMap.update(bar*daSong.quantization+frame);
        //pg.textFont(font, 100);
        screens[selectedSong].draw(pg);
        for (int i=0; i<screendiv; i++) {
          for (int j=0; j<screendiv; j++) {
            pushMatrix();
            scale(wscalef);
            translate(0, ydisplacement);

            image(pg, i*pg.width/screendiv, j*pg.height/screendiv, pg.width/screendiv, pg.height/screendiv);//1024,768);
            popMatrix();
          }
        }

        oldbar=bar;
        oldframe=frame;
        if (daSong.sequencer.getTickPosition()-daSong.sequencer.getLoopEndPoint()>0)daSong.sequencer.stop();
        println(bar+":"+frame);
      }
    }
  }
  void keyReleased() {
    switch(operationFlag) {
    case 0:
      keyReleasedSelectSong();
      break;
    case 1:
      keyReleasedLoadedSong();
      break;
    }
  }
  void keyReleasedLoadedSong() {
    if (keyCode==32 || keyCode==10) {//spacebar o return
      if (!daSong.sequencer.isRunning())daSong.sequencer.start();
      else {
        daSong.sequencer.stop();
        //daSong.sequencer.noLoop();// (0);
        operationFlag = 1;
      }
    }
    if (keyCode>=48 && keyCode <=57) {
      operationFlag = 0;
    }
  }
  void keyReleasedSelectSong() {
    if (keyCode==32 || keyCode==10) {//spacebar o return
      if (scrollPos>-1) {
        initSong(scrollPos);
        operationFlag = 1;
      }
    }
    else if (keyCode>=48 && keyCode <=57) {     
      int pnum = constrain(keyCode-48, 0, 9);
      pnum%=songNames.length;
      scrollPos = pnum;
    }
    else if (keyCode>=37 && keyCode<=40) {
      //println(keyCode);
      if (keyCode==38) {
        scrollPos--; 
        if (scrollPos<-1)scrollPos=songNames.length-1;
      }
      else if (keyCode==40) {
        scrollPos++; 
        scrollPos%=songNames.length;
      }
    }
  }
  void noteOn(int pit){
    //println(">>>"+pit);
    if(pit==0){
      if(operationFlag!=1){
        scrollPos--; 
        if (scrollPos<-1)scrollPos=songNames.length-1;
      }else{
        operationFlag = 0;
      }      
    }
    if(pit==1){
      if(operationFlag!=1){
        scrollPos++; 
        scrollPos%=songNames.length;
      }else{
        operationFlag = 0;
      }
    }
    if(pit==2){
      switch(operationFlag) {
      case 0:
        if (scrollPos>-1) {
          initSong(scrollPos);
          operationFlag = 1;
        }
        break;
      case 1:
        if (!daSong.sequencer.isRunning())daSong.sequencer.start();
        else {
          daSong.sequencer.stop();
          //daSong.sequencer.noLoop();// (0);
          operationFlag = 1;
        }
      break;
      }
    }
  }
  void drawSelectSong() {
    int scrollW = 240;
    //background(255);
    pushMatrix();
    translate(16, 16);
    noSmooth();
    fill(255);
    rect(0, 3, scrollW, (songNames.length+1)*12);
    fill((frameCount/2)%2==0?240:122, 240, 240);
    noStroke();
    rect(0, (scrollPos+1)*12+3, scrollW, 12);
    fill(0);
    text("PLEASE SELECT A SONG:", 8, 12);
    for (int i=0; i<songNames.length; i++) {
      translate(0, 12);
      text("["+i+"] "+songNames[i], 8, 12);
    }
    popMatrix();
  }

  void resetGeometry() {
    //println("pasé?");
    pg.camera(pg.width/2.0, pg.height/2.0, (pg.height/2.0) / tan(PI*60.0 / 360.0), pg.width/2.0, pg.height/2.0, 0, 0, 1, 0);
  }
}
