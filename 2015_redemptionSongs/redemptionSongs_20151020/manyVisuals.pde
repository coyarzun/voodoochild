class Tmp extends VScreen {
  color bgcolor;
  PFont font;

  Tmp(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-8.vlw");
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      //int pos = stageManager.bar*stageManager.daSong.quantization + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      stageManager.daSong.beatMap.draw(pg);
      pg.popMatrix();
      if (vl>0) {
        tw = pg.width/vl;
        pg.fill(0, 0, lyricop, lyricop);
        pg.textFont(font, tw);
        pg.text(vislyric, -pg.width/2, tw/2);

        lyricop*=lyricd;
        if (lyricop>255 && lyricd>1) {
          lyricd = .97;
        }
      }
    }
    pg.endDraw();
  }
}
class VElAparecido extends VScreen {
  color bgcolor;
  PFont font;
  Wipala wipala;
  Muybridge zqnce;

  VElAparecido(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-8.vlw");
    wipala = new Wipala(_width, _height);
    zqnce = new Muybridge(_width, _height);
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(RGB);
    pg.background(bgcolor);//0,0);
    //pg.translate(pg.width/2,pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      //int pos = stageManager.bar*stageManager.daSong.quantization + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      pg.pushMatrix();
      //pg.scale(4);
      //stageManager.daSong.beatMap.draw(pg);
      wipala.draw(pg);
      zqnce.draw(pg);
      pg.popMatrix();
      if (vl>0) {
        tw = pg.width/vl;
        pg.fill(0, 0, lyricop, lyricop);
        //pg.textFont(font, tw);
        //pg.text(vislyric,-pg.width/2,tw/2);

        lyricop*=lyricd;
        if (lyricop>255 && lyricd>1) {
          lyricd = .97;
        }
      }
    }
    pg.endDraw();
  }
}
class Muybridge {
  int      cols, rows;
  float    cell;
  PImage[] zqnce;

  Muybridge(int w, int h) {
    update(w, h, 4);
    zqnce = new PImage[11];
    for (int i=0; i<zqnce.length; i++) {
      zqnce[i] = loadImage("visuals/elAparecido/horseInMotion_"+nf(i, 3)+".png");
    }
  }
  void update(int w, int h, int f) {
    cols = w/f;
    rows = h/f;
    cell = w/float(cols);
  }
  boolean gimmeCondition(int i, int j, boolean xc) {
    PImage tmp = zqnce[int(frameCount*0.2)%zqnce.length];
    int ii = int(map(i, 0, cols, 0, tmp.width));
    int jj = int(map(xc?j:i, 0, rows, 0, tmp.height));
    color pixel = tmp.get(ii, jj);
    return brightness(pixel)<255;
  }
  void draw(PGraphics pg) {
    //background(colors[frameCount%colors.length]);
    pg.noStroke();
    boolean xc = random(100)>20;
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {//frameCount
        pg.fill(0, gimmeCondition(i, j, xc)?255:0);
        pg.rect(i*cell, j*cell, cell, cell);
        //println(i*cell);
      }
    }
  }
}
class Wipala {
  color[] colors;
  int     cols, rows;
  float   cell;

  Wipala(int w, int h) {
    //size(1280, 720,P3D);
    //size(400, 300,P3D);
    int f = 32;
    cols = w/f;
    rows = h/f;
    cell = w/float(cols);
    println(cols);
    colors = new color[7];
    colorMode(RGB);
    colors[0] = color(255, 255, 255);
    colors[1] = color(255, 255, 0);
    colors[2] = color(255, 128, 0);
    colors[3] = color(255, 0, 0);
    colors[4] = color(255, 0, 255);
    colors[5] = color(0, 0, 255);
    colors[6] = color(0, 255, 0);
    colorMode(HSB);
  }
  void draw(PGraphics pg) {
    //background(colors[frameCount%colors.length]);
    pg.noStroke();
    boolean xc = random(100)>20;
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {//frameCount
        pg.fill(colors[(i+(xc?j:i)+frameCount)%colors.length]);
        pg.rect(i*cell, j*cell, cell, cell);
        //println(i*cell);
      }
    }
  }
}

class VFeatures extends VScreen {
  VApokalipticLandscape landscape;
  color bgcolor;
  PFont font;

  VFeatures(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    landscape = new VApokalipticLandscape();
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    //println(stageManager.daSong.sequencer.isRunning());
    if (stageManager.daSong.sequencer.isRunning()) {
      //int pos = stageManager.bar*stageManager.daSong.quantization + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      /*if(stageManager.bar<2){
       pg.pushMatrix();
       pg.scale(4);
       stageManager.daSong.beatMap.draw(pg);
       pg.popMatrix();
       }
       else{*/
      landscape.draw(pg);
      //}
    }
    pg.endDraw();
  }
}
class VApokalipticLandscape {
  ArrayList halloes;
  Walker[]  walkers;
  Fog[]     fog;
  Grid      grid;
  color     bgcolor;
  float     windx, windy, windz;
  Water     water;
  int       width = 512;


  VApokalipticLandscape() {
    //  size(720,384,P3D);

    bgcolor = color(106, 80, 204);
    water   = new Water();
    walkers = new Walker[100];
    for (int i=0; i<walkers.length; i++) {
      walkers[i] = new Walker(random(-width, width), 0, random(-width, width));
    }
    fog = new Fog[1000];
    for (int i=0; i<fog.length; i++) {
      fog[i] = new Fog();
    }
    halloes = new ArrayList();
    grid    = new Grid();
  }
  void draw(PGraphics pg) {
    pg.colorMode(HSB);
    pg.background(bgcolor);

    pg.rotateX(PI/2+radians(30)+radians(frameCount)*0.1);
    pg.translate(0, -100, 0);
    pg.rotateY(PI);
    pg.rectMode(CENTER);

    windx = 0.2;
    windy = -0.1;
    windz = -0.2;
    for (int i=0; i<fog.length; i++) {
      fog[i].update();
      fog[i].draw(pg);
    }
    for (int i=0; i<walkers.length; i++) {
      walkers[i].update();
      walkers[i].draw(pg);
    }
    for (int i=0; i<halloes.size(); i++) {
      Hallo tmp = (Hallo)halloes.get(i);
      tmp.update();
      tmp.draw(pg);
      if (tmp.life<0)halloes.remove(i);
    }
    //grid.update();
    grid.draw(pg);
    water.update();
    water.draw(pg);
  }
  class Water {
    float depth, z;

    Water() {
      z     = 0;
    }
    void update() {
      depth = abs(z+stageManager.daSong.beatMap.kick.currentside);
    }
    void draw(PGraphics pg) {
      pg.colorMode(HSB);
      pg.pushMatrix();
      pg.translate(0, z+depth/2, 0);
      pg.noStroke();
      //if(random(100)>90)fill(0,255,255,128);
      //else 
      //fill(bgcolor,200);
      pg.fill(240, 255, 255, 16);
      pg.box(4*width, depth, 4*width);  
      pg.popMatrix();
    }
  }
  class Grid {
    int rows, cols;
    float cellw, cellh;
    float gridlevel;

    Grid() {
      rows      = cols = 32;
      cellw     = 5*width/rows;
      cellh     = 5*height/cols;
    }
    void update() {
      gridlevel = -100;//water.z;
    }
    void draw(PGraphics pg) {
      pg.pushMatrix();
      pg.rotateY(radians(frameCount)*.02);
      pg.translate(-float(rows)*cellw/2.0, gridlevel, -float(cols)*cellh/2.0);
      for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
          pg.pushMatrix();        
          pg.translate(i*cellw, 0, j*cellh);
          if (j%2==0) pg.translate(cellw/2.0, 0, 0);
          pg.noStroke();
          pg.fill(random(2)>0?bgcolor:color(0, 25, 255), 64);
          pg.stroke(240, 255, 255);
          //box(4);
          pg.rotateY(PI/4);
          //rotateX(PI/4);
          pg.scale(1+stageManager.daSong.beatMap.snare.currentside/2);
          pg.box(2);
          pg.popMatrix();
        }
      }
      pg.popMatrix();
    }
  }
  class Hallo {
    float x, z;
    float size;
    int   life, maxlife;

    Hallo(float _x, float _z, int _maxlife) {
      x = _x;
      z = _z;
      life = 30;
      size = 24;
      maxlife = _maxlife;
    }
    void update() {
      life--;
      size*=1.01;
    }
    void draw(PGraphics pg) {
      pg.pushMatrix();
      pg.translate(x, 0, z);
      pg.scale(1+stageManager.daSong.beatMap.hat.currentside/20);
      pg.rotateX(HALF_PI);
      pg.stroke(255, map(life, 0, maxlife, 0, 255));
      pg.noFill();
      pg.rect(0, 0, size, size);
      pg.scale(0.9);
      pg.rect(0, 0, size, size);
      pg.scale(0.5);
      pg.rect(0, 0, size, size);
      pg.popMatrix();
    }
  }
  class Fog {
    float x, y, z;
    int   fdiff;
    float angle;

    Fog() {
      define();
    }
    void define() {
      x     = random(-width, width);
      y     = -random(width);
      z     = random(width);
      fdiff = int(random(12));
    }
    void redefine() {
      define();
      y=0;
    }
    void update() {
      x += windx;
      y += windy;
      z += windz;
      if (x<-width || x>width ||
        y>0      || y<-width || 
        z<-width || z>width)  redefine();
    }
    void draw(PGraphics pg) {
      pg.pushMatrix();
      pg.translate(x, y, z);
      pg.rotateX(radians(frameCount+fdiff));
      pg.rotateY(radians(frameCount+fdiff));
      pg.stroke(hue(bgcolor), saturation(bgcolor), map(y, 0, -width, 204, 0));
      pg.fill(bgcolor, map(y, 0, width, 255, 0));
      pg.scale(1+stageManager.daSong.beatMap.hat.currentside/2);
      pg.box(4);
      pg.popMatrix();
    }
  }
  class Walker {
    float x, y, z;
    float xspeed, yspeed, zpeed;
    float ystep;
    float size;
    int   fdiff;
    float wstep, wspeed;
    float wsin, oldwsin;


    Walker(float _x, float _y, float _z) {
      x = _x; 
      y = _y; 
      z = _z;
      ystep = 32;
      zpeed = 1;//.25;
      size  = 32;//random(20,30);
      fdiff = int(random(12));
      wspeed = 4;//100;//4;//0.2;
    }
    void update() {
      wsin  = sin(radians(wspeed*(frameCount+fdiff)));
      if ((wsin>=0 && oldwsin<=0)||(wsin<=0 && oldwsin>=0))
        halloes.add(new Hallo(x, z, (int)map(wspeed, 1, 100, 100, 10)));
      wstep = -abs(ystep*wsin);
      z += zpeed;
      if (z>width)z-=2*width;
      oldwsin = wsin;
    }
    void draw(PGraphics pg) {
      pg.noStroke();
      pg.fill(hue(bgcolor), saturation(bgcolor), map(z, -width, width, 204, 0));

      pg.pushMatrix();
      pg.translate(x, y, z);
      pg.pushMatrix();
      pg.translate(0, wstep/2, 0);
      pg.scale(1+stageManager.daSong.beatMap.kick.currentside/20);
      pg.box(6, wstep, 6);
      pg.popMatrix();
      pg.translate(0, -size/2, 0);
      pg.translate(0, wstep);
      pg.box(20, size, 10);
      pg.popMatrix();
    }
  }
}

class VFreshwidow extends VScreen {
  color bgcolor;
  float noiseScale1=.1;//01;//0.02;//.01;//0.02;
  float noiseScale2=.01;
  int w, h;
  float cell;
  float playerx, playery;
  float xpos, ypos;
  float friction = .24;

  VFreshwidow(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");

    w = 24; 
    h = 48;
    cell = width/w;
    playerx = 0;
    playery = 50;
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      //pg.pushMatrix();
      //pg.scale(4);
      //stageManager.daSong.beatMap.draw(pg);
      //pg.popMatrix();

      /*if(vl>0){
       tw = pg.width/vl;
       pg.fill(0,0,lyricop,lyricop);
       pg.textFont(font, tw);
       pg.text(vislyric,-pg.width/2,tw/2);
       lyricop*=lyricd;
       if(lyricop>255 && lyricd>1){
       lyricd = .97;
       }
       }*/
      //      if(stageManager.bar<4){
      //        pg.pushMatrix();
      //        pg.scale(4);
      //        stageManager.daSong.beatMap.drawrim(pg);
      //        pg.popMatrix();
      //      }
      //      else{
      doLandscape(pg);
      //      }
    }
    pg.endDraw();
  }
  void doLandscape(PGraphics pg) {
    //background(0);
    //noiseScale = log(1000*mouseX);
    //println(log(mouseX));
    pg.noStroke();
    pg.lights();
    //pg.translate(width/2,height/2);
    pg.rotateX(-radians(2));

    float val;
    float val1= stageManager.daSong.beatMap.kick.currentside;
    float val2 = -frameCount+stageManager.daSong.beatMap.snare.currentside;

    float pnoiseVal = noise((val1+w/2)*noiseScale2, (val2+h/2+15)*noiseScale2);
    playery = cell*pow(.5+pnoiseVal, 12)/2+50;
    //println(playery);
    float dx = (playerx-xpos)*friction;
    float dy = (playery-ypos)*friction;
    xpos+=dx; 
    ypos+=dy;
    pg.translate(xpos, ypos, 0);
    pg.translate(-w*cell/2, 0, -h*cell*.75);

    for (int j=0; j<h; j++) {
      for (int i=0; i<w; i++) {
        float noiseVal;
        noiseVal = noise((val1+i)*noiseScale1, (val2+j)*noiseScale1);
        pg.pushMatrix();
        pg.translate(i*cell, 0, j*cell);
        //if(i!=w/2){
        pg.fill(((200+int(noiseVal*128))%256+frameCount)%256, 200, 255*stageManager.daSong.beatMap.hat.currentside/100);
        //if(random(1)>.9)
        pg.box(cell*.8, cell*pow(.5+noiseVal, 12), cell*.8);
        /*}else{
         noiseVal = noise((val1+i)*noiseScale2, (val2+j)*noiseScale2);
         pg.fill(int(noiseVal*128)%256,200,255);
         pg.box(cell*.8,cell*pow(.5+noiseVal,12),cell*.8);
         }*/
        pg.popMatrix();
      }
    }
  }
}
class VOkeyMickey extends VScreen {
  ArrayList keymi;
  color bgcolor;
  PFont font;

