class VScreen extends Rectangle {
  PFont font;// = loadFont("CoyarzunAtarinormal-100.vlw");;
  PGraphics pg;
  boolean showCursor;
  float alfa, toalfa, dalfa;
  String lastlyric = "";
  String vislyric = "";
  String tmp = "";
  float lyricop = 0;
  float lyricd = .975;
  float tw = 32;
  int vl = 0;

  VScreen() {
  }
  VScreen(int _x, int _y, int _width, int _height) {
    x = _x;
    y = _y;
    width  = _width;
    height =  _height;
    pg = createGraphics((int)width, (int)height, P2D);
  }
  void draw(PGraphics pg) {
  }
  void mouseMoved() {
    if (mouseX>=x && mouseX<x+width && mouseY>=y && mouseY<y+height) {
      if (showCursor) {
        noCursor();
      }
      else {
        noCursor();
      }
    }
  }
  void fadein() {
    toalfa = 255;
  }
  void fadeout() {
    toalfa = 0;
  }
  void fade() {
    dalfa = (toalfa-alfa)*.12;
    alfa+=dalfa;
  }
  void addLyric(String l) {
    lastlyric = l;
    vislyric = " "+lastlyric+" ";

    vl = vislyric.length();
    vislyric+=" *** ";

    lyricop = 180;
    lyricd  = 1.012;
  }
}
class Rectangle {
  float x, y, width, height;
  Rectangle() {
  }
}
class Point {
  float x, y;
  Point() {
  }
  Point(float _x, float _y) {
    x = _x; 
    y = _y;
  }
}
class VShape extends VGeom {
  ArrayList vgeoms;
  boolean run;
  float perimeter;
  float runpos, runstep, runspeed;
  int runpath;

