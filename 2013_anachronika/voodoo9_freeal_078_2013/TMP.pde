class Tmp extends VScreen{
  color bgcolor;

  Tmp(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      session.zong.beatMap.draw(pg);
      pg.popMatrix();



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

    }
    pg.endDraw();
  }
}
class VFreshwidow extends VScreen{
  color bgcolor;
  float noiseScale1=.1;//01;//0.02;//.01;//0.02;
  float noiseScale2=.01;
  int w, h;
  float cell;
  float playerx, playery;
  float xpos, ypos;
  float friction = .24;

  VFreshwidow(int _x, int _y, int _width, int _height, color bg){
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
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      //pg.pushMatrix();
      //pg.scale(4);
      //session.zong.beatMap.draw(pg);
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

      doLandscape(pg);
    }
    pg.endDraw();
  }
  void doLandscape(PGraphics pg){
    //background(0);
    //noiseScale = log(1000*mouseX);
    //println(log(mouseX));
    pg.noStroke();
    pg.lights();
    //pg.translate(width/2,height/2);
    pg.rotateX(-radians(2));

    float val;
    float val1= session.zong.beatMap.kick.currentside;
    float val2 = -frameCount+session.zong.beatMap.snare.currentside;

    float pnoiseVal = noise((val1+w/2)*noiseScale2, (val2+h/2+15)*noiseScale2);
    playery = cell*pow(.5+pnoiseVal,12)/2+50;
    //println(playery);
    float dx = (playerx-xpos)*friction;
    float dy = (playery-ypos)*friction;
    xpos+=dx; 
    ypos+=dy;
    pg.translate(xpos,ypos,0);
    pg.translate(-w*cell/2,0,-h*cell*.75);

    for(int j=0; j<h; j++){
      for(int i=0; i<w; i++){
        float noiseVal;
        noiseVal = noise((val1+i)*noiseScale1, (val2+j)*noiseScale1);
        pg.pushMatrix();
        pg.translate(i*cell, 0, j*cell);
        //if(i!=w/2){
          pg.fill(((200+int(noiseVal*128))%256+frameCount)%256,200,255*session.zong.beatMap.hat.currentside/100);
          //if(random(1)>.9)
          pg.box(cell*.8,cell*pow(.5+noiseVal,12),cell*.8);
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
class VOkeyMickey extends VScreen{
  ArrayList keymi;
  color bgcolor;

  VOkeyMickey(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");

    keymi = new ArrayList();
    keymiRoutine();
  }
  void keymiRoutine(){
    BlobWorld blobworld;

    blobworld = new BlobWorld("visuals/okeymickeyclub/keymi_logo.xml");
    for(int i=0; i<blobworld.blobs.length; i++){
      //blobs[i].draw();
      VShape tmp = new VShape();
      for(int j=0; j<blobworld.blobs[i].points.length; j++){
        tmp.addLine(
        blobworld.blobs[i].points[j].x,
        blobworld.blobs[i].points[j].y,
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].x+random(-10,10),
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].y+random(-10,10)
          );
      }
      tmp.translate(-blobworld._width/2,-blobworld._height/2);//auxyoff);
      tmp.scale(1.5);
      tmp.setStrokeWeight(8);
      tmp.startRun(60, tmp.perimeter*.8);
      keymi.add(tmp);
    }
    blobworld = new BlobWorld("visuals/okeymickeyclub/kuernos_logo.xml");
    for(int i=0; i<blobworld.blobs.length; i++){
      //blobs[i].draw();
      VShape tmp = new VShape();
      for(int j=0; j<blobworld.blobs[i].points.length; j++){
        tmp.addLine(
        blobworld.blobs[i].points[j].x,
        blobworld.blobs[i].points[j].y,
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].x+random(-10,10),
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].y+random(-10,10)
          );
      }
      tmp.translate(-blobworld._width/2,-blobworld._height/2);//auxyoff);
      tmp.scale(1.5);
      tmp.setStrokeWeight(8);
      tmp.startRun(10, tmp.perimeter*.8);
      keymi.add(tmp);
    }
  }
  void draw(PGraphics pg){
    color bgcolor = color(0);
    pg.beginDraw();
    pg.colorMode(HSB);

    pg.translate(pg.width/2,pg.height/2);

    if(session.zong.beatMap.snare.currentside>80){
      screendiv=2;
      pg.scale(random(2,4));
      bgcolor = color(random(255),255,255);
    }
    else if(session.zong.beatMap.kick.currentside>80){
      screendiv=4;
      pg.scale(random(4,8));
      bgcolor = color(random(0,32),255,255);
    }
    else if(session.zong.beatMap.hat.currentside>80){
      screendiv=8;
      pg.scale(random(8,12));
      bgcolor = color(random(85,128),255,255);
    }
    else{
      screendiv=1;
    }

    pg.background(bgcolor);//bgcolor);//0,0);

    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      //session.zong.beatMap.draw(pg);
      pg.popMatrix();
      if(vl>0){
        lyricsRing(pg);
      }
      for(int i=0; i<keymi.size(); i++){
        VShape tmp = (VShape)keymi.get(i);
        tmp.draw(pg);
      }
    }
    pg.endDraw();
  }
  void lyricsRing(PGraphics pg){
    float r = pg.width/4;
    String ts = vislyric;
    ts+=ts;
    float da = TWO_PI/(ts.length()+1);
    tw = (TWO_PI*r)/(2*vl+1);
    //0,0,lyricop,lyricop);
    pg.textFont(font, tw);
    for(int i=0; i<ts.length()-1; i++){
      String tmp = ts.substring(i, i+1);
      pg.pushMatrix();
      pg.rotateY(i*da-radians((frameCount*2)%360));
      pg.translate(0,40,r);
      pg.fill(random(255),255,255, lyricop);
      pg.text(tmp, -tw/2, tw/2);
      pg.popMatrix();
    } 
    /*

     pg.text(vislyric,-pg.width/2,tw/2);*/

    lyricop*=lyricd;
    if(lyricop>255 && lyricd>1){
      lyricd = .99;
    }
  }
}
class VFlowR extends VScreen{
  color bgcolor;