  VOkeyMickey(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");

    keymi = new ArrayList();
    keymiRoutine();
  }
  void keymiRoutine() {
    BlobWorld blobworld;

    blobworld = new BlobWorld("visuals/okeymickeyclub/keymi_logo.xml");
    for (int i=0; i<blobworld.blobs.length; i++) {
      //blobs[i].draw();
      VShape tmp = new VShape();
      for (int j=0; j<blobworld.blobs[i].points.length; j++) {
        tmp.addLine(
        blobworld.blobs[i].points[j].x, 
        blobworld.blobs[i].points[j].y, 
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].x+random(-10, 10), 
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].y+random(-10, 10)
          );
      }
      tmp.translate(-blobworld._width/2, -blobworld._height/2);//auxyoff);
      tmp.scale(1.5);
      tmp.setStrokeWeight(8);
      tmp.startRun(60, tmp.perimeter*.8);
      keymi.add(tmp);
    }
    blobworld = new BlobWorld("visuals/okeymickeyclub/kuernos_logo.xml");
    for (int i=0; i<blobworld.blobs.length; i++) {
      //blobs[i].draw();
      VShape tmp = new VShape();
      for (int j=0; j<blobworld.blobs[i].points.length; j++) {
        tmp.addLine(
        blobworld.blobs[i].points[j].x, 
        blobworld.blobs[i].points[j].y, 
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].x+random(-10, 10), 
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].y+random(-10, 10)
          );
      }
      tmp.translate(-blobworld._width/2, -blobworld._height/2);//auxyoff);
      tmp.scale(1.5);
      tmp.setStrokeWeight(8);
      tmp.startRun(10, tmp.perimeter*.8);
      keymi.add(tmp);
    }
  }
  void draw(PGraphics pg) {
    color bgcolor = color(0);
    pg.beginDraw();
    pg.colorMode(HSB);

    pg.translate(pg.width/2, pg.height/2);

    if (stageManager.daSong.beatMap.snare.currentside>80) {
      screendiv=2;
      pg.scale(random(2, 4));
      bgcolor = color(random(255), 255, 255);
    }
    else if (stageManager.daSong.beatMap.kick.currentside>80) {
      screendiv=4;
      pg.scale(random(4, 8));
      bgcolor = color(random(0, 32), 255, 255);
    }
    else if (stageManager.daSong.beatMap.hat.currentside>80) {
      screendiv=8;
      pg.scale(random(8, 12));
      bgcolor = color(random(85, 128), 255, 255);
    }
    else {
      screendiv=1;
    }

    pg.background(bgcolor);//bgcolor);//0,0);

    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      //stageManager.daSong.beatMap.draw(pg);
      pg.popMatrix();
      if (vl>0) {
        lyricsRing(pg);
      }
      for (int i=0; i<keymi.size(); i++) {
        VShape tmp = (VShape)keymi.get(i);
        tmp.draw(pg);
      }
    }
    pg.endDraw();
  }
  void lyricsRing(PGraphics pg) {
    float r = pg.width/4;
    String ts = vislyric;
    ts+=ts;
    float da = TWO_PI/(ts.length()+1);
    tw = (TWO_PI*r)/(2*vl+1);
    //0,0,lyricop,lyricop);
    pg.textFont(font, tw);
    for (int i=0; i<ts.length()-1; i++) {
      String tmp = ts.substring(i, i+1);
      pg.pushMatrix();
      pg.rotateY(i*da-radians((frameCount*2)%360));
      pg.translate(0, 40, r);
      pg.fill(random(255), 255, 255, lyricop);
      pg.text(tmp, -tw/2, tw/2);
      pg.popMatrix();
    } 
    /*

     pg.text(vislyric,-pg.width/2,tw/2);*/

    lyricop*=lyricd;
    if (lyricop>255 && lyricd>1) {
      lyricd = .99;
    }
  }
}
class VFlowR extends VScreen {
  color bgcolor;

  VFlowR(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      stageManager.daSong.beatMap.draw(pg);
      pg.popMatrix();
      if (vl>0) {
        tw = pg.width/vl;
        pg.fill(0, 0, lyricop, lyricop);
        //pg.textFont(font, tw);
        //pg.text(vislyric,-pg.width/2,tw/2);
        lyricop*=lyricd;
        if (lyricop>255 && lyricd>1) {
          lyricd = .97;
        }
      }
    }
    pg.endDraw();
  }
}
class VSheLost extends VScreen {
  color bgcolor;
  PFont font;

  VSheLost(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      stageManager.daSong.beatMap.draw(pg);
      pg.popMatrix();



      if (vl>0) {
        tw = pg.width/vl;
        pg.fill(0, 0, lyricop, lyricop);
        pg.textFont(font, tw);
        pg.text(vislyric, -pg.width/2, tw/2);

        //tmp = vislyric.substring(0, 1);
        //vislyric = vislyric.substring(1, vl);
        //vislyric+=tmp;

        lyricop*=lyricd;
        if (lyricop>255 && lyricd>1) {
          lyricd = .97;
        }
      }
    }
    pg.endDraw();
  }
}


class VSongzero extends VScreen {
  color bgcolor;
  PFont font;
  NewTunnel tunnel;
  Alebrije alebrije;

  VSongzero(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    tunnel = new NewTunnel();
    alebrije = new Alebrije(0, 100, 0);
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(16, 255, 255*stageManager.daSong.beatMap.kick.currentside/100);//,bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);

      if (stageManager.bar<4) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else {
        tunnel.draw(pg);
      }
      //println("vl:"+vl+" "+vislyric);
      if (vl>0) {
        tw = pg.width/vl;
        pg.fill(0, 0, lyricop, lyricop);
        pg.textFont(font, tw*10);
        pg.textMode(SCREEN);//
        //println("tw:"+tw+"   vl:"+vl);
        pg.text(vislyric, -pg.width/2, tw/2+200);

        tmp = vislyric.substring(0, 1);
        vislyric = vislyric.substring(1, vl);
        vislyric+=tmp;

        lyricop*=lyricd;
        if (lyricop>255 && lyricd>1) {
          lyricd = .99;
        }
      }
    }
    pg.endDraw();
  }
}


class NewTunnel {
  float[] anglex, angley, anglez;
  float[] ratios;
  color[] colors;
  boolean[] areboxes;
  float[] boxes;
  boolean[] arerings;
  int cycle;
  int mars;
  float ringangle = 0;
  int cspeed = -2;
  Mono mono;
  Alebrije alebrije;
  float wwe = 0;

  NewTunnel() {
    mars = 100;
    anglex = new float[mars];
    angley = new float[mars];
    anglez = new float[mars];
    ratios = new float[mars];
    colors = new color[mars];
    areboxes = new boolean[mars];
    boxes  = new float[mars];
    arerings = new boolean[mars];
    float ax = 0;
    float ay = 0;
    float az = 0;
    float toax = 0;
    float toay = 0;
    float toaz = 0;
    float dax = 0;
    float dAy = 0;
    float daz = 0;
    int fixsteps = 100;
    for (int i=0; i<ratios.length; i++) {
      if (i%fixsteps==0) {
        toax = random(-PI/180, PI/180);
        toay = random(-PI/180, PI/180);
        toaz = random(-PI/180, PI/180);
        dax = (toax-ax)/fixsteps;
        dAy = (toay-ay)/fixsteps;
        daz = (toaz-az)/fixsteps;
      };
      ax+=dax;
      ay+=dAy;
      az+=daz;
      anglex[i] = ax;
      angley[i] = ay;
      anglez[i] = az;
      ratios[i] = random(100, 120);
      colors[i] = color(16, 255, 255);//color(0,128,255);//color(int(random(255)));
      if (true) {//random(10)>8
        areboxes[i] = true;
        boxes[i] = random(ratios[i])-ratios[i]*.5;
      }
      else {
        areboxes[i] = false;
      };
      if (i%80==0) {
        arerings[i] = true;
      }
      else {
        arerings[i] = false;
      }
    };
    cycle = 0;
    mono = new Mono(0, 0, 0);
    alebrije = new Alebrije(0, 0, 0);
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.scale(map(stageManager.bar, 0, 132, .5, 10));
    pg.pushStyle();
    //pg.colorMode(RGB);
    //translate(width*.5, height*.5+20, 300);
    //pg.background(16,255,255);//255,128,0);
    //lights();

    pg.translate(0, 20, 300);//20,300);//width*.5, height*.5+20, 300);
    pg.rotate(wwe);
    wwe+=PI/60;
    pg.scale(1.5);
    pg.strokeWeight(1);
    pg.noStroke();
    //noFill();

    //float percent=max(0,(zpectral.myFFT.max-zpectral.minLimit)/zpectral.limitDiff);
    //pg.scale(1+percent/20);

    for (int i=0; i<ratios.length; i++) {
      //println((i+cycle)%ratios.length);
      int j = abs((i+cycle)%ratios.length);
      float r = ratios[j];
      float depthf = (1-float(i)/(ratios.length-1));
      color k = blendColor(colors[j], color(8+int(16*depthf), 255, 255*depthf), BLEND);//int(205*depthf), int(51*depthf)), BLEND  );
      pg.stroke(16, 255, 255);//255,128,0);
      //noStroke();
      pg.fill(k);
      //rectMode(CENTER);
      float ff = 1;
      //rect(0,0,r,r*ff);
      if (areboxes[j]) {
        pg.pushMatrix();
        //translate(boxes[j], ratios[j]*.5*ff, 0);
        //translate(boxes[j], 0, 0);//ratios[j]*.5*ff
        pg.rotateZ(boxes[j]);
        pg.translate(0, ratios[j]*.5*ff, 0);

        //stroke(255);

        pg.scale(2.5, .1, 6);
        pg.box(10);
        pg.popMatrix();
      };

      if (arerings[j]) {
        int ringsteps = 6;
        for (int rk=0; rk<ringsteps; rk++) {
          pg.pushMatrix();
          //translate(boxes[j], ratios[j]*.5*ff, 0);
          pg.rotateZ(rk*TWO_PI/ringsteps+ringangle);
          pg.translate(0, 100, 0);
          //scale(1,1,1);
          pg.box(20);
          float rr = 20+40*cos(ringangle);
          pg.translate(0, rr, 0);
          pg.scale(1, 40, 1);
          pg.box(2);
          pg.popMatrix();
        };
      };
      if (i==20) {
        pg.pushMatrix();
        pg.rotate(-wwe);
        pg.translate(0, 15, 0);
        pg.scale(0.6);
        if (stageManager.daSong.beatMap.snare.currentside<50)//bar%2==0)
          mono.draw(pg);
        else
          alebrije.draw(pg);
        pg.popMatrix();
      }
      pg.translate(0, 0, -10);
      pg.rotateX(anglex[j]);
      pg.rotateY(angley[j]);
      pg.rotateZ(anglez[j]);
    }
    ringangle+=PI/60;
    cycle+=cspeed;
    pg.popStyle();
    pg.popMatrix();
  }
}

class Mono {
  float x, y, z;
  float caminangulo;

  Mono(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
  void draw(PGraphics pg) {
    //colorMode(RGB);
    pg.ambientLight(16, 255, 64);//128, 64, 0);
    pg.spotLight(16, 255, 128, 80, 20, 40, -1, 0, 0, PI/2, 2);//255, 128, 0, 80, 20, 40, -1, 0, 0, PI/2, 2);
    //directionalLight(51, 102, 126, 0, -1, 0);
    pg.pointLight(96/2, 255/2, 240, 0, -500, 1000);//255/2, 200/2, 30/2, 0, -500, 1000);
    //if(random(100)>70);pointLight(240+random(15), 0,0, 0, 0, 2000);
    pg.stroke(16, 255, 255);//255,128,0);
    float f = 9;//4;
    caminangulo = radians(90*sin(radians(f*frameCount%360)));
    float eleva = 40*sin(radians(f*frameCount%360));
    fill(255);
    pg.pushMatrix();
    //scale(0.25);
    pg.scale(.8);
    //rotateZ(radians(.5*frameCount%360));
    pg.translate(0, -abs(eleva), 0);
    //torso
    pg.box(30, 40, 10);
    //right napier
    pg.pushMatrix();
    pg.translate(10, 20, 0);
    pg.rotateX(caminangulo);
    pg.translate(0, 20, 0);
    pg.box(10, 40, 10);
    pg.popMatrix();
    //left napier
    pg.pushMatrix();
    pg.translate(-10, 20, 0);
    pg.rotateX(-caminangulo);
    pg.translate(0, 20, 0);
    pg.box(10, 40, 10);
    pg.popMatrix();
    //middle leg
    pg.pushMatrix();
    float erektangulo = radians(145);//+caminangulo*.2;
    float dotation = 20;//12;//20;//6;//15;//6;//15;//20;
    float contrapeso = dotation/5;
    float grip = 6;//3;//4;//6; 
    pg.translate(0, 20, 5);

    pg.pushMatrix();
    pg.rotateX(erektangulo);
    //if(erektangulo<PI/2)
    pg.rotateX(map(erektangulo, radians(15), radians(145), 1, 0)*abs(caminangulo));
    pg.translate(0, (dotation+contrapeso)/2-contrapeso, -grip/2);
    pg.box(grip, dotation+contrapeso, grip);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(-2.5, 2.25, -2.5);
    pg.rotateX(caminangulo);
    pg.box(4.5);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(2.5, 2.25, -2.5);
    pg.rotateX(-caminangulo);
    pg.box(4.5);
    pg.popMatrix();
    pg.popMatrix();
    //right arm
    pg.pushMatrix();
    pg.translate(20, -20, 0);
    pg.rotateX(-caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0, 20, 0);
    pg.box(10, 40, 10);
    pg.popMatrix();
    //left arm
    pg.pushMatrix();
    pg.translate(-20, -20, 0);
    pg.rotateX(caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0, 20, 0);
    pg.box(10, 40, 10);
    pg.popMatrix();
    //kabeza
    pg.pushMatrix();
    pg.translate(0, -30, 0);
    pg.rotateY(caminangulo/4);
    pg.box(20);
    pg.translate(0, 0, 12);
    //pointLight(200, 0, 30, 5, -5, 0);
    pg.fill(255, 0, 0);
    pg.ellipse(5, -5, 5, 5);
    pg.ellipse(-5, -5, 5, 5);
    pg.popMatrix();

    pg.popMatrix();
  }
}











class VAntarctic extends VScreen {
  color bgcolor;
  //PFont font;