  VShape() {
    vgeoms = new ArrayList();
  }
  void add(VGeom vg) {
    vgeoms.add(vg);
    perimeter+=vg.perimeter;
  }
  void addArc(float _x, float _y, float _width, float _height, float _start, float _stop) {
    VArc tmp = new VArc(_x, _y, _width, _height, _start, _stop);
    vgeoms.add(tmp);
    perimeter+=tmp.perimeter;
  }
  void addLine(float _x1, float _y1, float _x2, float _y2) {
    VLine tmp = new VLine(_x1, _y1, _x2, _y2);
    vgeoms.add(tmp);
    perimeter+=tmp.perimeter;
  }
  void translate(float x, float y) {
    for (int i=0; i<vgeoms.size(); i++) {
      VGeom tmp = (VGeom)vgeoms.get(i);
      tmp.translate(x, y);
    }
  }
  void scale(float s) {
    for (int i=0; i<vgeoms.size(); i++) {
      VGeom tmp = (VGeom)vgeoms.get(i);
      tmp.scale(s);
    }
  }
  void startRun(float speed, float step) {
    runspeed = speed;//perimeter*speed;
    runstep =  step;//perimeter*step;
    //println(runstep);
    run = true;
  }
  void startRun(float speed, float step, float pos) {
    runspeed = speed;//perimeter*speed;
    runstep =  step;//perimeter*step;
    runpos  = pos;
    //println(runstep);
    run = true;
  }
  void stopRun() {
    runpos = 0;
    runpath = 0;
    run = false;
  }
  void pauseRun() {
    runpos = 0;
    runpath = 0;
    run = false;
  }
  void draw(PGraphics pg) {
    //    pg.beginDraw();

    if (run && vgeoms.size()>1) {
      runRoutine(pg);
    }
    else {
      for (int i=0; i<vgeoms.size(); i++) {
        VGeom tmp = (VGeom)vgeoms.get(i);
        tmp.draw(pg);
      }
    }
    //    pg.endDraw();
  }
  void setStrokeWeight(float sw) {
    strokeW = sw;
    for (int i=0; i<vgeoms.size(); i++) {
      VGeom tmp = (VGeom)vgeoms.get(i);
      tmp.setStrokeWeight(sw);
    }
  }
  void runRoutine(PGraphics pg) {
    float remstep = runstep;
    float rempos  = runpos;
    float remperimeter = 0;
    int index = 0;


    ArrayList points = new ArrayList();
    while (remstep>0) {
      try {
        VGeom tmp = (VGeom)vgeoms.get(index%vgeoms.size());
        float ipos, epos;
        ipos = rempos-remperimeter;
        epos = ipos+remstep;
        if (epos>tmp.perimeter)epos=tmp.perimeter;
        float dpos = epos-ipos;
        boolean drawcondition = ipos >=0 && ipos <= tmp.perimeter;

        if (drawcondition) {
          float mv = map(rempos, 0, perimeter, 0, 255)%255;
          tmp.setcolor(color(mv, 255, 255));
          PVector[] vv = tmp.draw(ipos, epos, pg);
          remstep-=dpos;
          rempos +=dpos;
          points.add(vv[0]);
          if (remstep<=0)points.add(vv[1]);
        }
        remperimeter+=tmp.perimeter;
        index++;
      }
      catch(Exception e) {
      }
    }

    halloesRoutine(points, pg);


    runpos+=runspeed;
    runpos%=perimeter;
  }
  void halloesRoutine(ArrayList points, PGraphics pg) {
    //Point[] points = blobs[i].points;
    Poligon somePoligon = new Poligon(points);
    Poligon[] inners, halloes;
    inners = new Poligon[4];
    halloes = new Poligon[6];
    pg.noFill();
    pg.strokeWeight(1);
    for (int j=0; j<inners.length; j++) {
      inners[j] = new Poligon(calcInners(somePoligon, -2*(j+1)));
    }
    for (int j=0; j<halloes.length; j++) {
      halloes[j] = new Poligon(calcInners(somePoligon, -pow((j+1)/2, 1.2*1)));
    }

    if (innerOn) {
      for (int j=0; j<inners.length; j++) {
        pg.stroke(0, 255, map(j, 0, inners.length, 255, 0));
        inners[j].draw(pg);
      }
    }
    if (halloesOn) {
      for (int j=0; j<halloes.length; j++) {
        pg.stroke(map((halloes.length-j+0.2*frameCount)%halloes.length, 0, halloes.length, 256, 0), 255, 255, map(j, 0, halloes.length, 256, 0));
        halloes[j].draw(pg);
      }
    }
    if (outLineOn) {
      pg.stroke(255);
      somePoligon.draw(pg);
    }
    if (vertexOn) {
      pg.stroke(255);
      somePoligon.vertexDraw(pg);
    }
    if (cycleOn) {
      pg.stroke(255);
      somePoligon.cycle(pg);
    }
  }
}
class VArc extends VGeom {
  float x, y, width, height, start, stop;

  VArc(float _x, float _y, float _width, float _height, float _start, float _stop) {
    x=_x;
    y=_y;
    width=_width;
    height=_height;
    start=_start;
    stop=_stop;
    //sólo x mientras asumiendo q es un arco de circunferencia
    //2*PI*ratio
    perimeter = (stop-start)*(width/2);
  }
  void draw() {
    arc(x, y, width, height, start, stop);
  }
  void translate(float _x, float _y) {
    x+=_x;
    y+=_y;
  }
}
class VLine extends VGeom {
  float x1, y1, x2, y2;
  float angle;