  VFlowR(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      session.zong.beatMap.draw(pg);
      pg.popMatrix();
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

    }
    pg.endDraw();
  }
}
class VSheLost extends VScreen{
  color bgcolor;

  VSheLost(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0);//bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      pg.pushMatrix();
      pg.scale(4);
      session.zong.beatMap.draw(pg);
      pg.popMatrix();



      if(vl>0){
        tw = pg.width/vl;
        pg.fill(0,0,lyricop,lyricop);
        pg.textFont(font, tw);
        pg.text(vislyric,-pg.width/2,tw/2);

        //tmp = vislyric.substring(0, 1);
        //vislyric = vislyric.substring(1, vl);
        //vislyric+=tmp;

        lyricop*=lyricd;
        if(lyricop>255 && lyricd>1){
          lyricd = .97;
        }
      }

    }
    pg.endDraw();
  }
}


class VSongzero extends VScreen{
  color bgcolor;

  NewTunnel tunnel;
  Alebrije alebrije;

  VSongzero(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    tunnel = new NewTunnel();
    alebrije = new Alebrije(0,100,0);
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(16,255,255*session.zong.beatMap.kick.currentside/100);//,bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);

      if(session.zong.bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else{
        tunnel.draw(pg);
      }
      if(vl>0){

        tw = pg.width/vl;
        pg.fill(0,0,lyricop,lyricop);
        pg.textFont(font, tw);
        pg.text(vislyric,-pg.width/2,tw/2);

        tmp = vislyric.substring(0, 1);
        vislyric = vislyric.substring(1, vl);
        vislyric+=tmp;

        lyricop*=lyricd;
        if(lyricop>255 && lyricd>1){
          lyricd = .99;
        }
      }
    }
    pg.endDraw();
  }
}


class NewTunnel{
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