  HollowEarth earth;
  Flag flag;
  Lnr lnr;
  AntarcticLogo antarcticLogo;
  Antarctic antarctic;
  WOklr woklr;

  VAntarctic(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    earth = new HollowEarth("visuals/antarctic/blobworld.xml");
    antarctic = new Antarctic();
    antarcticLogo = new AntarcticLogo();
    flag = new Flag();
    lnr = new Lnr();
    woklr = new WOklr();
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      int bar = stageManager.bar;
      ////stageManager.daSong.beatMap.update(pos);

      if (bar<4) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if (bar<20) {
        mode00(pg);
      }
      else if (bar<28) {
        mode01(pg);
      }
      else if (bar<44) {
        mode02(pg);
      }
      else if (bar<52) {
        mode03(pg);
      }
      else if (bar<68) {
        mode04(pg);
      }
      else if (bar<76) {
        mode01(pg);
      }
      else if (bar<92) {
        mode02(pg);
      }
      else if (bar<100) {
        mode03(pg);
      }
      else {
        mode05(pg);
      }
    }
    pg.endDraw();
  }
  void mode00(PGraphics pg) {
    flag.draw(pg);
    if (stageManager.daSong.beatMap.kick.currentside>30)lnr.draw(pg);
    if (stageManager.daSong.beatMap.snare.currentside>80)antarcticLogo.draw(pg);
  }
  void mode01(PGraphics pg) {
    if (stageManager.daSong.beatMap.kick.currentside>30) {
      lnr.draw(pg);
    }
    else {
      flag.draw(pg);
    }
    if (stageManager.daSong.beatMap.snare.currentside>80)antarcticLogo.draw(pg);
  }
  void mode02(PGraphics pg) {
    if (stageManager.daSong.beatMap.kick.currentside>30) {
      antarctic.draw(pg);
      woklr.draw(pg);
    }
    else {
      flag.draw(pg);
      if (stageManager.daSong.beatMap.hat.currentside>30)lnr.draw(pg);
    }
  }
  void mode03(PGraphics pg) {

    if (stageManager.daSong.beatMap.snare.currentside>80) {
      antarcticLogo.draw(pg);
    }
    else if (stageManager.daSong.beatMap.kick.currentside>30) {
      flag.draw(pg); 
      lnr.draw(pg);
    }
  }
  void mode04(PGraphics pg) {
    pg.pushMatrix();
    pg.scale(2*stageManager.daSong.beatMap.kick.currentside/100);

    if (stageManager.daSong.beatMap.snare.currentside>80) {
      antarcticLogo.draw(pg);
    }
    else if (stageManager.daSong.beatMap.kick.currentside>30) {
      earth.draw(pg);
    }
    else {
      antarctic.draw(pg);
    }
    pg.popMatrix();
  }
  void mode05(PGraphics pg) {
    pg.pushMatrix();
    pg.scale(.5+2.5*stageManager.daSong.beatMap.kick.currentside/100);
    earth.draw(pg);
    if (stageManager.daSong.beatMap.snare.currentside>80) {
      antarcticLogo.draw(pg);
    }
    pg.popMatrix();
  }
}

class HollowEarth {
  BlobWorld blobworld;

  HollowEarth(String url) {
    blobworld = new BlobWorld(url);//"blobworld.xml");
  }

  void draw(PGraphics pg) {
    //background(0);
    //translate(width/2,height/2);
    pg.pushMatrix();
    pg.scale(2.5);
    pg.rotateZ(radians(30));
    pg.rotateY(radians(-frameCount%360));
    for (int i=0; i<255; i+=8) {
      pg.stroke((255-i+16*frameCount)%256, 255, 255, 255-i);
      pg.scale(1.01);
      blobworld.draw(pg);
    }
    pg.popMatrix();
  }
}












class VSunlight extends VScreen {
  color bgcolor;
  float noiseScale=0.3;//0.3;//0.1;//.005;//.01;//0.02;//.01;//0.02;
  float w, h;
  float cellw, cellh;
  float val1, val2;

  VSunlight(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    w = 40;//(1+4*stageManager.daSong.frame%16);//64;//width/10; 
    h = 30;//(1+4*stageManager.daSong.frame%16);//48;//height/10;
    cellw = 800/w;//width/w;
    cellh = 600/h;//height/h;
  }  
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//0,0);
    pg.translate(pg.width/2, pg.height/2);

    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);

      if (stageManager.bar<1) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else {
        likuid(pg);
      }
    }
    pg.endDraw();
  }
  void likuid(PGraphics pg) {
    pg.rectMode(CENTER);
    pg.pushMatrix();
    pg.noStroke();
    pg.scale(stageManager.daSong.beatMap.kick.currentside>80 ? 2 : 1);
    pg.translate(cellw/2, cellh/2);
    for (int i=0; i<w/2; i++) {
      for (int j=0; j<h/2; j++) {
        int m = int((i+j*w)%w);
        float spc = 0;//2*zpectral.myFFT.spectrum[m];//*PI;

        val1 += stageManager.daSong.beatMap.kick.currentside/100;//-frameCount*.2;//.2;//random(width);//w/2*(1+sin(radians(frameCount%360)));//frameCount;
        val2 += stageManager.daSong.beatMap.snare.currentside/100;//h/2*(1+sin(radians(frameCount%360)));

        float noiseVal1, noiseVal2, noiseVal3;
        noiseVal1 = noise((val1+i)*noiseScale, (val2+j)*noiseScale);
        noiseVal2 = noise((val1+j)*noiseScale, (val2+i)*noiseScale);
        noiseVal3 = noise((val2+i)*noiseScale, (val1+i)*noiseScale);
        int n = int((noiseVal1+noiseVal2+noiseVal3)*256);
        n%=256;
        color k =  color (map(n, 0, 255, 196, 240), 255, 255, 256-stageManager.daSong.beatMap.kick.currentside*2.56);//*noiseVal2);//,255,255

        boolean cond1 = stageManager.daSong.frame%2==0;
        boolean cond2 = (i-frameCount)%(stageManager.bar+1)==0 || (j-frameCount/2)%(stageManager.daSong.frame+1)==0;
        boolean cond3 = cond1 && !cond2;
        boolean cond4 = !cond1 && cond2;

        if (cond3 || cond4) {
          pg.pushMatrix();
          pg.translate(i*cellw, j*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();

          pg.pushMatrix();
          pg.translate((-i-1)*cellw, j*cellh);//(w-1-i)*cellw,j*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();

          pg.pushMatrix();
          pg.translate(i*cellw, (-1-j)*cellh);//(h-1-j)*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();
          pg.pushMatrix();
          pg.translate((-1-i)*cellw, (-1-j)*cellh);//(w-1-i)*cellw,(h-1-j)*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();
        }
      }
    }
    //filter(POSTERIZE, 4);
    pg.popMatrix();
    pg.endDraw();
  }
  void dddot(color k, PGraphics pg) {
    pg.fill(k);
    pg.scale(.8); 
    ddot(pg);
    pg.fill(0);
    pg.scale(.6); 
    ddot(pg);
    pg.fill(k);
    pg.scale(.6); 
    ddot(pg);
  }
  void ddot(PGraphics pg) {
    pg.rect(0, 0, cellw, cellh);
  }
}











class VAhardplace extends VScreen {
  color bgcolor;
  PFont font;
  GuemboiV guemboi;
  GFlag    gflag;