  VLine(float _x1, float _y1, float _x2, float _y2) {
    x1=_x1;
    y1=_y1;
    x2=_x2;
    y2=_y2;

    perimeter = dist(x1, y1, x2, y2);
    angle = atan2((y2-y1), x2-x1);

    //println(perimeter);
  }
  void draw(PGraphics pg) {
    pg.strokeWeight(1);
    pg.stroke(keylineKolor);
    //pg.line(x1,y1,x2,y2);
  }
  PVector[] draw(float frompos, float topos, PGraphics pg) {
    PVector[] a = new PVector[2];

    float xx1, yy1, xx2, yy2;
    xx1 = x1+frompos*cos(angle);
    yy1 = y1+frompos*sin(angle);
    xx2 = xx1+(topos-frompos)*cos(angle);
    yy2 = yy1+(topos-frompos)*sin(angle);
    //println("-->"+(topos-frompos));
    pg.strokeWeight(strokeW);
    pg.stroke(strokeKolor);
    //pg.line(xx1,yy1,xx2,yy2);
    /*
    pg.strokeWeight(1);
     pg.stroke(keylineKolor);
     pg.noFill();
     ellipse(xx2,yy2,6,6);*/
    a[0] = new PVector(xx1, yy1);
    a[1] = new PVector(xx2, yy2);
    return a;
  }
  void translate(float x, float y) {
    x1+=x;
    x2+=x;
    y1+=y;
    y2+=y;
  }
  void scale(float s) {
    x1*=s;
    x2*=s;
    y1*=s;
    y2*=s;
  }
}
class VGeom {
  float perimeter;
  color strokeKolor = color(255);
  color keylineKolor = color(0, 255, 255);
  float strokeW = 1;

  VGeom() {
  }
  void draw() {
  }
  void draw(PGraphics pg) {
  }
  PVector[] draw(float frompos, float topos) {
    PVector[] a = new PVector[0];
    return a;
  }
  PVector[] draw(float frompos, float topos, PGraphics pg) {
    PVector[] a = new PVector[0];
    return a;
  }
  void translate(float x, float y) {
  }
  void scale(float s) {
  }
  void setStrokeWeight(float sw) {
    strokeW = sw;
  }
  void setcolor(color k) {
    strokeKolor = k;
  }
}


class VLoogoo extends VScreen {
  ArrayList glows;
  BlobWorld blobworld;

  boolean logon, glowson;
  boolean morelineson;
  PGraphics pg;
  float scalevalue;
  float auxxoff, auxyoff;
  float outerscalevalue = 1;


  VLoogoo(int _x, int _y, int _width, int _height) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;

    //pg = createGraphics(_width,_height,P2D);//1024, 768, P2D);
    scalevalue = 2;//1.2;//.5;//1.0;
    auxxoff = -222/2;//145;//(256/scalevalue-222*scalevalue/2);// = 145;//512/2;//(720-pg.width)/4;
    auxyoff = -112/2;//136;//(192/scalevalue-112*scalevalue/2);// = 136;//384/2;//(768-pg.height)/4;

    logon     = true;
    glowson   = true;
    morelineson=true;    

    glowsRoutine();

