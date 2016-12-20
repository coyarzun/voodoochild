class FlowR{
  int lastx = -1;
  int lasty = -1;

  ArrayList v, w;
  FlowR(){
  }
  void flowrRoutine(){
    v = new ArrayList();
    w = new ArrayList();

    float ratio  = 100+session.zong.beatMap.snare.currentside; 
    float cx = 0;//width/2; 
    float cy = -20;//height/2-20;
    float da = radians(10)/10;
    float sw = 6;
    for(int j=0; j<3; j++){
      VShape tmp = new VShape();
      ratio-=10;
      for(float i=0; i<TWO_PI; i+=da){
        float x0, y0, x1, y1;
        float r = pfn(ratio, i);
        x0 = cx+r*cos(i+PI/2);
        y0 = cy+r*sin(i+PI/2);
        r = pfn(ratio, (i+da));
        x1 = cx+r*cos(i+da+PI/2);
        y1 = cy+r*sin(i+da+PI/2);

        tmp.addLine(x0,y0,x1,y1);
      }
      tmp.setStrokeWeight(sw);
      tmp.startRun(10, tmp.perimeter*.9, (frameCount*10)%tmp.perimeter);
      sw*=.8;
      w.add(tmp);
    }
  }
  float pfn(float r, float a){
    return r*(session.zong.beatMap.snare.currentside/20+cos((3+session.zong.beatMap.kick.currentside/20)*(a*(1+session.zong.beatMap.hat.currentside/20))));//*random(.9,1);//-radians(2*frameCount%360)
  }
  void draw(PGraphics pg){
    flowrRoutine();

    //pg.background(0);
    pg.strokeCap(ROUND);
    for(int i=0; i<v.size(); i++){
      VShape tmp = (VShape)v.get(i);
      tmp.draw(pg);
    }
    for(int i=0; i<w.size(); i++){
      VShape tmp = (VShape)w.get(i);
      tmp.draw(pg);
    }
  }
}





class OldVFlowR extends VScreen{
  color bgcolor;
  FlowR flower;

  OldVFlowR(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    flower = new FlowR();
  }
  void draw(PGraphics pg){
    pg.beginDraw();
    pg.colorMode(HSB);
    //pg.background(0);//bgcolor);//0,0);
        int kk = int(10*sin(radians((1+session.zong.beatMap.snare.currentside/20)*frameCount%360)));
    pg.pushMatrix();
    pg.translate(pg.width/2,pg.height/2);
    pg.rotate(radians(10*sin(radians(4*frameCount%360))));
    pg.translate(-pg.width/2,-pg.height/2);
    pg.image(pg,-kk,-kk,pg.width+2*kk+1,pg.height+2*kk+1);
    pg.popMatrix();
    
    pg.noStroke();pg.fill(0,32);pg.rect(0,0,pg.width,pg.height);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      /*
      if(vl>0){
        tw = pg.width/vl;
        pg.fill(0,0,lyricop,lyricop);
        pg.textFont(font, tw);
        pg.text(vislyric,-pg.width/2,tw/2);
        lyricop*=lyricd;
        if(lyricop>255 && lyricd>1){
          lyricd = .97;
        }
      }
      */
      //pg.rotate(radians(4*frameCount%360));
      flower.draw(pg);
    }
    pg.endDraw();
  }
}