  NewTunnel(){
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
    for(int i=0; i<ratios.length; i++){
      if(i%fixsteps==0){
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
      ratios[i] = random(100,120);
      colors[i] = color(16,255,255);//color(0,128,255);//color(int(random(255)));
      if(true){//random(10)>8
        areboxes[i] = true;
        boxes[i] = random(ratios[i])-ratios[i]*.5;
      }
      else{
        areboxes[i] = false;
      };
      if(i%80==0){
        arerings[i] = true;
      }
      else{
        arerings[i] = false;
      }
    };
    cycle = 0;
    mono = new Mono(0,0,0);
    alebrije = new Alebrije(0,0,0);
  }
  void draw(PGraphics pg){
    pg.pushMatrix();
    pg.scale(map(session.zong.bar,0,132,.5,10));
    pg.pushStyle();
    //pg.colorMode(RGB);
    //translate(width*.5, height*.5+20, 300);
    //pg.background(16,255,255);//255,128,0);
    //lights();

    pg.translate(0,20,300);//20,300);//width*.5, height*.5+20, 300);
    pg.rotate(wwe);
    wwe+=PI/60;
    pg.scale(1.5);
    pg.strokeWeight(1);
    pg.noStroke();
    //noFill();

    //float percent=max(0,(zpectral.myFFT.max-zpectral.minLimit)/zpectral.limitDiff);
    //pg.scale(1+percent/20);

    for(int i=0; i<ratios.length; i++){
      //println((i+cycle)%ratios.length);
      int j = abs((i+cycle)%ratios.length);
      float r = ratios[j];
      float depthf = (1-float(i)/(ratios.length-1));
      color k = blendColor(colors[j], color(8+int(16*depthf), 255,255*depthf), BLEND);//int(205*depthf), int(51*depthf)), BLEND  );
      pg.stroke(16,255,255);//255,128,0);
      //noStroke();
      pg.fill(k);
      //rectMode(CENTER);
      float ff = 1;
      //rect(0,0,r,r*ff);
      if(areboxes[j]){
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

      if(arerings[j]){
        int ringsteps = 6;
        for(int rk=0; rk<ringsteps; rk++){
          pg.pushMatrix();
          //translate(boxes[j], ratios[j]*.5*ff, 0);
          pg.rotateZ(rk*TWO_PI/ringsteps+ringangle);
          pg.translate(0, 100, 0);
          //scale(1,1,1);
          pg.box(20);
          float rr = 20+40*cos(ringangle);
          pg.translate(0,rr,0);
          pg.scale(1,40,1);
          pg.box(2);
          pg.popMatrix();
        };
      };
      if(i==20){
        pg.pushMatrix();
        pg.rotate(-wwe);
        pg.translate(0,15,0);
        pg.scale(0.6);
        if(session.zong.beatMap.snare.currentside<50)//bar%2==0)
          mono.draw(pg);
        else
          alebrije.draw(pg);
        pg.popMatrix();
      }
      pg.translate(0,0,-10);
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

class Mono{
  float x,y,z;
  float caminangulo;

  Mono(float x, float y, float z){
    this.x=x;
    this.y=y;
    this.z=z;
  }
  void draw(PGraphics pg){
    //colorMode(RGB);
    pg.ambientLight(16,255,64);//128, 64, 0);
    pg.spotLight(16,255,128, 80, 20, 40, -1, 0, 0, PI/2, 2);//255, 128, 0, 80, 20, 40, -1, 0, 0, PI/2, 2);
    //directionalLight(51, 102, 126, 0, -1, 0);
    pg.pointLight(96/2, 255/2, 240, 0, -500, 1000);//255/2, 200/2, 30/2, 0, -500, 1000);
    //if(random(100)>70);pointLight(240+random(15), 0,0, 0, 0, 2000);
    pg.stroke(16,255,255);//255,128,0);
    float f = 9;//4;
    caminangulo = radians(90*sin(radians(f*frameCount%360)));
    float eleva = 40*sin(radians(f*frameCount%360));
    fill(255);
    pg.pushMatrix();
    //scale(0.25);
    pg.scale(.8);
    //rotateZ(radians(.5*frameCount%360));
    pg.translate(0,-abs(eleva),0);
    //torso
    pg.box(30,40,10);
    //right napier
    pg.pushMatrix();
    pg.translate(10,20,0);
    pg.rotateX(caminangulo);
    pg.translate(0,20,0);
    pg.box(10,40,10);
    pg.popMatrix();
    //left napier
    pg.pushMatrix();
    pg.translate(-10,20,0);
    pg.rotateX(-caminangulo);
    pg.translate(0,20,0);
    pg.box(10,40,10);
    pg.popMatrix();
    //right arm
    pg.pushMatrix();
    pg.translate(20,-20,0);
    pg.rotateX(-caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0,20,0);
    pg.box(10,40,10);
    pg.popMatrix();
    //left arm
    pg.pushMatrix();
    pg.translate(-20,-20,0);
    pg.rotateX(caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0,20,0);
    pg.box(10,40,10);
    pg.popMatrix();
    //kabeza
    pg.pushMatrix();
    pg.translate(0,-30,0);
    pg.rotateY(caminangulo/4);
    pg.box(20);
    pg.translate(0,0,12);
    //pointLight(200, 0, 30, 5, -5, 0);
    pg.fill(255,0,0);
    pg.ellipse(5,-5,5,5);
    pg.ellipse(-5,-5,5,5);
    pg.popMatrix();

    pg.popMatrix();
  }
}











class VAntarctic extends VScreen{
  color bgcolor;

  HollowEarth earth;
  Flag flag;
  Lnr lnr;
  AntarcticLogo antarcticLogo;
  Antarctic antarctic;
  WOklr woklr;

  VAntarctic(int _x, int _y, int _width, int _height, color bg){
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
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      int bar = session.zong.bar;
      session.zong.beatMap.update(pos);

      if(bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if(bar<20){
        mode00(pg);
      }
      else if(bar<28){
        mode01(pg);
      }
      else if(bar<44){
        mode02(pg);
      }
      else if(bar<52){
        mode03(pg);
      }
      else if(bar<68){
        mode04(pg);
      }
      else if(bar<76){
        mode01(pg);
      }
      else if(bar<92){
        mode02(pg);
      }
      else if(bar<100){
        mode03(pg);
      }
      else{
        mode05(pg);      
      }
    }
    pg.endDraw();
  }
  void mode00(PGraphics pg){
    flag.draw(pg);
    if(session.zong.beatMap.kick.currentside>30)lnr.draw(pg);
    if(session.zong.beatMap.snare.currentside>80)antarcticLogo.draw(pg);
  }
  void mode01(PGraphics pg){
    if(session.zong.beatMap.kick.currentside>30){
      lnr.draw(pg);
    }
    else{
      flag.draw(pg);
    }
    if(session.zong.beatMap.snare.currentside>80)antarcticLogo.draw(pg);  
  }
  void mode02(PGraphics pg){
    if(session.zong.beatMap.kick.currentside>30){
      antarctic.draw(pg);
      woklr.draw(pg); 
    }
    else{
      flag.draw(pg);
      if(session.zong.beatMap.hat.currentside>30)lnr.draw(pg);
    }
  }
  void mode03(PGraphics pg){

    if(session.zong.beatMap.snare.currentside>80){
      antarcticLogo.draw(pg);
    }
    else if(session.zong.beatMap.kick.currentside>30){
      flag.draw(pg); 
      lnr.draw(pg);
    }
  }
  void mode04(PGraphics pg){
    pg.pushMatrix();
    pg.scale(2*session.zong.beatMap.kick.currentside/100);

    if(session.zong.beatMap.snare.currentside>80){
      antarcticLogo.draw(pg);
    }
    else if(session.zong.beatMap.kick.currentside>30){
      earth.draw(pg); 
    }
    else{
      antarctic.draw(pg);
    }
    pg.popMatrix();
  }
  void mode05(PGraphics pg){
    pg.pushMatrix();
    pg.scale(.5+2.5*session.zong.beatMap.kick.currentside/100);
    earth.draw(pg);
    if(session.zong.beatMap.snare.currentside>80){
      antarcticLogo.draw(pg);
    }
    pg.popMatrix();
  }
}

class HollowEarth{
  BlobWorld blobworld;

  HollowEarth(String url){
    blobworld = new BlobWorld(url);//"blobworld.xml");    
  }

  void draw(PGraphics pg){
    //background(0);
    //translate(width/2,height/2);
    pg.pushMatrix();
    pg.scale(2.5);
    pg.rotateZ(radians(30));
    pg.rotateY(radians(-frameCount%360));
    for(int i=0; i<255; i+=8){
      pg.stroke((255-i+16*frameCount)%256,255,255,255-i);
      pg.scale(1.01);
      blobworld.draw(pg);
    }
    pg.popMatrix();
  }
}












class VSunlight extends VScreen{
  color bgcolor;
  float noiseScale=0.3;//0.3;//0.1;//.005;//.01;//0.02;//.01;//0.02;
  float w, h;
  float cellw, cellh;
  float val1, val2;

  VSunlight(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    w = 40;//(1+4*session.zong.frame%16);//64;//width/10; 
    h = 30;//(1+4*session.zong.frame%16);//48;//height/10;
    cellw = 800/w;//width/w;
    cellh = 600/h;//height/h;
  }  
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);

    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);

      if(session.zong.bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else{
        likuid(pg);
      }
    }
    pg.endDraw();
  }
  void likuid(PGraphics pg){
    pg.rectMode(CENTER);
    pg.pushMatrix();
    pg.noStroke();
    pg.scale(session.zong.beatMap.kick.currentside>80 ? 2 : 1);
    pg.translate(cellw/2, cellh/2);
    for(int i=0; i<w/2; i++){
      for(int j=0; j<h/2; j++){
        int m = int((i+j*w)%w);
        float spc = 0;//2*zpectral.myFFT.spectrum[m];//*PI;

        val1 += session.zong.beatMap.kick.currentside/100;//-frameCount*.2;//.2;//random(width);//w/2*(1+sin(radians(frameCount%360)));//frameCount;
        val2 += session.zong.beatMap.snare.currentside/100;//h/2*(1+sin(radians(frameCount%360)));

        float noiseVal1, noiseVal2, noiseVal3;
        noiseVal1 = noise((val1+i)*noiseScale, (val2+j)*noiseScale);
        noiseVal2 = noise((val1+j)*noiseScale, (val2+i)*noiseScale);
        noiseVal3 = noise((val2+i)*noiseScale, (val1+i)*noiseScale);
        int n = int((noiseVal1+noiseVal2+noiseVal3)*256);
        n%=256;
        color k =  color (n,255,255, session.zong.beatMap.kick.currentside*2.56);//*noiseVal2);

        boolean cond1 = session.zong.frame%2==0;
        boolean cond2 = (i-frameCount)%(session.zong.bar+1)==0 || (j-frameCount/2)%(session.zong.frame+1)==0;
        boolean cond3 = cond1 && !cond2;
        boolean cond4 = !cond1 && cond2;

        if(cond3 || cond4){
          pg.pushMatrix();
          pg.translate(i*cellw,j*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();

          pg.pushMatrix();
          pg.translate((-i-1)*cellw,j*cellh);//(w-1-i)*cellw,j*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();

          pg.pushMatrix();
          pg.translate(i*cellw,(-1-j)*cellh);//(h-1-j)*cellh);
          pg.scale(1+spc);
          dddot(k, pg);
          pg.popMatrix();
          pg.pushMatrix();
          pg.translate((-1-i)*cellw,(-1-j)*cellh);//(w-1-i)*cellw,(h-1-j)*cellh);
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
  void dddot(color k, PGraphics pg){
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
  void ddot(PGraphics pg){
    pg.rect(0,0,cellw,cellh);
  }
}











class VAhardplace extends VScreen{
  color bgcolor;

  GuemboiV guemboi;
  GFlag    gflag;

  VAhardplace(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    guemboi = new GuemboiV();//("visuals/antarctic/blobworld.xml");
    gflag = new GFlag();
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      int bar = session.zong.bar;
      if(bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if(bar<20){
        if(random(10)>2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<36){
        if(random(10)<2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<44){
        if(random(10)>2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<60){
        if(random(10)<2)
          mode00(pg);
        else
          mode01(pg);    
      }
      else if(bar<68){
        if(random(10)<5)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<76){
        if(random(10)>2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<92){
        if(random(10)<2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<100){
        if(random(1)>.8){
          if(random(10)>2){
            mode00(pg);
          }
          else{
            if(session.zong.frame%2==0)
              pg.background(gflag.colors[session.zong.frame%gflag.colors.length]);
            mode01(pg);
          }
        }
        else{
          pg.background(gflag.colors[session.zong.frame%gflag.colors.length]);
        }
      }
      else if(bar<117){
        if(random(10)>5){
          mode00(pg);
        }
        else{
          pg.background(gflag.colors[session.zong.frame%gflag.colors.length]);
          mode01(pg);
        }
      }
      else{
        pg.background(gflag.colors[session.zong.frame%gflag.colors.length]);
        mode01(pg);        
      }

    }
    pg.endDraw();
  }
  void mode00(PGraphics pg){
    gflag.draw(pg);
  }
  void mode01(PGraphics pg){
    guemboi.draw(pg);
  }

}





class VAnemic extends VScreen{
  color bgcolor;

  Anemiko anemic;
  TScreen tscreen;

  VAnemic(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    color[] tmp = new color[3];
    tmp[0] = color(0,255,255);
    tmp[1] = color(0);
    tmp[2] = color(255);
    anemic = new Anemiko(tmp);//
    tscreen = new TScreen(tmp);
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      int bar = session.zong.bar;
      if(bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if(bar<12){
        if(random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<20){
        if(random(1)>.5)
          mode01(pg);
        else
          mode00(pg);
      }
      else if(bar<28){
        if(random(1)>.1)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<36){
        if(random(1)>.1)
          mode01(pg);
        else
          mode00(pg);
      }
      else if(bar<44){
        if(random(1)>.2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<52){
        if(random(1)>.2)
          mode01(pg);
        else
          mode00(pg);
      }
      else if(bar<64){
        if(random(1)>.4)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<70){
        if(random(1)>.4)
          mode01(pg);
        else
          mode00(pg);
      }
      else{
        if(random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }

    }
    pg.endDraw();
  }
  void mode00(PGraphics pg){
    anemic.draw(pg);
  }
  void mode01(PGraphics pg){
    tscreen.setCell(8*(1+session.zong.bar%4));
    tscreen.setText(vislyric);
    tscreen.draw(pg);
  }
}


class VSilverstein extends VScreen{
  color bgcolor;

  Anemiko anemic;
  TScreen tscreen;
  SapoLivingstone sapo;

  VSilverstein(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    color[] tmp = new color[7];
    tmp[0] = color(0);//0,0,0);
    tmp[1] = color( map(194,0,360,0,255), map(48,0,100,0,255), map(99,0,100,0,255) );//color(0x81E0FF);//129, 224,255); 
    tmp[2] = color(map(330,0,360,0,255), map(85,0,100,0,255), map(98,0,100,0,255) );//color(0xFD228C);//253, 34, 140); 
    tmp[3] = color(map(206,0,360,0,255), map(54,0,100,0,255), map(86,0,100,0,255) );//color(0x64A6DE);//100, 166, 222); 
    tmp[4] = color(map(358,0,360,0,255), map(99,0,100,0,255), map(95,0,100,0,255) );//color(0xF50001);//245, 0, 1);
    tmp[5] = color(map(140,0,360,0,255), map(27,0,100,0,255), map(78,0,100,0,255) );//color(0x92CBA6);//146, 203, 166); 
    tmp[6] = color(map(321,0,360,0,255), map(6,0,100,0,255), map(99,0,100,0,255) );//color(0xFFEFF9);//255, 239, 249); 
    anemic = new Anemiko(tmp);//

    tscreen = new TScreen(tmp);
    sapo = new SapoLivingstone();
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);
      int bar = session.zong.bar;
      if(bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else if(bar<20){
        if(random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<36){
        if(random(1)>.5)
          mode01(pg);
        else
          mode00(pg);
      }
      else if(bar<44){
        if(random(1)>.1)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<52){
        if(random(1)>.1)
          mode01(pg);
        else
          mode00(pg);
      }
      else if(bar<68){
        if(random(1)>.2)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<84){
        if(random(1)>.2)
          mode01(pg);
        else
          mode00(pg);
      }
      else if(bar<92){
        if(random(1)>.4)
          mode00(pg);
        else
          mode01(pg);
      }
      else if(bar<94){
        if(random(1)>.4)
          mode01(pg);
        else
          mode00(pg);
      }
      else{
        if(random(1)>.5)
          mode00(pg);
        else
          mode01(pg);
      }
      //sapo.draw(pg);
    }
    pg.endDraw();
  }
  void mode00(PGraphics pg){
    anemic.draw(pg);
  }
  void mode01(PGraphics pg){
    tscreen.setCell(8*(1+session.zong.bar%4));
    tscreen.setText(vislyric);
    tscreen.draw(pg);
  }
}


class VPunkrocker extends VScreen{
  color bgcolor;

  Emo emo;

  VPunkrocker(int _x, int _y, int _width, int _height, color bg){
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    emo = new Emo();//("visuals/antarctic/blobworld.xml");
  }
  void draw(PGraphics pg){

    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor);//0,0);
    pg.translate(pg.width/2,pg.height/2);
    if(session.zong.rocking){
      int pos = session.zong.bar*16 + session.zong.frame;
      session.zong.beatMap.update(pos);

      if(session.zong.bar<4){
        pg.pushMatrix();
        pg.scale(4);
        session.zong.beatMap.draw(pg);
        pg.popMatrix();
      }
      else{
        emo.draw(pg);
      }
    }
    pg.endDraw();
  }
}