    alfa = 0; 
    toalfa = 255;
  }
  void outerscale(float s) {
    outerscalevalue = s;
  }
  void glowsRoutine() {
    //glows = new VShape();
    glows = new ArrayList();
    blobworld = new BlobWorld("visuals/loogoo.xml");
    for (int i=0; i<blobworld.blobs.length; i++) {
      //blobs[i].draw();
      VShape tmp = new VShape();
      for (int j=0; j<blobworld.blobs[i].points.length; j++) {
        tmp.addLine(
        blobworld.blobs[i].points[j].x, 
        blobworld.blobs[i].points[j].y, 
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].x, //+random(-10,10),
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].y//+random(-10,10)
        );
      }
      tmp.setStrokeWeight(1);

      //tmp.translate(auxxoff,auxyoff);


      //tmp.translate(-120/(2/scalevalue),-(250-100)/(2/scalevalue));      
      //tmp.translate(auxxoff,auxyoff);
      float sscalevalue = 1;
      tmp.scale(sscalevalue/2);//;//-120,-(250-100));

      tmp.translate(-120/(2*sscalevalue), -(250-100)/(2*sscalevalue));
      tmp.translate(auxxoff*sscalevalue, auxyoff*sscalevalue);
      //tmp.translate(pg.width/2,pg.height/2);

      tmp.startRun(2, tmp.perimeter*.3);
      glows.add(tmp);
    }
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0, alfa);
    pg.translate(pg.width/2, pg.height/2);
    pg.pushMatrix();
    pg.scale(outerscalevalue);
    pg.scale(scalevalue);
    pg.pushMatrix();
    pg.noSmooth();
    for (int i=0; i<glows.size(); i++) {
      VShape tmp = (VShape)glows.get(i);
      //pg.translate(-(720-512)/2,-(768-384)/2);
      //pg.translate((720-pg.width)/4,(768-pg.height)/4);
      //
      //pg.scale(scalevalue);//
      tmp.draw(pg);//, outerscalevalue);
    }
    pg.stroke(255);
    pg.popMatrix();

    if (logon) {
      pg.pushMatrix();

      //pg.scale(scalevalue);
      pg.translate(auxxoff, auxyoff);
      //pg.translate(auxxoff/scalevalue,auxyoff/scalevalue);
      //pg.translate(auxxoff,auxyoff);//(720-pg.width)/4,(768-pg.height)/4);
      //pg.smooth();
      loogoo(pg);
      pg.popMatrix();
    }
    //vplayer.draw(pg);
    pg.popMatrix();
  }
  void loogoo(PGraphics pg) {
    pg.pushMatrix();
    pg.strokeJoin(ROUND);
    pg.strokeCap(ROUND);
    //pg.scale(2);
    for (int j=0; j<2; j++) {
      pg.stroke(j==0?
      color(4*frameCount%255, 255, 255, 220)
        :255);// color(random(100,120),255,random(128,255),128):0);//color(random(255),255,255));//color(255,0,0));
      pg.noFill();
      //pg.fill(0);//,255,255);
      //if(j==0)//pg.fill(0);else pg.noFill();
      pg.strokeWeight(2-j);//*2);
      //V
      pg.pushMatrix();
      //pg.stroke(255);
      //pg.fill(0);//
      pg.translate(5, 5);
      pg.beginShape();
      pg.vertex(10-5, 0+10-10);
      pg.vertex(20, 20+10);
      pg.vertex(35+5, 20+10);
      pg.vertex(45, 40);
      pg.vertex(55, 40);
      //pg.vertex(50,50);
      pg.vertex(72.5, 5);
      pg.vertex(107.5, 5);
      pg.vertex(105, 0);
      pg.vertex(75, 0);
      pg.vertex(65, 0);
      pg.vertex(50, 30);
      pg.vertex(35+5-5, 0+10-10);
      pg.endShape(CLOSE);


      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<5;i++) {
          pg.beginShape();
          pg.vertex(10+5+1.1*(5-i), 20+2*(5-i));
          pg.vertex(40+1.1*i, 20+2*(5-i));
          pg.vertex(50, 50-4*i);
          pg.vertex(50+15-2*i, 20);
          pg.endShape();
        }
      }

      pg.popMatrix();
      //O
      pg.pushMatrix();
      //pg.stroke(255);
      //pg.fill(0);//
      pg.translate(5, 5);
      pg.translate(70, 10);
      pg.beginShape();
      pg.vertex(5, 0);
      pg.vertex(0, 10);
      pg.vertex(10, 30);
      pg.vertex(20, 30);
      //pg.vertex(15,40);
      pg.vertex(30, 10);
      pg.vertex(25, 0);
      pg.endShape(CLOSE);
      //o calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(8, 10);
      pg.vertex(15, 24);
      pg.vertex(22, 10);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<4;i++) {
          pg.beginShape();
          pg.vertex(0+2*i, 10);
          pg.vertex(15, 40-4*i);
          pg.vertex(15+15-2*i, 10);
          pg.endShape();
        }
      }
      pg.popMatrix();


      //O 2
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(95, 10);
      pg.beginShape();
      pg.vertex(10, 10);
      //pg.vertex(15,0);
      pg.vertex(0, 30);
      pg.vertex(5, 40);
      pg.vertex(25, 40);
      pg.vertex(30, 30);
      pg.vertex(20, 10);
      pg.endShape(CLOSE);
      //pg.fill(255);//
      //o calatto
      pg.beginShape();
      pg.vertex(8, 30);
      pg.vertex(22, 30);
      pg.vertex(15, 16);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<4;i++) {
          pg.beginShape();
          pg.vertex(0+2*i, 10+20);
          pg.vertex(15, 0+4*i);
          pg.vertex(15+15-2*i, 10+20);
          pg.endShape();
        }
      }
      pg.popMatrix();

      //D
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(70+40, 0);
      pg.beginShape();
      pg.vertex(0, 0);
      pg.vertex(20, 40);
      pg.vertex(30, 40);
      //pg.vertex(25,50);
      pg.vertex(45, 10);
      pg.vertex(40, 0);
      pg.endShape(CLOSE);
      //D calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(10+8, 10+10);
      pg.vertex(10+15, 10+24);
      pg.vertex(10+22, 10+10);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<4;i++) {
          pg.beginShape();
          pg.vertex(10+2*i, 10+10);
          pg.vertex(25, 40+10-4*i);
          pg.vertex(25+15-2*i, 10+10);
          pg.endShape();
        }
      }

      pg.popMatrix();

      //O 3
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(60+75+10, 10);
      pg.beginShape();
      pg.vertex(10, 10);
      //pg.vertex(15,0);
      pg.vertex(0, 30);
      pg.vertex(5, 40);
      pg.vertex(25, 40);
      pg.vertex(30, 30);
      pg.vertex(20, 10);
      pg.endShape(CLOSE);
      //o calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(8, 30);
      pg.vertex(22, 30);
      pg.vertex(15, 16);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<4;i++) {
          pg.beginShape();
          pg.vertex(0+2*i, 10+20);
          pg.vertex(15, 0+4*i);
          pg.vertex(15+15-2*i, 10+20);
          pg.endShape();
        }
      }
      pg.popMatrix();

      //O4
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(85+75+10, 10);
      pg.beginShape();
      pg.vertex(5, 0);
      pg.vertex(0, 10);
      pg.vertex(10, 30);
      pg.vertex(20, 30);
      //pg.vertex(15,40);
      pg.vertex(30, 10);
      pg.vertex(25, 0);
      pg.endShape(CLOSE);
      //o calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(8, 10);
      pg.vertex(15, 24);
      pg.vertex(22, 10);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<4;i++) {
          pg.beginShape();
          pg.vertex(0+2*i, 10);
          pg.vertex(15, 40-4*i);
          pg.vertex(15+15-2*i, 10);
          pg.endShape();
        }
      }
      pg.popMatrix();

      //C
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(55, 55);
      pg.beginShape();
      pg.vertex(5, 0);
      pg.vertex(0, 10);
      pg.vertex(15, 40);
      pg.vertex(25, 40);
      //pg.vertex(20,50);
      pg.vertex(25, 40);

      pg.vertex(30, 30);
      pg.vertex(20, 30);
      pg.vertex(10, 10);
      pg.vertex(15, 10);
      pg.vertex(20, 20);
      pg.vertex(35, 20);
      pg.vertex(45, 0);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<5;i++) {
          pg.beginShape();
          pg.vertex(5+2*i, 10+10);
          pg.vertex(20, 40+10-4*i);
          pg.vertex(25-i, 30+10-2*i);//20,40+10-4*i);
          pg.vertex(25+i, 30+10-2*i);

          pg.endShape();
        }
      }
      pg.popMatrix();
      //hI
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(55+40, 55);
      pg.beginShape();
      pg.vertex(10, 0);
      pg.vertex(7.5, 5);
      pg.vertex(32.5, 5);
      pg.vertex(35, 0);
      pg.endShape(CLOSE);

      pg.beginShape();
      pg.vertex(20-15, 10);
      pg.vertex(0-15, 50);
      pg.vertex(10-15, 50);
      pg.vertex(10-15+5, 50-10);
      pg.vertex(10-15+5+5, 50-10);

      pg.vertex(0, 50);
      pg.vertex(10, 50);
      pg.vertex(30, 10);
      pg.vertex(20, 10);

      pg.vertex(10-15+5+5+5, 50-10-10);
      pg.vertex(10-15+5+5, 50-10-10);
      pg.vertex(30-15, 10);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,255,255);
        pg.noFill();
        for (int i=1; i<12; i++) {
          //pg.line();
          if (!(i>=4 && i<=8)) {
            pg.line(+2.1*i-1, 10+10+2, 
            -15+2.1*i, 50
              );
          }
        }
        //pg.line(9+2*(1-i),50-2,22+.2+2*(1-i),10+2+10);
      }

      pg.popMatrix();
      //L
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(55+40+15, 55);
      pg.beginShape();
      pg.beginShape();
      pg.vertex(20, 10);
      pg.vertex(5, 40);
      pg.vertex(10, 50);
      //pg.vertex(0,50);
      pg.vertex(35, 50);
      pg.vertex(40, 40);
      pg.vertex(15, 40);
      pg.vertex(30, 10);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<5; i++) {
          pg.beginShape();
          pg.vertex(22+.2+2*(1-i), 10+2+10);
          pg.vertex(9+3*(2-i), 42-2*(1-i));
          pg.vertex(37 + (1-i), 42-2*(1-i));
          pg.endShape();
        }
      }

      pg.popMatrix();

      //D
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5, 5);
      pg.translate(55+40+30+15, 55);
      pg.beginShape();
      pg.vertex(0, 0);
      pg.vertex(20, 40);
      pg.vertex(30, 40);
      //pg.vertex(25,50);
      pg.vertex(45, 10);
      pg.vertex(40, 0);
      pg.endShape(CLOSE);
      //D calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(10+8, 10+10);
      pg.vertex(10+15, 10+24);
      pg.vertex(10+22, 10+10);
      pg.endShape(CLOSE);

      if (morelineson) {
        //pg.stroke(255,0,0);
        pg.noFill();
        for (int i=1; i<4;i++) {
          pg.beginShape();
          pg.vertex(10+2*i, 10+10);
          pg.vertex(25, 40+10-4*i);
          pg.vertex(25+15-2*i, 10+10);
          pg.endShape();
        }
      }
      pg.popMatrix();
    }
    pg.popMatrix();

    pg.endDraw();
  }

  void keyPressed() {
    if (key=='z')logon=!logon;
    if (key=='x')halloesOn=!halloesOn;
    if (key=='c')innerOn=!innerOn;
    if (key=='v')morelineson=!morelineson;
  }
}