  VAhardplace(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    guemboi = new GuemboiV();//("visuals/antarctic/blobworld.xml");
    gflag = new GFlag();
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      int bar = stageManager.bar;
      if (bar<4) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if (bar<20) {
        if (random(10)>2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<36) {
        if (random(10)<2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<44) {
        if (random(10)>2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<60) {
        if (random(10)<2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<68) {
        if (random(10)<5)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<76) {
        if (random(10)>2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<92) {
        if (random(10)<2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<100) {
        if (random(1)>.8) {
          if (random(10)>2) {
            mode00(pg);
          }
          else {
            if (stageManager.daSong.frame%2==0)
              pg.background(gflag.colors[stageManager.daSong.frame%gflag.colors.length]);
            mode01(pg);
          }
        }
        else {
          pg.background(gflag.colors[stageManager.daSong.frame%gflag.colors.length]);
        }
      }
      else if (bar<117) {
        if (random(10)>5) {
          mode00(pg);
        }
        else {
          pg.background(gflag.colors[stageManager.daSong.frame%gflag.colors.length]);
          mode01(pg);
        }
      }
      else {
        pg.background(gflag.colors[stageManager.daSong.frame%gflag.colors.length]);
        mode01(pg);
      }
    }
    pg.endDraw();
  }
  void mode00(PGraphics pg) {
    gflag.draw(pg);
  }
  void mode01(PGraphics pg) {
    guemboi.draw(pg);
  }
}





class VAnemic extends VScreen {
  color bgcolor;
  //PFont font;
  Anemiko anemic;
  TScreen tscreen;

  VAnemic(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    color[] tmp = new color[3];
    tmp[0] = color(0, 255, 255);
    tmp[1] = color(0);
    tmp[2] = color(255);
    anemic = new Anemiko(tmp);//
    tscreen = new TScreen(tmp);
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      int bar = stageManager.bar;
      if (bar<2) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if (bar<12) {
        if (random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<20) {
        if (random(1)>.5)
          mode01(pg);
        else
          mode00(pg);
      }
      else if (bar<28) {
        if (random(1)>.1)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<36) {
        if (random(1)>.1)
          mode01(pg);
        else
          mode00(pg);
      }
      else if (bar<44) {
        if (random(1)>.2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<52) {
        if (random(1)>.2)
          mode01(pg);
        else
          mode00(pg);
      }
      else if (bar<64) {
        if (random(1)>.4)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<70) {
        if (random(1)>.4)
          mode01(pg);
        else
          mode00(pg);
      }
      else {
        if (random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
    }
    pg.endDraw();
  }
  void mode00(PGraphics pg) {
    anemic.draw(pg);
  }
  void mode01(PGraphics pg) {
    tscreen.setCell(8*(1+stageManager.bar%4));
    tscreen.setText(vislyric);
    tscreen.draw(pg);
  }
}


class VSilverstein extends VScreen {
  color bgcolor;
  PFont font;
  Anemiko anemic;
  TScreen tscreen;
  SapoLivingstone sapo;

  VSilverstein(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    color[] tmp = new color[7];
    tmp[0] = color(0);//0,0,0);
    tmp[1] = color( map(194, 0, 360, 0, 255), map(48, 0, 100, 0, 255), map(99, 0, 100, 0, 255) );//color(0x81E0FF);//129, 224,255); 
    tmp[2] = color(map(330, 0, 360, 0, 255), map(85, 0, 100, 0, 255), map(98, 0, 100, 0, 255) );//color(0xFD228C);//253, 34, 140); 
    tmp[3] = color(map(206, 0, 360, 0, 255), map(54, 0, 100, 0, 255), map(86, 0, 100, 0, 255) );//color(0x64A6DE);//100, 166, 222); 
    tmp[4] = color(map(358, 0, 360, 0, 255), map(99, 0, 100, 0, 255), map(95, 0, 100, 0, 255) );//color(0xF50001);//245, 0, 1);
    tmp[5] = color(map(140, 0, 360, 0, 255), map(27, 0, 100, 0, 255), map(78, 0, 100, 0, 255) );//color(0x92CBA6);//146, 203, 166); 
    tmp[6] = color(map(321, 0, 360, 0, 255), map(6, 0, 100, 0, 255), map(99, 0, 100, 0, 255) );//color(0xFFEFF9);//255, 239, 249); 
    anemic = new Anemiko(tmp);//

    tscreen = new TScreen(tmp);
    sapo = new SapoLivingstone();
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);
      int bar = stageManager.bar;
      if (bar<0) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if (bar<20) {
        if (random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<36) {
        if (random(1)>.5)
          mode01(pg);
        else
          mode00(pg);
      }
      else if (bar<44) {
        if (random(1)>.1)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<52) {
        if (random(1)>.1)
          mode01(pg);
        else
          mode00(pg);
      }
      else if (bar<68) {
        if (random(1)>.2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<84) {
        if (random(1)>.2)
          mode01(pg);
        else
          mode00(pg);
      }
      else if (bar<92) {
        if (random(1)>.4)
          mode00(pg);
        else
          mode01(pg);
      }
      else if (bar<94) {
        if (random(1)>.4)
          mode01(pg);
        else
          mode00(pg);
      }
      else {
        if (random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
      //sapo.draw(pg);
    }
    pg.endDraw();
  }
  void mode00(PGraphics pg) {
    anemic.draw(pg);
  }
  void mode01(PGraphics pg) {
    tscreen.setCell(8*(1+stageManager.bar%4));
    tscreen.setText(vislyric);
    tscreen.draw(pg);
  }
}


class VPunkrocker extends VScreen {
  color bgcolor;
  PFont font;
  Emo emo;

  VPunkrocker(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    emo = new Emo();//("visuals/antarctic/blobworld.xml");
  }
  void draw(PGraphics pg) {

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.sequencer.isRunning()) {
      int pos = stageManager.bar*16 + stageManager.daSong.frame;
      ////stageManager.daSong.beatMap.update(pos);

      if (stageManager.bar<4) {
        pg.pushMatrix();
        pg.scale(4);
        stageManager.daSong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else {
        emo.draw(pg);
      }
    }
    pg.endDraw();
  }
}

class GuemboiV {

  Slideclip cosmos = new Slideclip("visuals/ahardplace/cosmos.png", 0, -960);
  Slideclip cordillera = new Slideclip("visuals/ahardplace/cordillera.png", 0, -200*.64);
  Slideclip edificiosatras = new Slideclip("visuals/ahardplace/edificiosatras.png", 0, -100*.64);
  Slideclip edificios = new Slideclip("visuals/ahardplace/edificios.png", 0, -75*.64);
  Slideclip arbolesatras = new Slideclip("visuals/ahardplace/arbolesatras.png", 0, -100*.64);
  Slideclip postes = new Slideclip("visuals/ahardplace/postes.png", 0, 10*.64);
  Slideclip panderetas = new Slideclip("visuals/ahardplace/panderetas.png", 0, 60*.64);
  Slideclip arbolesfrente = new Slideclip("visuals/ahardplace/arbolesfrente.png", 0, -150*.64);
  Slideclip primerplano = new Slideclip("visuals/ahardplace/primerplano.png", 0, -67*.64);
  Slideclip rejas = new Slideclip("visuals/ahardplace/rejas.png", 0, -62*.64);
  Slideclip groundx = new Slideclip("visuals/ahardplace/groundx.png", 0, 76*.64);

  Slideclip[] planes_array = {
    cosmos, cordillera, edificiosatras, edificios, arbolesatras, postes, panderetas, arbolesfrente, primerplano, rejas, groundx
  };

  float[] planes_faktor = {
    1, .9, .6, .55, .36, .25, .18, .14, 0, -.5, -.5
  };
  float[] planes_skroll = {
    0, 1024, 1024, 1024, 1024, 1024, 1024, 832, 722, 960, 1024
  };
  float[] planes_xx = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  };

  Slideclip pivote;

  float cam_xoff, cam_yoff, dcam_xoff, dcam_yoff, cam_friction;
  float xx, speed, dspeed, tospeed, maxspeed, speedfriction;

  float direction, olddirection;

  Pacos pacos;
  Encapuxaos encapuxaos;
  Molotovs molotovs;

  GuemboiV() {
    cam_xoff = 0;
    cam_yoff = 0;
    dcam_xoff = 0;
    dcam_yoff = 0;
    cam_friction = .2;

    xx = 0;
    speed = 0;
    dspeed = 0;
    tospeed = 10;
    maxspeed = 20;
    speedfriction = .12;

    pacos = new Pacos(200, 5);
    encapuxaos = new Encapuxaos(-200, 5);
    molotovs = new Molotovs();
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();
    //pg.scale(2);
    pg.translate(-pg.width/2, -pg.height/2);

    //pg.scale(.5);
    dcam_xoff = (0-cam_xoff)*cam_friction;
    dcam_yoff = (0-cam_yoff)*cam_friction;
    cam_xoff += dcam_xoff;
    cam_yoff += dcam_yoff;

    //direction = -1;//int(-joypadA.xslider.getValue());

    direction = -(pacos.x+encapuxaos.x)/200;

    dspeed = (tospeed*direction-speed)*speedfriction;
    speed += dspeed;

    //player.direction = -direction;
    olddirection = direction;
    float zzka = 1+random(10);
    for (int i=0;i<planes_array.length;i++) {

      planes_array[i].x = cam_xoff*planes_faktor[i];
      planes_array[i].y = cam_yoff*planes_faktor[i];
      //
      float pfaktor = -(planes_faktor[i]-1);
      planes_xx[i] += speed*pfaktor;
      if (planes_xx[i]<-planes_skroll[i])planes_xx[i]+=planes_skroll[i];
      if (planes_xx[i]>0)planes_xx[i]-=planes_skroll[i];
      //planes_mcxx[i]._x = planes_xx[i];
      planes_array[i].xtra_x = planes_xx[i];
      if (i==8) {
        pacos.draw(pg);
        encapuxaos.draw(pg);
        molotovs.draw(pg);
      };
      /*if(i==0){
       planes_array[i].draw(pg);
       }else if(random(10)>8){*/
      planes_array[i].draw(pg);
      if (i==10) {
        pg.fill(0);//64,255,255);
        pg.noStroke();
        pg.rectMode(CORNER);
        pg.rect(0, 500, 800, 100);
      } 
      //}
    }

    cosmos.rotation-=radians(20);
    pg.popMatrix();
  }

  class Slideclip {
    float x = 0;
    float xtra_x = 0;
    float y = 0;
    PImage img;
    String name;
    float xoff, yoff;
    float rotation = 0;

    Slideclip(String $1, float $2, float $3) {
      img = loadImage($1);
      xoff = $2; 
      yoff = $3;
    }
    void draw(PGraphics pg) {
      pg.pushMatrix();
      pg.translate(400, 300);
      pg.rotateZ(rotation);
      pg.translate(xoff, yoff);
      pg.translate(-img.width*.5, -img.height*.5);
      pg.translate(x+xtra_x, y);
      pg.translate(0, img.height);
      pg.image(img, 0, 0);
      pg.image(img, img.width, 0);
      pg.popMatrix();
    }
  }


  class Encapuxaos {
    ArrayList grupo;
    float xbase;
    float x, tox, dx, friction;
    int cuantos;
    int current;
    boolean attackFlag;

    Encapuxaos(float xbase, int cuantos) {
      this.xbase = xbase;
      x = 0;
      tox = x;
      dx = 0;
      friction = .6;//.16;
      this.cuantos = cuantos;
      grupo = new ArrayList();
      for (int i=0; i<cuantos; i++) {
        grupo.add(new Encapuxao(random(-100, 100)));
      }
    }
    void draw(PGraphics pg) {
      update();
      pg.pushMatrix();
      pg.translate(400, 300+84);
      pg.translate(xbase+x, 0);
      boolean areCurrent=false;
      for (int i=0; i<grupo.size(); i++) {
        Encapuxao tmp = (Encapuxao)grupo.get(i);      
        if (tmp.isDead) {
          grupo.remove(i);
        }
        else {
          if (tmp.isCurrent) {
            areCurrent = true;
          }
          else {
            tmp.draw(pg);
          }
        }
      }
      if (!areCurrent)setCurrent();
      Encapuxao upper = (Encapuxao)grupo.get(current);
      upper.draw(pg);
      pg.popMatrix();
    }
    void setCurrent() {
      int ncurrent = current;
      while (ncurrent ==current) {
        ncurrent = (int)random(grupo.size());
      }
      current = ncurrent;
      Encapuxao tmp = (Encapuxao)grupo.get(current);
      tmp.isCurrent = true;
    }
    void update() {
      dx = tox - x;
      if (abs(dx)<1)tox = random(-200, 0);
      x += dx*friction;

      if (!attackFlag && random(100)>95) {
        attack();
      }
    }
    void attack() {
      Encapuxao tmp = (Encapuxao)grupo.get(current);
      tmp.attack();
      attackFlag = true;
    }

    class Encapuxao {
      PImage[] skin;
      float x, tox, dx, friction;
      boolean isDead;
      int direction = 1;
      int olddirection = 1;
      int pdirection = 1;
      boolean isCurrent = false;
      boolean isAttacking = false;
      int attackframe;

      Encapuxao(float x) {
        this.x = x;
        tox = x;
        dx = 0;
        friction = .96;
        skin = new PImage[3];
        skin[0] = loadImage("visuals/ahardplace/encapuchao_nada.png");
        skin[1] = loadImage("visuals/ahardplace/encapuchao.png");
        skin[2] = loadImage("visuals/ahardplace/encapuchao_throw.png");
      }
      void draw(PGraphics pg) {
        update();
        pg.pushMatrix();
        pg.translate(x, 0);
        pg.scale(.4);
        if ((olddirection==-1 && direction==0)||direction==-1) {
          pdirection=-1;
        }
        else if ((olddirection==1 && direction==0)||direction==1) {
          pdirection=1;
        }
        if (pdirection==-1)pg.rotateY(-PI);

        if (isCurrent) {
          pg.noTint();
          pg.noStroke();
          pg.fill(255);
          pg.triangle(0, -170, -20, -200, 20, -200);
          pg.pushMatrix();
          if (pdirection==-1)pg.rotateY(-PI);
          pg.text("P1", -32, -200);
          pg.popMatrix();
        }
        else {
          if (frameCount%3==0) {
            pg.tint(255, 0, 0);
          }
          else if (frameCount%3==1) {
            pg.tint(255);
          }
          else {
            pg.tint(0);
          }
        }

        PImage cskin;
        if (isCurrent) {
          if (attackframe>20) {
            cskin = skin[1];
          }
          else if (attackframe>10) {
            cskin = skin[2];
          }
          else {
            cskin = skin[0];
          }
        }
        else {
          cskin = skin[0];
        }
        pg.translate(-cskin.width*.5, -cskin.height);
        pg.image(cskin, 0, 0);
        pg.popMatrix();
        olddirection = direction;
        pg.noTint();
      }
      void update() {
        if (!isAttacking) {
          if ((dx>=0 && x>=tox) || (dx<=0 && x<=tox)) {
            tox = random(-100, 100);
            if (tox>x) {
              dx=4;
              direction = 1;
            }
            else if (tox<x) {
              dx=-4;
              direction = -1;
            }
            else {
              dx=0;
              direction = 0;
            }
          }
          x += dx;
        }
        else {
          if (attackframe==20)molotovs.addMolotov(x);
          if (attackframe>6)x += dx;
          attackframe--;
          if (attackframe<=0)endAttack();
        }
      }
      void attack() {
        isAttacking = true;
        direction = 1;
        dx = 8;
        attackframe = 40;
      }
      void endAttack() {
        isCurrent = false;
        isAttacking = false;
        direction = -1;
        tox = -100;
        attackframe = 0;
        attackFlag = false;
      }
    }
  }



  class Pacos {
    ArrayList grupo;
    float xbase;
    float x, tox, dx, friction;
    int cuantos;
    int current;
    boolean attackFlag;

    Pacos(float xbase, int cuantos) {
      this.xbase = xbase;
      x = 0;
      tox = x;
      dx = 0;
      friction = .6;
      this.cuantos = cuantos;
      grupo = new ArrayList();
      for (int i=0; i<cuantos; i++) {
        grupo.add(new Paco(random(-100, 100)));
      }
    }
    void draw(PGraphics pg) {
      update();
      pg.pushMatrix();
      pg.translate(400, 300+84);
      pg.translate(xbase+x, 0);
      boolean areCurrent=false;
      for (int i=0; i<grupo.size(); i++) {
        Paco tmp = (Paco)grupo.get(i);      
        if (tmp.isDead) {
          grupo.remove(i);
        }
        else {
          if (tmp.isCurrent) {
            areCurrent = true;
          }
          else {
            tmp.draw(pg);
          }
        }
      }
      if (!areCurrent)setCurrent();
      if (current>=grupo.size())current=grupo.size()-1;
      Paco upper = (Paco)grupo.get(current);
      upper.draw(pg);
      pg.popMatrix();
    }
    void setCurrent() {
      int ncurrent = current;
      while (ncurrent ==current ) {
        ncurrent = (int)random(grupo.size());
      }
      current = ncurrent;
      Paco tmp = (Paco)grupo.get(current);
      if (!tmp.isDead)
        tmp.isCurrent = true;
      else
        setCurrent();
    }
    void update() {
      dx = tox - x;
      if (abs(dx)<1)tox = random(-50, 200);
      x += dx*friction;

      if (!attackFlag && random(100)>95) {
        attack();
      }
    }
    void attack() {
      Paco tmp = (Paco)grupo.get(current);
      tmp.attack();
      attackFlag = true;
    }

    class Paco {
      PImage[] skin;
      float x, tox, dx, friction;
      float y, toy, dy;
      boolean isDead;
      int direction = 1;
      int olddirection = 1;
      int pdirection = 1;
      boolean isCurrent = false;
      boolean isAttacking = false;
      int attackframe;
      boolean isGoneToHeaven;
      int life = 10;

      Paco(float x) {
        this.x = x;
        tox = x;
        dx = 0;
        friction = .96;
        skin = new PImage[3];
        skin[0] = loadImage("visuals/ahardplace/ffee.png");
        skin[1] = loadImage("visuals/ahardplace/ffee_2.png");
        skin[2] = loadImage("visuals/ahardplace/ffee.png");
      }
      void draw(PGraphics pg) {
        update();
        pg.pushMatrix();
        pg.translate(x, 0);
        pg.scale(.4);
        if ((olddirection==-1 && direction==0)||direction==-1) {
          pdirection=-1;
        }
        else if ((olddirection==1 && direction==0)||direction==1) {
          pdirection=1;
        }
        if (pdirection==-1)pg.rotateY(-PI);

        if (isCurrent) {
          pg.noTint();
          pg.noStroke();
          pg.fill(255);
          pg.triangle(0, -170, -20, -200, 20, -200);
          pg.pushMatrix();
          if (pdirection==-1)pg.rotateY(-PI);
          pg.text("P2", -32, -200);
          pg.popMatrix();
        }
        else {
          if (frameCount%3==0) {
            pg.tint(255, 0, 0);
          }
          else if (frameCount%3==1) {
            pg.tint(255);
          }
          else {
            pg.tint(0);
          }
        }

        PImage cskin;
        if (isCurrent) {
          if (attackframe>2) {
            if (frameCount%10<=5) {
              cskin = skin[1];
            }
            else {
              cskin = skin[0];
            }
          }
          else {
            cskin = skin[0];
          }
        }
        else {
          cskin = skin[0];
        }
        pg.translate(-cskin.width*.5, -cskin.height);
        pg.image(cskin, 0, 0);
        pg.popMatrix();
        olddirection = direction;
        pg.noTint();
      }
      void update() {
        if (!isAttacking) {
          if ((dx>=0 && x>=tox) || (dx<=0 && x<=tox)) {
            tox = random(-100, 100);
            if (tox>x) {
              dx=4;
              direction = 1;
            }
            else if (tox<x) {
              dx=-4;
              direction = -1;
            }
            else {
              dx=0;
              direction = 0;
            }
          }
          x += dx;
        }
        else {
          if (attackframe>6)x += dx;
          attackframe--;
          if (attackframe<=0)endAttack();
        }
      }
      void attack() {
        isAttacking = true;
        direction = -1;
        dx = -8;
        attackframe = 60;
      }
      void endAttack() {
        isCurrent = false;
        isAttacking = false;
        direction = 1;
        tox = 100;
        attackframe = 0;
        attackFlag = false;
      }
      void goneToHeaven() {
        isGoneToHeaven = true;
        isCurrent = false;
        isAttacking = false;
      }
      void damage() {
        life--;
        if (life<=0) {
          isDead = true;
          isCurrent = false;
          isAttacking = false;
        }
      }
    }
  }

  class Molotovs {
    ArrayList mismolotovs;
    Molotovs() {
      mismolotovs = new ArrayList();
    }
    void draw(PGraphics pg) {
      for (int i=0; i<mismolotovs.size(); i++) {
        Molotov tmp = (Molotov)mismolotovs.get(i);
        if (tmp.isDead) {
          mismolotovs.remove(i);
        }
        else {
          tmp.draw(pg);
        }
      }
    }
    void addMolotov(float x) {
      try {
        mismolotovs.add(new Molotov(x));
      }
      catch(Exception e) {
        println("fiuu");
      }
    }
    class Molotov {
      float x, y;
      float tox, toy, dx, dy, friction;
      PImage[] skin;
      boolean isDead, isXplode;
      int xplodelife;

      Molotov(float x) {
        this.x = x+encapuxaos.x;
        tox = this.x + 300;
        friction = .4;
        skin = new PImage[3];
        skin[0] = loadImage("visuals/ahardplace/molotov.png");
        skin[1] = loadImage("visuals/ahardplace/molotovxplode1.png");
        skin[2] = loadImage("visuals/ahardplace/molotovxplode2.png");
      }
      void draw(PGraphics pg) {
        pg.pushMatrix();
        pg.translate(400, 300+84);
        pg.translate(encapuxaos.xbase+encapuxaos.x, 0);
        pg.translate(x, y);
        pg.scale(.4);
        PImage cskin;
        if (!isXplode) {
          cskin = skin[0];
        }
        else {
          cskin = skin[1+frameCount%2];
        }
        pg.translate(-cskin.width*.5, -cskin.height);
        pg.image(cskin, 0, 0);
        pg.popMatrix();
        update();
      }
      void update() {
        dx = tox-x;
        dy = (1-dx/300)*20;
        x+= dx*friction;
        if (y<=24) {
          y+=dy;
        }
        else if (!isXplode) {
          xplode();
        }
        else {
          xplodelife--;
          if (xplodelife<=0)isDead = true;
        }
        //check collisions
        for (int i=0; i<pacos.grupo.size();i++) {
          Pacos.Paco tmp = (Pacos.Paco)pacos.grupo.get(i);
          float cx = pacos.x+tmp.x;
          if (x>=cx-40 && x<=cx+40) {
            xplode();
            //tmp.damage();
            break;
          }
        }
      }
      void xplode() {
        isXplode = true;
        xplodelife = 200;
      }
    }
  }
}

class Anemiko {
  int cycles;
  float rotation, faktor, ratio; 
  int frameaux = 0;

  String ticker;
  String txt = "";
  float txtslide = 0;

  color[] colors;

  Anemiko(color[] c) {//1, color c2, color c3){
    rotation = 0;
    cycles = 32;//zpectral.bufferSize;
    faktor = .8;
    ratio = width*.75;
    colors = c;/*new color[3];
     colors[0] = c1;
     colors[1] = c2;
     colors[2] = c3;*/
  }

  void draw(PGraphics pg) {
    pg.pushMatrix();
    //colorMode(RGB, 255);
    //background(0);
    //translate(width*.5, height*.8);
    pg.translate(width*.0, height*.3);

    pg.pushMatrix();
    pg.rotateZ(rotation);

    //float percent=0;//max(0,(zpectral.myFFT.max-zpectral.minLimit)/zpectral.limitDiff);
    pg.scale(6);//+percent/100);

    for (int i=0; i<cycles; i++) {
      int sign;
      if (i%2==0) {
        sign=1;
      }
      else {
        sign=-1;
      };

      for (int j=0; j<colors.length; j++) {
        if (i%colors.length==j) {
          for (int k=0; k<colors.length; k++) {
            if (frameaux%colors.length==k) {
              pg.fill(colors[j]);
              break;
            }
          }
          break;
        }
      }

      pg.noStroke();
      if (i>0 && i%3!=0) {
        pg.scale(faktor);
        pg.translate(0, sign*ratio*.25*.9);
      }
      else {
        pg.scale(faktor);//.95);
      }

      //float spc = 1;//+zpectral.myFFT.spectrum[i];
      float spc = 2;
      if (i%3==0) {
        spc-=stageManager.daSong.beatMap.kick.currentside/100;
      }
      else if (i%3==1) {
        spc-=stageManager.daSong.beatMap.snare.currentside/100;
      }
      else {
        spc-=stageManager.daSong.beatMap.hat.currentside/100;
      }
      pg.ellipse(0, 0, 2*ratio*spc, 2*ratio*spc);
    }
    rotation+=PI/30;

    pg.popMatrix();
    pg.popMatrix();
  }
}


class Emo {
  int w, h;
  float cellw, cellh;
  PImage[] zqnce;
  int frame = 0;

  Emo() {
    w = 100; 
    h = 50;
    cellw = 800/w;
    cellh = 600/h;
    zqnce = new PImage[28];
    for (int i=0; i<zqnce.length; i++) {
      zqnce[i]=loadImage("visuals/punkrocker/donfrancischavo_"+nf(i+1, 4)+".gif");
    }
  }  
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(-zqnce[0].width*cellw/2, -zqnce[0].height*cellh/2);
    pg.noStroke();
    pg.translate(cellw/2, cellh/2);
    zqnce[frame].loadPixels();
    for (int i=0; i<w; i++) {
      for (int j=0; j<h; j++) {
        int m = int((i+j*w)%random(50));
        //float spc = 0;//2*zpectral.myFFT.spectrum[m];//*PI;
        float spc = i<w/2 ? stageManager.daSong.beatMap.kick.currentside/100 : stageManager.daSong.beatMap.snare.currentside/100;
        color k = zqnce[frame].pixels[i+j*w];
        pg.pushMatrix();
        pg.translate(i*cellw, j*cellh);
        pg.scale(spc);
        dddot(k, pg);
        pg.popMatrix();
      }
    }
    pg.filter(POSTERIZE, 4);
    frame++;
    if (frame>zqnce.length-1)frame=0;
    pg.popMatrix();
  }
  void dddot(color k, PGraphics pg) {
    //k = 255;
    pg.fill(k);
    //pg.scale(.8); 
    ddot(pg);
    /*
    pg.fill(0);
     pg.scale(.6); 
     ddot(pg);
     pg.fill(k);
     pg.scale(.6); 
     ddot(pg);*/
  }
  void ddot(PGraphics pg) {
    pg.ellipse(0, 0, cellw, cellh);
  }
}






class Flag {
  PImage[] flags;
  PImage world;
  int total, kurrent;
  int w, h;
  int spacing;
  int f = 0;
  PFont myFont;
  String txt;
  float txtslide = 0;
  PFont font;

  Flag() {
    myFont = loadFont("CoyarzunAtarinormal-8.vlw");
    world = loadImage("visuals/antarctic/flag/world_bn.gif");

    total = 245;
    flags = new PImage[total];
    for (int i=0; i<total; i++) {
      String tmp = "";
      tmp+= i;
      if (i<10)tmp="0"+tmp;
      if (i<100)tmp="0"+tmp;
      tmp+="_48.gif";
      tmp = "visuals/antarctic/flag/"+tmp;
      flags[i] = loadImage(tmp);
    };
    kurrent = int(random(total));

    txt = "CON LA AUTORIDAD QUE NOS DA EL BUEN JUICIO Y EN PLENO USO DE NUESTRA RAZON, DECLARAMOS ROMPER EN FORMA OFICIAL LOS LAZOS QUE NOS PUDIERON ATAR ALGUNA VEZ A UNA SOLA INSTITUCION O FORMA DE REPRESENTACION QUE NOS DECLARE PARTE DE SU TOTAL.CON TODA HONESTIDAD Y CON LA MENTE FRIA RENEGAMOS DE CUALQUIER PATRON. YA TODAS LAS DIVISAS NOS DAN INDIFERENCIA, RENEGAMOS DEL CUALQUIER COLOR, SE LLAME RELIGION,SE LLAME NACIONALIDAD, NO QUEREMOS REPRESENTATIVIDAD.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.ES FACIL VEGETAR, DEJAR QUE OTROS HABLEN Y DECIR ELLOS SABEN MAS QUE YO. PONERSE UNA INSIGNIA,MARCHAR DETRAS DE UN LIDER Y DEJAR QUE NOS ESGRIMAN COMO RAZON.NO VAMOS A ESPERAR, LA IDEA NUNCA NOS GUSTO, ELLOS NO ESTAN HACIENDO LO QUE AL COMIENZO SE PACTO.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.";
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(-pg.width/2, -pg.height/2);
    pg.noStroke();
    pg.rectMode(CENTER);

    //pg.textFont(mono,8);

    if (random(100)>90)kurrent = int(random(total));
    w = flags[kurrent].width;
    h = flags[kurrent].height;
    int xspacing = pg.width/(w-4);
    int yspacing = pg.height/(h-4);

    txtslide++;

    for (int i=1; i<w-1; i++) {
      for (int j=1; j<h-1; j++) {
        pg.pushMatrix();
        int sz;
        pg.translate(-w*.5+(i)*xspacing, -h*.5+(j)*yspacing);
        sz = 2;

        color c = flags[kurrent].pixels[i+j*w];
        color k = world.pixels[i+j*w];

        if (k==-15132391) {
          pg.fill(c);
          sz*=1;
        }
        else {
          pg.fill(c, 64);
          sz*=.6;
        }
        int txtoff = int(txtslide)%flags[kurrent].pixels.length;
        int indec = (i+j*w+txtoff)%txt.length();
        String shar = txt.substring(indec, indec+1);
        pg.scale(sz);
        //pg.scale(pg.width/800,pg.height/600);
        pg.textFont(myFont, 8);//pg.textMode(MODEL);
        //println(shar);
        pg.text(shar, 2, 10);
        //        pg.fill(255);
        //        pg.noStroke();pg.ellipse(0,0,100,100);
        //pg.ellipse(0,0,8,8);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}


class Antarctic {
  PImage[] flags;
  PImage world;
  int total, kurrent;
  int w, h;
  int spacing;
  PFont myFont;
  String txt;
  float txtslide = 0;


  Antarctic() {
    myFont = loadFont("CoyarzunAtarinormal-8.vlw");
    world = loadImage("visuals/antarctic/flag/world_bn.gif");
    total = 245;
    flags = new PImage[total];
    for (int i=0; i<total; i++) {
      String tmp = "";
      tmp+= i;
      if (i<10)tmp="0"+tmp;
      if (i<100)tmp="0"+tmp;
      tmp+="_48.gif";
      tmp = "visuals/antarctic/flag/"+tmp;
      flags[i] = loadImage(tmp);
    };
    kurrent = int(random(total));

    txt = "CON LA AUTORIDAD QUE NOS DA EL BUEN JUICIO Y EN PLENO USO DE NUESTRA RAZON, DECLARAMOS ROMPER EN FORMA OFICIAL LOS LAZOS QUE NOS PUDIERON ATAR ALGUNA VEZ A UNA SOLA INSTITUCION O FORMA DE REPRESENTACION QUE NOS DECLARE PARTE DE SU TOTAL.CON TODA HONESTIDAD Y CON LA MENTE FRIA RENEGAMOS DE CUALQUIER PATRON. YA TODAS LAS DIVISAS NOS DAN INDIFERENCIA, RENEGAMOS DEL CUALQUIER COLOR, SE LLAME RELIGION,SE LLAME NACIONALIDAD, NO QUEREMOS REPRESENTATIVIDAD.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.ES FACIL VEGETAR, DEJAR QUE OTROS HABLEN Y DECIR ELLOS SABEN MAS QUE YO. PONERSE UNA INSIGNIA,MARCHAR DETRAS DE UN LIDER Y DEJAR QUE NOS ESGRIMAN COMO RAZON.NO VAMOS A ESPERAR, LA IDEA NUNCA NOS GUSTO, ELLOS NO ESTAN HACIENDO LO QUE AL COMIENZO SE PACTO.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.";
  }

  void draw(PGraphics pg) {
    if (random(100)>90)kurrent = int(random(total));
    w = flags[kurrent].width;
    h = flags[kurrent].height;
    int xspacing = pg.width/(w-4);
    int yspacing = pg.height/(h-4);
    float percent=1;

    pg.pushMatrix();
    //pg.translate(-pg.width/2,-pg.height/2);
    pg.noStroke();
    pg.rectMode(CENTER);

    pg.rotateX(-8*PI/90);
    pg.rotateZ(8*PI/90);
    pg.rotateY(-2*(PI/180)*(frameCount));
    pg.scale(1+.2*percent);

    txtslide++;

    for (int i=1; i<w-1; i++) {
      for (int j=1; j<h-1; j++) {
        pg.pushMatrix();
        int sz;

        float f = TWO_PI/(w-2);
        float ff = PI/(h-1);
        pg.rotateY(i*f);
        pg.rotateZ(j*ff-HALF_PI);
        pg.translate(w*.2*xspacing, 0);
        pg.rotateY(HALF_PI);
        sz = 1;

        color c = flags[kurrent].pixels[i+j*w];
        color k = world.pixels[i+j*w];

        if (k==-15132391) {
          pg.fill(c);
          sz*=1;
        }
        else {
          pg.fill(c, 64);
          sz*=.6;
        }
        int txtoff = int(txtslide)%flags[kurrent].pixels.length;
        int indec = (i+j*w+txtoff)%txt.length();
        String shar = txt.substring(indec, indec+1);

        pg.scale(sz);
        pg.scale(pg.width/800, pg.height/600);
        //pg.textFont(mono,100);
        //println(shar);
        //pg.text(shar, 2, 10);
        //pg.fill(255);
        //pg.noStroke();pg.ellipse(0,0,100,100);
        pg.ellipse(0, 0, 8, 8);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}

class WOklr {

  WOklr() {
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();

    pg.rotateX(-8*PI/90);
    pg.rotateZ(8*PI/90);
    pg.rotateY(-2*(PI/180)*(frameCount));
    pg.scale(1+.2*1);


    pg.pushMatrix();
    float r = height*.6, amp=PI/90;
    float dangle = TWO_PI/64;
    for (int i=0;i<64;i++) {//zpectral.bufferSize;i++){
      pg.pushMatrix();
      float left=0;
      float right=0;
      //if (i+zpectral.wave_interp+1<zpectral.myInput.buffer2.length) {
      left-=random(-.2, .2);//zpectral.myInput.buffer2[i+zpectral.wave_interp];
      right-=random(-.2, .2);//zpectral.myInput.buffer2[i+1+zpectral.wave_interp];
      //}
      pg.rotateY(i*dangle);
      pg.rotateZ(left*amp);
      pg.translate(r, 0, 0);
      //stroke(255, 96, 0);
      pg.stroke(0, 0, 0);
      pg.fill(255);
      pg.box(2);
      pg.popMatrix();
      //
      pg.pushMatrix();
      float spc = random(PI/10);//zpectral.myFFT.spectrum[i]*PI;
      //rotateX(-ang*2);
      pg.rotateY(i*dangle*.5);
      pg.stroke(i*255/64, 255, 204);
      pg.noFill();
      float w = 2*r*.6;
      float h = 2*r*.6;
      float fa = (TWO_PI-spc)*.5;
      float ta = fa+spc;
      pg.strokeWeight(1);//.5);
      pg.arc(0, 0, w, h, fa, ta);
      pg.rotateY(TWO_PI-(i)*dangle);
      pg.arc(0, 0, w, h, fa, ta);
      pg.popMatrix();
      //
      pg.fill(128);
      //box(30);
    }  
    pg.popMatrix();
    pg.popMatrix();
  }
}

class Lnr {

  Lnr() {
  }
  void draw(PGraphics pg) {

    pg.pushMatrix();
    pg.translate(-pg.width*.5, -pg.height*.5);
    pg.pushMatrix();
    float r = pg.height*.6, amp=PI;
    float dangle = TWO_PI/64;
    float xpc = pg.width/64;
    float ii = random(pg.width);
    float jj = random(pg.height);

    for (int i=0;i<64;i++) {
      pg.pushMatrix();
      float spc = random(1);//i/64;//(i+1)/64;//i/64;//i/100;
      pg.stroke(spc*255, 255, 255, random(255));
      pg.noFill();
      float w = 2*r*.6;
      float h = 2*r*.6;
      float fa = (TWO_PI-spc)*.5;
      float ta = fa+spc;
      pg.strokeWeight(1);
      pg.translate(ii, jj, 0);
      pg.ellipse(0, 0, w*spc, h*spc);
      pg.popMatrix();
      pg.fill(128);
    }  
    pg.popMatrix();
    pg.popMatrix();
  }
}

class AntarcticLogo {
  PImage splash;

  AntarcticLogo() {
    splash = loadImage("visuals/antarctic/flag/antarctic_flagx.jpg");
  }
  void draw(PGraphics pg) {

    pg.pushMatrix();
    pg.translate(-splash.width*.5, -splash.height*.5);
    pg.scale(pg.width/splash.width, pg.height/splash.height);
    pg.image(splash, 0, 0);
    pg.popMatrix();
  }
}

class TScreen {
  String mytext;
  int cols, rows;
  int cell = 8*1;
  int vel = 16;
  color[] colors;

  TScreen(color[] c) {
    cols = 800/cell;
    rows = 600/cell;
    colors = c;
  }
  void setCell(int k) {
    cell = k;
    cols = 800/cell;
    rows = 600/cell;
  }
  void setText(String t) {
    mytext=t;
  }
  void setVel(int v) {
    vel = v;
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(-pg.width/2, -pg.height/2);
    for (int i=0; i<cols;i++) {
      for (int j=0; j<rows; j++) {
        int k = i+j*cols;

        //pg.fill(colors[k%colors.length]);

        k+=frameCount*(j+rows/4)/vel;//+j;
        int l = mytext.length()-1;
        String tmp = l>1? mytext.substring(k%l, k%l+1) : "";

        pg.fill(colors[k%colors.length]);

        pg.pushMatrix();
        pg.translate(i*cell, j*cell+cell);
        pg.scale(cell/8);
        //
        pg.textFont(stageManager.font, 8);
        pg.text(tmp, 0, 0);//i*8,j*8+8);
        //pg.ellipse(0,-4,8,8);pg.fill(0);pg.ellipse(0,-4,4,4);

        //      pg.rotate(radians(45));
        //      pg.rectMode(CENTER);
        //      pg.rect(0,-8,8*1.41/2,8*1.41/2);
        //      pg.fill(0);
        //      pg.rect(0,-8,8*0.4,8*.4);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}






class Alebrije {
  float x, y, z;
  float caminangulo;

  PImage[] t;
  int tframes;

  Head head;

  Alebrije(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;

    head = new Head();

    tframes = 18;
    t = new PImage[tframes];
    for (int i=0; i<tframes;i++) {
      t[i] = loadImage("visuals/songzero/twinkling/twinkling_100_f"+nf(i+1, 2)+".gif");
    }
  }
  void draw(PGraphics pg) {
    PImage current = t[frameCount%tframes];
    pg.pushMatrix();
    //pg.translate(x,y,z);
    //pg.ambientLight(51, 102, 126);
    //pg.spotLight(255, 128, 0, 80, 20, 40, -1, 0, 0, PI/2, 2);
    //pg.directionalLight(51, 102, 126, 0, -1, 0);
    //pg.pointLight(255/2, 200/2, 30/2, 0, -500, 1000);
    //pg.stroke(32,255,255);//255,128,0);
    //
    //pg.noStroke();
    pg.ambientLight(16, 255, 64);//128, 64, 0);
    pg.spotLight(16, 255, 128, 80, 20, 40, -1, 0, 0, PI/2, 2);//255, 128, 0, 80, 20, 40, -1, 0, 0, PI/2, 2);
    //directionalLight(51, 102, 126, 0, -1, 0);
    pg.pointLight(96/2, 255/2, 240, 0, -500, 1000);//255/2, 200/2, 30/2, 0, -500, 1000);
    //if(random(100)>70);pointLight(240+random(15), 0,0, 0, 0, 2000);
    pg.stroke(16, 255, 255);//255,128,0);
    float f = 9;//4;
    //caminangulo = radians(60*sin(radians(f*frameCount%360)));
    //float eleva = 20*sin(radians(f*frameCount%360));
    caminangulo = radians(90*sin(radians(f*frameCount%360)));
    float eleva = 40*sin(radians(f*frameCount%360));

    pg.fill(255);
    pg.pushMatrix();
    pg.translate(0, 20-abs(eleva), 0);
    //torso
    textureBox(pg, current, 30, 40, 10);
    //right napier
    pg.pushMatrix();
    pg.translate(10, 20, 0);
    pg.rotateX(caminangulo);
    pg.translate(0, 10, 0);
    textureBox(pg, current, 10, 20, 10);
    pg.popMatrix();
    //left napier
    pg.pushMatrix();
    pg.translate(-10, 20, 0);
    pg.rotateX(-caminangulo);
    pg.translate(0, 10, 0);
    textureBox(pg, current, 10, 20, 10);
    pg.popMatrix();


    //middle leg
    pg.pushMatrix();
    float erektangulo = radians(145);
    float dotation = 20;//6;//15;//6;//15;//20;
    float contrapeso = dotation/5;
    float grip = 6;//3;//4;//6; 
    pg.translate(0, 20, 5);

    pg.pushMatrix();
    pg.rotateX(erektangulo);
    //if(erektangulo<PI/2)
    pg.rotateX(map(erektangulo, radians(15), radians(145), 1, 0)*abs(caminangulo));
    pg.translate(0, (dotation+contrapeso)/2-contrapeso, -grip/2);
    textureBox(pg, current, grip, dotation+contrapeso, grip);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(-2.5, 2.25, -2.5);
    pg.rotateX(caminangulo);
    textureBox(pg, current, 4.5);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(2.5, 2.25, -2.5);
    pg.rotateX(-caminangulo);
    textureBox(pg, current, 4.5);
    pg.popMatrix();
    pg.popMatrix();
    //right arm
    pg.pushMatrix();
    pg.translate(20, -20, 0);
    pg.rotateX(-caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0, 25, 0);
    textureBox(pg, current, 10, 50, 10);
    pg.popMatrix();
    //left arm
    pg.pushMatrix();
    pg.translate(-20, -20, 0);
    pg.rotateX(caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0, 25, 0);
    textureBox(pg, current, 10, 50, 10);
    pg.popMatrix();
    //kabeza

    pg.pushMatrix();
    pg.translate(0, -20-5, 5);
    //pg.rotateX(caminangulo/4);
    head.draw(pg);

    pg.popMatrix();
    pg.popMatrix();
    pg.popMatrix();
  }



  void textureBox(PGraphics pg, PImage $1, float $2) {
    //textureBox(pg, $1, $2, $2, $2);
    pg.box($2);
  }
  void textureBox(PGraphics pg, PImage $1, float $2, float $3, float $4) {
    pg.box($2, $3, $4);
  }
  void textureBox(PGraphics pg, PImage $1, float $2, float $3, float $4, boolean $5) {
    float xratio, yratio, zratio;
    xratio = $2*.5;
    yratio = $3*.5;
    zratio = $4*.5;
    //front face
    pg.pushMatrix();
    pg.translate(-$2*.5, -$3*.5, zratio);
    pg.image($1, 0, 0, $2, $3);
    pg.popMatrix();
    //top face
    pg.pushMatrix();
    pg.rotateX(HALF_PI);
    pg.translate(-$2*.5, -$4*.5, yratio);
    pg.image($1, 0, 0, $2, $4);
    pg.popMatrix();
    //rear face
    pg.pushMatrix();
    pg.rotateX(PI);
    pg.translate(-$2*.5, -$3*.5, zratio);
    pg.image($1, 0, 0, $2, $3);
    pg.popMatrix();
    //bottom face
    pg.pushMatrix();
    pg.rotateX(-HALF_PI);
    pg.translate(-$2*.5, -$4*.5, yratio);
    pg.image($1, 0, 0, $2, $4);
    pg.popMatrix();
    //left face
    pg.pushMatrix();
    pg.rotateY(-HALF_PI);
    pg.translate(-$4*.5, -$3*.5, xratio);
    pg.image($1, 0, 0, $4, $3);
    pg.popMatrix();
    //right face
    pg.pushMatrix();
    pg.rotateY(HALF_PI);
    pg.translate(-$4*.5, -$3*.5, xratio);
    pg.image($1, 0, 0, $4, $3);
    pg.popMatrix();
  }
}


class Head {
  Head() {
  }
  void draw(PGraphics pg) {
    float anchodehociko = 16;
    float salidadeojos = 4+10*stageManager.daSong.beatMap.snare.currentside/100;//*abs(in.left.get(0));
    float aperturadehociko = 3+10*stageManager.daSong.beatMap.kick.currentside/100;//*abs(in.left.get(0));

    pg.pushMatrix();
    //kabeza
    pg.pushMatrix();
    pg.translate(0, -15, -5);
    //rotateY(caminangulo/4);
    pg.fill(255);
    pg.box(20, 30, 30);//,30,20);


    pg.pushMatrix();//alerones
    pg.translate(0, 5, 0);
    pg.box(30, 10, 20);//,30,20);
    pg.box(50, 4, 15);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(0, 10, 12+5);
    //pointLight(200, 0, 30, 5, -5, 0);
    pg.pushMatrix();
    pg.translate(0, -17, -1);
    corolla(pg, 12);
    pg.popMatrix();

    pg.pushMatrix();//kresta
    pg.translate(0, -26, -4);
    pg.box(2, 6, 10);
    pg.translate(0, 0, -14);
    pg.box(2, 10, 14);
    pg.translate(0, 3+2, -14);
    pg.box(2, 16, 10);
    pg.popMatrix();

    float cachangulo = -radians(30);
    pg.pushMatrix();//kachos
    pg.translate(-10, -26, -2);
    pg.rotateZ(cachangulo);
    pg.rotateX(cachangulo);
    pg.box(6, 12, 6);
    pg.box(4, 24, 4);
    pg.box(2, 50, 2);
    pg.popMatrix();
    pg.pushMatrix();//kachos
    pg.translate(10, -26, -2);
    pg.rotateZ(-cachangulo);
    pg.rotateX(cachangulo);
    pg.box(6, 12, 6);
    pg.box(4, 24, 4);
    pg.box(2, 50, 2);
    pg.popMatrix();
    pg.pushMatrix();//kachos
    pg.translate(-10, -26, -2-30);
    pg.rotateZ(cachangulo);
    pg.rotateX(-cachangulo);
    pg.box(6, 12, 6);
    pg.box(4, 24, 4);
    pg.box(2, 50, 2);
    pg.popMatrix();
    pg.pushMatrix();//kachos
    pg.translate(10, -26, -2-30);
    pg.rotateZ(-cachangulo);
    pg.rotateX(-cachangulo);
    pg.box(6, 12, 6);
    pg.box(4, 24, 4);
    pg.box(2, 50, 2);
    pg.popMatrix();

    pg.fill(0, 255, 255);//255,0,0);
    pg.pushMatrix();
    pg.translate(5, -5, 0);
    pg.box(5, 5, salidadeojos);
    pg.rotateZ(radians(45));
    pg.box(5, 5, salidadeojos);
    pg.popMatrix();
    pg.pushMatrix();
    pg.translate(-5, -5, 0);
    pg.box(5, 5, salidadeojos);
    pg.rotateZ(radians(45));
    pg.box(5, 5, salidadeojos);
    pg.popMatrix();

    pg.popMatrix();

    pg.popMatrix();

    pg.pushMatrix();
    pg.fill(255);

    pg.stroke(32, 255, 255);//255,128,0);

    pg.translate(0, 4, 3);
    pg.translate(-anchodehociko/2+1, -3, 6);
    for (int i=0; i<10; i++) {
      pg.box(1.5, 2, 1);
      pg.translate(anchodehociko/10, 0, 0);
    }
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(0, 2.5, 2.5);//-5);

    pg.translate(0, aperturadehociko, 0);
    pg.fill(255);
    pg.box(anchodehociko, 5, 15);

    pg.pushMatrix();
    pg.translate(-anchodehociko/2+1, -3, 6);
    for (int i=0; i<10; i++) {
      pg.box(1.5, 2, 1);
      pg.translate(anchodehociko/10, 0, 0);
    }
    pg.popMatrix();

    pg.pushMatrix();//
    pg.translate(anchodehociko/2-2.5, -aperturadehociko/2-2.5, -2.5);
    pg.box(5, aperturadehociko, 10);
    pg.popMatrix();
    pg.pushMatrix();//
    pg.translate(-anchodehociko/2+2.5, -aperturadehociko/2-2.5, -2.5);
    pg.box(5, aperturadehociko, 10);
    //box(
    pg.popMatrix();

    pg.popMatrix();

    pg.popMatrix();
  }

  void corolla(PGraphics pg, float diam) {
    pg.pushMatrix();
    pg.pushStyle();
    pg.rotateZ(radians(2*frameCount%360));
    pg.noStroke();
    pg.fill(0, 255, 255);
    pg.ellipse(0, 0, diam, diam);
    pg.translate(diam/6, 0, .01);
    diam*=.6;
    pg.fill(255);
    pg.ellipse(0, 0, diam, diam);
    pg.translate(-diam/6, 0, .01);
    diam*=.6;
    pg.fill(0);
    pg.ellipse(0, 0, diam, diam);
    pg.translate(diam/6, 0, .01);
    diam*=.6;
    pg.fill(0, 255, 255);//,0,0);
    pg.ellipse(0, 0, diam, diam);
    pg.popStyle();
    pg.popMatrix();
  }
}





























class GFlag {
  PImage[] flags;
  int total, kurrent;
  int w, h;
  int spacing;
  int f = 0;
  PFont myFont;
  String txt;
  float txtslide = 0;
  color[] colors;// = new color[3];

  GFlag() {
    myFont = loadFont("CoyarzunAtarinormal-32.vlw");

    total = 5;
    flags = new PImage[total];
    for (int i=0; i<total; i++) {
      String tmp = "";
      tmp+= i;
      if (i<10)tmp="0"+tmp;
      if (i<100)tmp="0"+tmp;
      tmp+=".png";
      tmp = "visuals/ahardplace/gflag/"+tmp;
      flags[i] = loadImage(tmp);
    };
    kurrent = int(random(total));

    txt = "NO ES COMODO ESTE LUGAR; TIENDO A PENSAR Q ESTA REUNION ES ANACRONICA O Q MI MIRADA SOBRE ELLA LO ES; MI MIRADA SIN DUDA LO ES; GGGGTTTT; DE LO Q HABIA Q SAKAR LECCIONES NO SE HA SACADO NADA; GGGGTTTT; LA PALABRA CIUDADANIA LAMENTABLEMENTE SE WELVE UNA FIGURA INSTITUCIONAL; CIUDADANOS SOMOS AQUELLOS QUE MANIFESTAMOS NUESTRA VOLUNTAD EN UN SISTEMA POLITICO ESTABLECIDO Y NO REPRESENTATIVO; CIUDADANOS SON LOS BUENOS CIUDADANOS, AQUELLOS QUE RESPETAN EL ORDEN PUBLICO, PAGAN SUS IMPUESTOS, TRABAJAN PARA EL PAIS; SIN EMBARGO LA MAYORIA DE LOS CIUDADANOS TIENE UNA VIDA HECHA MIERDA; EN UNA CIUDAD QUE SE HA INTENTADO RACIONALIZAR SIN PROFUNDIZAR EN SU ESTRUCTURA; EL CRITERIO TECNICO PRIMARA EN TODO, EN ADELANTE, X SIEMPRE; GGGGTTTT; LA VIDA CIVIL NO EXISTE MAS; SOMOS CONSUMIDORES; O EXCLUIDOS; EL PODER POLITICO ES SOLO UNA FACHADA DE INTERESES ECONOMICOS; CONOCEMOS REALMENTE EL ROL QUE ESPERAMOS TENER EN EL PROCESO DE GLOBALIZACION? PUEDE TORCERSE EL SIGNO DE ESTOS PROCESOS? TENEMOS ALGUNA CAPACIDAD DE REACCION E INTEGRACION?; GGGGTTTT; BUSKAMOS EN UNA DIRECCION EKIVOKADA; ESTOY CANSADO Y NO KIERO ARGUMENTOS; PREFIERO TEJER CHALECOS CON ANCIANOS QUE CORRER DETRAS DE LO NUEVO; Q ESCALAR LUGARES Y PEGAR CODAZOS; GGGGTTTT; VOY A TOMAR SUS CUERPOS Y VACIARLOS, CONVERTIR SUS GEOMETRIAS EN UN MUNDO EN ROJO, NEGRO Y BLANCO; EN ESTE OTRO RITUAL VACIADO DE PRENDER FUEGO A TU NOMBRE;";

    colors = new color[3];
    colors[0] = color(0, 255, 255);
    colors[1] = color(0);
    colors[2] = color(255);
  }
  void draw(PGraphics pg) {

    pg.pushMatrix();
    pg.background(colors[stageManager.daSong.frame%colors.length]);
    pg.translate(-pg.width/2, -pg.height/2);
    pg.noStroke();
    pg.rectMode(CENTER);

    //pg.textFont(myFont,8);

    //if(random(100)>90)
    if (stageManager.daSong.beatMap.snare.currentside>90) {
      int prev = kurrent;
      while (kurrent==prev) {
        kurrent = int(random(total));
      }
    }
    w = flags[kurrent].width;
    h = flags[kurrent].height;
    int xspacing = pg.width/(w-4);
    int yspacing = pg.height/(h-4);

    txtslide++;

    for (int i=1; i<w-1; i++) {
      for (int j=1; j<h-1; j++) {
        pg.pushMatrix();
        int sz;
        pg.translate(-w*.5+(i)*xspacing, -h*.5+(j)*yspacing);
        sz = 2;

        color c = flags[kurrent].pixels[i+j*w];

        pg.fill(c);
        sz*=1;

        int txtoff = int(txtslide)%flags[kurrent].pixels.length;
        int indec = (i+j*w+txtoff)%txt.length();
        String shar = txt.substring(indec, indec+1);
        pg.scale(sz);
        //pg.scale(pg.width/800,pg.height/600);
        pg.textFont(myFont, 8);
        pg.text(shar, 2, 10);
        //pg.ellipse(0,-4,8,8);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}






class SapoLivingstone {
  PImage sapo;

  SapoLivingstone() {
    sapo = loadImage("visuals/silverstein/sapolivingstone.gif");
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(-sapo.width/2, -sapo.height/2);
    pg.image(sapo, 0, 0);
    pg.popMatrix();
  }
}


class VLostmanSuperstar extends VScreen {
  color bgcolor;

  FlyingCamera flyer;
  World        daworld;
  Esfera       landscape;

  Flock flock;

  VLostmanSuperstar(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    Ani.init(p);

    flyer     = new FlyingCamera();
    daworld   = new World(64000);

    flock = new Flock();
    // Add an initial set of boids into the system
    for (int i = 0; i < 200; i++) {
      flock.addBoid(new Boid(new PVector(0, 0), 300, 0.05*.4, daworld.lim));
    }
  }
  void unkontrol() {
    if (frameCount%100==0 || random(100)>90) {
      int key = int(random(0, 9));
      if (key==1)flyer.lookdown();
      if (key==2)flyer.lookfront();
      if (key==3)flyer.lookup();
      if (key==4)flyer.turnleft();
      if (key==5)flyer.turnright();
      if (key==6)flyer.turnback(1);
      if (key==7)flyer.turnaround(1);
      if (key==8)flyer.walkto(-daworld.lim);
      if (key==9)flyer.walkto(0);
      if (key==0)flyer.walkto(daworld.lim*1.5);
    }
  }

  void draw(PGraphics pg) {
    unkontrol();
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//16,255,255*stageManager.daSong.beatMap.kick.currentside/100);//,bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    daworld.draw(pg);
    flock.run(pg);
    flyer.update();
    flyer.draw(pg);
    pg.endDraw();
  }

  class World {
    PVector[] rocks;
    float lim;

    World(float l) {
      lim = l;
      init();
    }
    void init() {
      rocks    = new PVector[6000];
      for (int i=0; i<rocks.length; i++) {
        //rocks[i] = new PVector(random(-lim,lim), random(-lim,lim), random(-lim,lim));
        rocks[i] = new PVector(random(TWO_PI), random(-PI, PI), random(lim));//long,lat,radius
      }
    }
    void draw(PGraphics pg) {
      int poliphony = 8;
      for (int i=0; i<rocks.length; i++) {
        pg.pushMatrix();
        //translate(rocks[i].x,rocks[i].y,rocks[i].z);
        float a = map(rocks[i].z, 0, lim, radians(8), radians(0.1));
        a*=a;
        rocks[i].x+=a;
        rocks[i].y+=a;
        pg.rotateY(rocks[i].x);
        pg.rotateX(rocks[i].y);
        pg.translate(0, 0, rocks[i].z);


        float distcam = dist(flyer.x, flyer.y, flyer.z-100, pg.modelX(0, 0, 0), pg.modelY(0, 0, 0), pg.modelZ(0, 0, 0));
        color cc = color(map(rocks[i].z, 0, lim, 0, 255), 255, 255);
        if (random(100)>99.5 && poliphony>0) {
          int nn = int(map(rocks[i].z, 0, daworld.lim, 0, 127));
          nn = constrain(nn, 0, 127);
          pg.scale(10);
          pg.fill(cc, 64);
          pg.noStroke();
          pg.box(20);
          pg.scale(.5);
          pg.fill(cc, 64);
          pg.noStroke();
          pg.box(20);

          poliphony--;
        }
        else {
          pg.fill(cc, 200);
          pg.stroke(cc);
          pg.box(20);
        }
        pg.popMatrix();
      }
    }
  }
}

class Esfera {
  float radio;
  PImage t;

  Esfera (float r, String nombre) {
    radio = r;
    t= loadImage(nombre);
  }
  void draw(PGraphics pg) {
    pg.textureMode(NORMAL);
    int pasosH = 56;//horizontales
    int pasosV = 38;//paralelos
    float dangulo1 = TWO_PI/pasosH;
    float dangulo2 = PI/pasosV;
    pg.noStroke();
    pg.beginShape(QUADS);
    pg.texture(t);
    for (int i=0; i<pasosH;i++) {
      float angulo1 = i*dangulo1; 
      float angulo3 = (i+1)*dangulo1;      
      for (int j=0; j<pasosV;j++) {
        //fill(random(255),random(255),random(255));
        float angulo2 = j*dangulo2;
        float angulo4 = (j+1)*dangulo2; //angulo2 es la latitud
        float r = radio*sin(angulo2);
        float rr = radio*sin(angulo4);

        float tx, ty;
        float x = r*cos(angulo1);
        float y = radio*cos(angulo2);
        float z = r*sin(angulo1);
        tx=map(angulo1, 0, TWO_PI, 1, 0);
        ty=map(angulo2, 0, PI, 1, 0);
        pg.vertex(x, y, z, tx, ty);

        x = r*cos(angulo3);
        y = radio*cos(angulo2);
        z = r*sin(angulo3);
        tx=map(angulo3, 0, TWO_PI, 1, 0);
        ty=map(angulo2, 0, PI, 1, 0);
        pg.vertex(x, y, z, tx, ty);

        x = rr*cos(angulo3);
        y = radio*cos(angulo4);
        z = rr*sin(angulo3);       
        tx=map(angulo3, 0, TWO_PI, 1, 0);
        ty=map(angulo4, 0, PI, 1, 0);
        pg.vertex(x, y, z, tx, ty);

        x = rr*cos(angulo1);
        y = radio*cos(angulo4);
        z = rr*sin(angulo1);
        tx=map(angulo1, 0, TWO_PI, 1, 0);
        ty=map(angulo4, 0, PI, 1, 0);
        pg.vertex(x, y, z, tx, ty);
      }
    }

    pg.endShape();
  }
}



// The Flock (a list of Boid objects)

class Flock {
  ArrayList boids; // An arraylist for all the boids

    Flock() {
    boids = new ArrayList(); // Initialize the arraylist
  }

  void run(PGraphics pg) {
    pg.pushMatrix();
    pg.rotateX(PI/2);
    for (int i = 0; i < boids.size(); i++) {
      pg.pushMatrix();
      Boid b = (Boid) boids.get(i);  
      pg.rotateY(map(i, 0, boids.size(), 0, PI));   
      color k = color(map(i, 0, boids.size(), 0, 255), 64, 255);
      pg.stroke(k);
      pg.fill(k, 32);//random(255),255,255);//,100);

      b.run(boids, pg);
      // Passing the entire list of boids to each boid individually
      pg.popMatrix();
    }
    pg.popMatrix();
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}



// The Boid class

class Boid {

  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float daworldlim;

  Boid(PVector l, float ms, float mf, float dwl) {
    daworldlim = dwl;
    acc = new PVector(0, 0);
    vel = new PVector(random(-300, 300), random(-300, 300));
    loc = l.get();
    r = 200;
    maxspeed = ms;
    maxforce = mf;
  }

  void run(ArrayList boids, PGraphics pg) {
    flock(boids);
    update();
    borders();
    render(pg);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    acc.add(sep);
    acc.add(ali);
    acc.add(coh);
  }

  // Method to update location
  void update() {
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);
    loc.add(vel);
    // Reset accelertion to 0 each cycle
    acc.mult(0);
  }

  void seek(PVector target) {
    acc.add(steer(target, false));
  }

  void arrive(PVector target) {
    acc.add(steer(target, true));
  }

  // A method that calculates a steering vector towards a target
  // Takes a second argument, if true, it slows down as it approaches the target
  PVector steer(PVector target, boolean slowdown) {
    PVector steer;  // The steering vector
    PVector desired = target.sub(target, loc);  // A vector pointing from the location to the target
    float d = desired.mag(); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (d > 0) {
      // Normalize desired
      desired.normalize();
      // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
      if ((slowdown) && (d < 100.0)) desired.mult(maxspeed*(d/100.0)); // This damping is somewhat arbitrary
      else desired.mult(maxspeed);
      // Steering = Desired minus Velocity
      steer = target.sub(desired, vel);
      steer.limit(maxforce);  // Limit to maximum steering force
    } 
    else {
      steer = new PVector(0, 0);
    }
    return steer;
  }

  void render(PGraphics pg) {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading2D() + PI/2;
    //stroke(255);
    //noStroke();
    pg.pushMatrix();
    pg.translate(loc.x, loc.y);
    pg.rotate(theta);

    /*
    beginShape(TRIANGLES);
     vertex(0, -r*2);
     vertex(-r, r*2);
     vertex(r, r*2);
     endShape();*/
    pg.box(r*.2, 2*r, r*.2);
    pg.popMatrix();
  }
  // Wraparound
  void borders() {
    /*
    if (loc.x < -r-daworld.lim){
     loc.x = 2*daworld.lim+r;
     }
     if (loc.y < -r-daworld.lim){
     loc.y = 2*daworld.lim+r;
     }
     if (loc.x > daworld.lim+r){
     loc.x = -r-2*daworld.lim;
     }
     if (loc.y > daworld.lim+r){
     loc.y = -r-2*daworld.lim;
     }
     */
    if (dist(0, 0, loc.x, loc.y)>daworldlim) {
      loc.x*=-1;
      loc.y*=-1;
      int nn = int(map(loc.y, -daworldlim, daworldlim, 35, 35+6));
      nn = constrain(nn, 35, 35+36);
      //drums.sendNote(new Note(nn, (int)random(100,127), 1));
    }
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList boids) {
    float desiredseparation = 20.0;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = PVector.dist(loc, other.loc);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(loc, other.loc);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList boids) {
    float neighbordist = 25.0;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = PVector.dist(loc, other.loc);
      if ((d > 0) && (d < neighbordist)) {
        steer.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList boids) {
    float neighbordist = 25.0;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = loc.dist(other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.loc); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return steer(sum, false);  // Steer towards the location
    }
    return sum;
  }
}


//





class FlyingCamera {
  float x, y, z;

  float roll, yaw, pitch;
  float lspeed;

  float dx, dy, dz;
  float droll, dyaw, dpitch;

  FlyingCamera() {
    init();
  }
  void init() {
    x=0; 
    y=0; 
    z=0;

    roll = 0; 
    yaw = 0; 
    pitch =0 ;

    droll  = //radians(.20);
    dyaw   = //radians(.20);//.2);
    dpitch = 0;//radians(-.80);//-.20);//-.2);//-1);
  }
  void update() {
    //yaw%=TWO_PI;
  }
  void draw(PGraphics pg) {
    pg.beginCamera();
    pg.camera();
    pg.pushMatrix();
    pg.translate(x, y, z);
    pg.rotateY(yaw);
    pg.rotateZ(roll);
    pg.rotateX(pitch);
    pg.popMatrix();
    pg.endCamera();
  } 

  /*behaviours*/

  void lookdown() {
    Ani.to(this, 30, "pitch", PI/2, Ani.CIRC_OUT);
  }
  void lookup() {
    Ani.to(this, 30, "pitch", -PI/2, Ani.CIRC_OUT);
  }
  void lookfront() {
    Ani.to(this, 30, "pitch", 0, Ani.CIRC_OUT);
  }
  void turnleft() {
    Ani.to(this, 30, "yaw", yaw-PI/2, Ani.CIRC_OUT);
  }
  void turnright() {
    Ani.to(this, 30, "yaw", yaw+PI/2, Ani.CIRC_OUT);
  }
  void turnaround(int sign) {
    Ani.to(this, 40, "yaw", yaw+sign*TWO_PI, Ani.CIRC_OUT);
  }
  void turnback(int sign) {
    Ani.to(this, 30, "yaw", yaw+sign*PI, Ani.CIRC_OUT);
  }
  void walkto(float limite) {
    Ani.to(this, 180, "y", limite, Ani.LINEAR);//EXPO_IN_OUT);
  }
}
class BlobWorld {
  float ratio;
  int _width, _height;
  Blob[] blobs;

  BlobWorld(String url) {
    XML xml = loadXML(url);//new XML(p, url);
    _width  = xml.getInt("width"); 
    _height = xml.getInt("height");
    ratio = float(_width)/TWO_PI;
    blobs   = new Blob[xml.getChild(0).getChildCount()];
    for (int i=0; i<blobs.length; i++) {
      blobs[i]=new Blob(xml.getChild(0).getChild(i));
    }
  }
  void draw(PGraphics pg) {
    for (int i=0; i<blobs.length; i++) {
      blobs[i].draw(pg);
    }
  }
  class Blob {
    boolean isHole;
    float area, circumference;
    Rectangle bounding_rect;
    Point centroid;
    Point[] points;
    PVector[] vectors;

    Blob(XML xml) {
      isHole = xml.getString("isHole")=="true"? true:false;
      area   = xml.getFloat("area");
      circumference = xml.getFloat("circumference");
      bounding_rect = new Rectangle();
      bounding_rect.x = xml.getChild(0).getInt("x");
      bounding_rect.y = xml.getChild(0).getInt("y");
      bounding_rect.width = xml.getChild(0).getInt("width");
      bounding_rect.height = xml.getChild(0).getInt("height");
      centroid = new Point();
      centroid.x = xml.getChild(1).getInt("x");
      centroid.y = xml.getChild(1).getInt("y");
      points = new Point[xml.getChild(2).getChildCount()];
      vectors = new PVector[xml.getChild(2).getChildCount()];
      for (int i=0; i<points.length; i++) {
        int x = xml.getChild(2).getChild(i).getInt("x");
        int y = xml.getChild(2).getChild(i).getInt("y");
        points[i] = new Point(x, y);
        vectors[i] = vectorFromPoint(points[i]);
      }
    }
    PVector vectorFromPoint(Point pp) {
      /*float a = map(pp.x,0,_width,TWO_PI,0);
       float x = ratio*cos(a);
       float z = ratio*sin(a);
       float y = pp.y-_height/2;*/
      float longitud = map(pp.x, 0, _width, 0, TWO_PI);
      float latitud  = map(pp.y, 0, _height, PI, 0);

      float x = ratio*sin(latitud)*sin(longitud);
      float y = ratio*cos(latitud);
      float z = ratio*sin(latitud)*cos(longitud);

      PVector vector = new PVector(x, y, z);
      return vector;
    }
    void draw(PGraphics pg) {
      pg.noFill();//stroke(255);
      pg.beginShape();
      for (int i=0; i<points.length; i++) {
        pg.vertex(vectors[i].x, vectors[i].y, vectors[i].z);
      }
      pg.endShape(CLOSE);
    }
  }
}










class Poligon {
  PVector[] vertices;

  Poligon(float cx, float cy, float ratio, int $sides) {
    vertices = new PVector[$sides];
    float da = TWO_PI/$sides;
    float a = 0;
    for (int i=0; i<vertices.length; i++) {
      float r = random(0.4*ratio, ratio);
      float x = cx+r*cos(a);
      float y = cy+r*sin(a);
      vertices[i] = new PVector(x, y);
      a+=da;
    }
  }
  Poligon(PVector[] bertices) {
    vertices = new PVector[bertices.length];
    for (int i=0; i<vertices.length; i++) {
      vertices[i] = bertices[i];
    }
  }
  Poligon(Point[] bertices) {
    vertices = new PVector[bertices.length];
    for (int i=0; i<vertices.length; i++) {
      vertices[i] = new PVector(bertices[i].x, bertices[i].y);
    }
  }
  Poligon(ArrayList bertices) {
    vertices = new PVector[bertices.size()];
    for (int i=0; i<vertices.length; i++) {
      PVector tmp = (PVector)bertices.get(i);
      vertices[i] = tmp;//new PVector(tmp.x, tmp.y);
    }
  }
  void draw(PGraphics pg) {
    pg.beginShape();
    for (int i=0; i<vertices.length; i++) {
      //if(vertices[i].y>=0)
      if (i>0 && dist(vertices[i].x, vertices[i].y, vertices[i-1].x, vertices[i-1].y)<100)
        pg.vertex(vertices[i].x, vertices[i].y);
    }
    pg.endShape();
  }
  void vertexDraw(PGraphics pg) {
    for (int i=0; i<vertices.length; i++) {
      float sz=2;
      pg.noFill();
      pg.pushMatrix();
      pg.translate(vertices[i].x, vertices[i].y);
      pg.strokeWeight(1);
      stroke(255, random(96, 128));
      pg.rect(0, 0, sz, sz);
      pg.popMatrix();
    }
  }
  void cycle(PGraphics pg) {
    int i = int(1*frameCount)%vertices.length;
    float sz=8;
    pg.noFill();
    pg.pushMatrix();
    pg.translate(vertices[i].x, vertices[i].y);
    pg.strokeWeight(1);
    stroke(255, random(192, 240));
    pg.rect(0, 0, sz, sz);
    pg.popMatrix();
  }
}

PVector[] calcInners(Poligon polig, float zTep) {
  PVector[] vertices = polig.vertices;
  PVector[] inners = new PVector[vertices.length];
  for (int i=0; i<vertices.length; i++) {
    PVector prev, midprev, me, midnext, next;
    prev = new PVector(vertices[(vertices.length+i-1)%vertices.length].x, vertices[(vertices.length+i-1)%vertices.length].y);
    me = new PVector(vertices[i].x, vertices[i].y);
    next = new PVector(vertices[(i+1)%vertices.length].x, vertices[(i+1)%vertices.length].y);
    midprev  = new PVector((me.x+prev.x)/2, (me.y+prev.y)/2);
    midnext  = new PVector((me.x+next.x)/2, (me.y+next.y)/2);

    float aprev = atan2((me.y-prev.y), (me.x-prev.x));
    float antiAprev = aprev+PI/2;
    float anext = atan2((next.y-me.y), (next.x-me.x));
    float antiAnext = anext+PI/2;

    PVector auxprev1 = new PVector();
    auxprev1.x = midprev.x+zTep*cos(antiAprev);
    auxprev1.y = midprev.y+zTep*sin(antiAprev); 

    PVector auxprev2 = new PVector();
    auxprev2.x = me.x+zTep*cos(antiAprev);
    auxprev2.y = me.y+zTep*sin(antiAprev);

    PVector auxnext3 = new PVector();
    auxnext3.x = me.x+zTep*cos(antiAnext);
    auxnext3.y = me.y+zTep*sin(antiAnext);

    PVector auxnext4 = new PVector();
    auxnext4.x = midnext.x+zTep*cos(antiAnext);
    auxnext4.y = midnext.y+zTep*sin(antiAnext);

    //inners[i] = new PVector((auxnext.x+auxprev.x)/2, (auxnext.y+auxprev.y)/2);
    float x1, x2, x3, x4, y1, y2, y3, y4;

    x1 = auxprev1.x;
    y1 = auxprev1.y;
    x2 = auxprev2.x;
    y2 = auxprev2.y;
    x3 = auxnext3.x;
    y3 = auxnext3.y;
    x4 = auxnext4.x;
    y4 = auxnext4.y;


    float ua = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
    float ub = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));

    float x = x1+ua*(x2-x1);
    float y = y1+ua*(y2-y1);

    if (((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1))!=0) {
      inners[i] = new PVector(x, y);
    }
    else {
      if (i>0)
        inners[i] = inners[i-1];
      else
        inners[i] = new PVector(360, 240);//width/2,height/2);//0,0);//
    }
  }
  return(inners);
}
