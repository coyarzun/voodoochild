class VAdmin extends VScreen{
  ArrayList screens;
  VLoogoo splash;
  int kk = 1;
  int current;
  boolean rocking, oldrocking;
  VScreen cscreen;

  VAdmin(int _x, int _y, int _width, int _height){
    colorMode(HSB);
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    pg = createGraphics((int)width, (int)height, P3D);

    splash = new VLoogoo(0,0,512,384);

    screens = new ArrayList();
    screens.add( new Tmp(0,0,512,384, color(0) ));
    for(int i=0; i<session.xmlzongs.length; i++){
      VZong zong = new VZong();
      String tmpfile = session.xmlzongs[i].getStringAttribute("file");
      if(tmpfile!=null){
        zong = new XMLZong(tmpfile);
      }
      else{
        String tmpclass = session.xmlzongs[i].getStringAttribute("class");
        if(tmpclass!=null){
          if(tmpclass.equals("FreshWidow"))zong = new FreshWidow();
          if(tmpclass.equals("OKeymickey"))zong = new OKeymickey();
          if(tmpclass.equals("Punkrocker"))zong = new Punkrocker();
          if(tmpclass.equals("SheLost"))zong = new SheLost();
        }
      }
      String tname = zong.name;
      if(tname.equals("lostman")){
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }else if(tname.equals("FreshWidow")){
        screens.add( new VFreshwidow(0,0,512,384, 0) );//color(16,255,255) ));
      }else if(tname.equals("OKEY MICKEY CLUB")){
        screens.add( new VOkeyMickey(0,0,512,384, 0) );//color(16,255,255) ));
      }else if(tname.equals("Punkrocker")){
          screens.add( new VPunkrocker(0,0,512,384, 0));
      }else if(tname.equals("She lost")){
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }else if(tname.equals("silverstein")){
        screens.add( new VSilverstein(0,0,512,384, 0));//color(16,255,255) ));
      }else if(tname.equals("anemicKover3")){
        screens.add( new VAnemic(0,0,512,384, 0));//color(16,255,255) ));
      }else if(tname.equals("b17")){
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }else if(tname.equals("aHardPlace")){
        screens.add( new VAhardplace(0,0,512,384, color(0,255,255)));//color(16,255,255) ));
      }else if(tname.equals("antarctic")){
        screens.add( new VAntarctic(0,0,512,384, 0));//color(16,255,255) ));
      }else if(tname.equals("songzero")){
        screens.add( new VSongzero(0,0,512,384, 0));//color(16,255,255) ));
      }else if(tname.equals("charlottesometimes")){
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }else if(tname.equals("slowlybittingU")){
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }else if(tname.equals("loveedn")){
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }else{
          screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
      }

        /*
        screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
        screens.add( new VSunlight(0,0,512,384, 0));//color(16,255,255) ));
        screens.add( new VFlowR(0,0,512,384, 0) );//color(16,255,255) ));
        screens.add( new Tmp(0,0,512,384, color(map(i,0,16,0,255),255,255) ));
        */
    }
  }
  void draw(){//PGraphics pgg){
    //pg.noCursor();
    rocking = session.zong.rocking;

    if(rocking!=oldrocking){
      if(!rocking){
        splash.fadein();
      }
      else{
        splash.fadeout();//
        current = 1+session.index;
      }
    }

    //VScreen 
    cscreen = (VScreen)screens.get(current);
    cscreen.draw(pg);    
    vplayer.draw(pg);
    //kk = 5;
    for(int i=0; i<screendiv; i++){
      for(int j=0; j<screendiv; j++){
        image(pg,i*pg.width/screendiv,j*pg.height/screendiv,pg.width/screendiv,pg.height/screendiv);//1024,768);
      }
    }
    oldrocking=rocking;

    splash.fade();
    if(splash.alfa>1){
      splash.draw(this.pg);
      tint(255, splash.alfa);
      image(this.pg,0,0);
      noTint();
    }//else{println("yuju");}
  }
}