class FlowR {
  int lastx = -1;
  int lasty = -1;

  ArrayList v, w;
  FlowR() {
  }
  void flowrRoutine() {
    v = new ArrayList();
    w = new ArrayList();

    float ratio  = 100+stageManager.daSong.beatMap.snare.currentside; 
    float cx = 0;//width/2; 
    float cy = -20;//height/2-20;
    float da = radians(10)/10;
    float sw = 6;
    for (int j=0; j<3; j++) {
      VShape tmp = new VShape();
      ratio-=10;
      for (float i=0; i<TWO_PI; i+=da) {
        float x0, y0, x1, y1;
        float r = pfn(ratio, i);
        x0 = cx+r*cos(i+PI/2);
        y0 = cy+r*sin(i+PI/2);
        r = pfn(ratio, (i+da));
        x1 = cx+r*cos(i+da+PI/2);
        y1 = cy+r*sin(i+da+PI/2);

        tmp.addLine(x0, y0, x1, y1);
      }
      tmp.setStrokeWeight(sw);
      tmp.startRun(10, tmp.perimeter*.9, (frameCount*10)%tmp.perimeter);
      sw*=.8;
      w.add(tmp);
    }
  }
  float pfn(float r, float a) {
    return r*(stageManager.daSong.beatMap.snare.currentside/20+cos((3+stageManager.daSong.beatMap.kick.currentside/20)*(a*(1+stageManager.daSong.beatMap.hat.currentside/20))));//*random(.9,1);//-radians(2*frameCount%360)
  }
  void draw(PGraphics pg) {
    flowrRoutine();

    //pg.background(0);
    pg.strokeCap(ROUND);
    for (int i=0; i<v.size(); i++) {
      VShape tmp = (VShape)v.get(i);
      tmp.draw(pg);
    }
    for (int i=0; i<w.size(); i++) {
      VShape tmp = (VShape)w.get(i);
      tmp.draw(pg);
    }
  }
}

