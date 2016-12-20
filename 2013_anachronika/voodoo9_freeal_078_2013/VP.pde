class VPlayer extends VScreen{
  ArrayList msgs;
  int vismgs = 8;

  VPlayer(int _x, int _y, int _width, int _height){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    //pg = createGraphics(width, height, P3D);
    font = loadFont("CoyarzunAtarinormal-32.vlw");
    msgs = new ArrayList();
  }
  void update(){
    //session.draw();
    session.checksong();
  }
  void draw(PGraphics pg){ 
    pg.beginDraw();
    if(mini)pg.scale(2);
    pg.colorMode(HSB);

    pg.fill(32,128,255);
    pg.textFont(font, 8);
    pg.text(time()+"VOODOOCHILD:10:", 4,10);

    pg.fill(0,255,128);
    pg.text("SONG  :",4+32,20);    
    pg.text("STATUS:",4+32,28);    
    pg.text("BAR   :",4+32,36);    
    pg.text("BEAT  :",4+32,44);    
    if(session.sessionloaded && session.index!=-1){
      pg.fill(255);
      pg.text(session.zong.name,4+8*8+32,20);
      if(session.zong.rocking){
        pg.fill(96,255,255);
        if(frameCount%4!=0){
          pg.text("ROCKING",4+8*8+32,28);
        }
      }
      else{
        pg.fill(0,255,255);
        pg.text("STOPPED",4+8*8+32,28);
      }
      pg.fill(255);
      pg.text(nf(session.zong.bar,4),4+8*8+32,36);//
      pg.text(nf(session.zong.frame,2), 4+8*8+32, 44);
    }

    pg.translate(4,54);
    for(int i=msgs.size()-1; i>msgs.size()-1-vismgs && i>=0; i--){
      int j = msgs.size()-1-i;
      pg.fill(j==0?color(0,255,255):color(64,255,map(j,0,min(vismgs,msgs.size()),255,0)));
      String msg = (String)msgs.get(i);
      pg.text(msg, 0,j*8);
    }

    pg.endDraw();
  }
  void println(String s){
    msgs.add(time()+s);
  }
  String time(){
    return("["+nf(hour(),2)+":"+nf(minute(),2)+":"+nf(second(),2)+"]:");
  }
}