class OldVFlowR extends VScreen {
  color bgcolor;
  FlowR flower;

  OldVFlowR(int _x, int _y, int _width, int _height, color bg) {
    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
    flower = new FlowR();
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    //pg.background(0);//bgcolor);//0,0);
    int kk = int(10*sin(radians((1+stageManager.daSong.beatMap.snare.currentside/20)*frameCount%360)));
    pg.pushMatrix();
    pg.translate(pg.width/2, pg.height/2);
    pg.rotate(radians(10*sin(radians(4*frameCount%360))));
    pg.translate(-pg.width/2, -pg.height/2);
    pg.image(pg, -kk, -kk, pg.width+2*kk+1, pg.height+2*kk+1);
    pg.popMatrix();

    pg.noStroke();
    pg.fill(0, 32);
    pg.rect(0, 0, pg.width, pg.height);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.daSong.rocking) {
      int pos = stageManager.daSong.bar*16 + stageManager.daSong.frame;
      stageManager.daSong.beatMap.update(pos);
      flower.draw(pg);
    }
    pg.endDraw();
  }
}


class VTheEternalCity extends VScreen {
  color bgcolor;
  float noiseScale1=.1;//01;//0.02;//.01;//0.02;
  float noiseScale2=.01;
  int w, h;
  float cell;
  float playerx, playery;
  float xpos, ypos;
  float friction = .24;

  VTheEternalCity(int _x, int _y, int _width, int _height, color bg) {
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
    pg.background(255);//bgcolor);//0,0);
    pg.translate(pg.width/2, pg.height/2);
    if (stageManager.rocking) {
      doLandscape(pg);
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
        pg.fill(255*stageManager.daSong.beatMap.hat.currentside/100);//(200+int(noiseVal*128))%256+frameCount)%256,200,
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

class FlowRVisuals extends VScreen {
  color bgcolor;
  Venus venus;
  PImage prev;

  FlowRVisuals(int _x, int _y, int _width, int _height, color bg) {

    x = _x;
    y = _y;
    width = _width;
    height = _height;
    bgcolor = bg;
    font = loadFont("CoyarzunAtarinormal-100.vlw");

    venus = new Venus(0, 0, 0, 50);
    prev = createImage(int(width), int(height), HSB);
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(bgcolor, 64);//255,0,64);
    pg.pushMatrix();
    pg.translate(width/2, height/2);
    pg.scale(4);
    //scale(.8);
    pg.rotateX(radians(2*frameCount%360));
    pg.rotateZ(radians(frameCount%360));
    doLights(pg);
    glitch(pg);
    venus.draw(pg);
    pg.popMatrix();
    int ad = -10;////-10;
    prev.copy(pg, 0, 0, int(width), int(height), ad, ad, int(width)-2*ad, int(height)-2*ad);//<<200
    pg.endDraw();
  }
  void doLights(PGraphics pg) {
    pg.ambientLight(190, 255, 155+stageManager.daSong.beatMap.kick.currentside);
    pg.spotLight(240, 255, 155+stageManager.daSong.beatMap.hat.currentside, 0, -200, 0, 0, 1, 0, PI/2, 2);
    //    //pg.directionalLight(51, 102, 126, 0, -1, 0);
    pg.pointLight(160, 255, 155+stageManager.daSong.beatMap.snare.currentside, 0, 500, 0);
  }
  class Venus {
    float x, y, z;
    float r;
    Turururu[] turururus;

    Venus(float x, float y, float z, float r) {
      this.x=x; 
      this.y=y; 
      this.z=z;
      this.r=r;
      turururus = new Turururu[50];
      for (int i=0; i<turururus.length; i++) {
        float rr = random(r);
        float a = random(TWO_PI);
        float xx = rr*cos(a); 
        float aa = map(rr, 0, r, 0, PI/2);
        float yy = rr*sin(aa);
        float zz = rr*sin(a);
        float rotx = 0;//atan2(x,y)+PI;
        float roty = -a-PI/2;//a-PI/2;
        float rotz = 0;
        float baseH = map(rr, 0, r, r/10, r/5);
        turururus[i] = new Turururu(xx, yy, zz, rotx, roty, rotz, baseH);
      }
    }
    void draw(PGraphics pg) {
      pg.pushMatrix();
      //translate(width/2, height/2);
      pg.translate(x, y, z);
      pg.scale(0.3+stageManager.daSong.beatMap.snare.currentside/100);
      pg.rotateY(radians(frameCount%360));
      for (int i=0; i<turururus.length; i++) {
        turururus[i].draw(pg);
      }
      pg.popMatrix();
    }
  }
  class Turururu {
    float x, y, z;
    float rotx, roty, rotz;
    int parts;
    float baseH;
    float scalef;
    float dAngle;

    Turururu(float x, float y, float z, float rotx, float roty, float rotz, float baseH) {
      this.x=x; 
      this.y=y; 
      this.z = z;
      this.rotx=rotx; 
      this.roty=roty; 
      this.rotz=rotz;
      parts = 40;//40;
      this.baseH = baseH;
      scalef = .9;
    }
    void draw(PGraphics pg) {
      dAngle = radians(20)*(-.4+sin(radians(frameCount%360))*cos(radians(frameCount%360)));
      pg.pushMatrix();
      pg.translate(x, y, z);
      pg.rotateX(rotx);
      pg.rotateY(roty);
      pg.rotateZ(rotz);
      for (int i=0; i<parts;i++) {
        pg.stroke(0);//0,0,255);//noStroke();
        //fill(224,64,54);
        float cyclingval = ((parts-i+frameCount*.25)%3)*255/3;//frameCount%256;//random(160,240);//
        cyclingval = map(cyclingval, 0, 255, 220, 240);
        pg.fill(cyclingval, 255, 255);
        //line(0,0,0,baseH);
        pg.pushMatrix();
        pg.translate(0, baseH/2);
        pg.rectMode(CENTER);
        pg.rect(0, 0, baseH, baseH);
        pg.popMatrix();
        pg.translate(0, baseH);
        pg.rotateX(dAngle);
        pg.scale(scalef);
        //if(i%30==0)dAngle=-dAngle;
      }
      pg.popMatrix();
    }
  }
  void glitch(PGraphics pg) {
    float percent = map(stageManager.daSong.beatMap.kick.currentside, 0, 100, 100, 0);
    float spc = map(stageManager.daSong.beatMap.snare.currentside, 0, 100, 100, 0);
    int shiftH = -200+(int)percent;
    int shiftV = -200+(int)spc;
    int vvv = 2*int(random(3, 4));
    pg.loadPixels();
    for (int i=0;i<pg.pixels.length;i++) {

      int x = i%(int)pg.width;
      int y = (i-x)/(int)pg.width;
      int shift = shiftH+shiftV*pg.width;
      int shiftedPosition = (pg.pixels.length+i-shift)%pg.pixels.length;
      pg.pixels[i] = prev.pixels[abs(shiftedPosition%prev.pixels.length)]<<vvv;
    }
    pg.updatePixels();
  }
}




















