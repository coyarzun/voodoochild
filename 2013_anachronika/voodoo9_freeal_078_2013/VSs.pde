class VShape extends VGeom{
  ArrayList vgeoms;
  boolean run;
  float perimeter;
  float runpos, runstep, runspeed;
  int runpath;

  VShape(){
    vgeoms = new ArrayList();
  }
  void add(VGeom vg){
    vgeoms.add(vg);
    perimeter+=vg.perimeter;
  }
  void addArc(float _x, float _y, float _width, float _height, float _start, float _stop){
    VArc tmp = new VArc(_x,_y,_width,_height,_start,_stop);
    vgeoms.add(tmp);
    perimeter+=tmp.perimeter;
  }
  void addLine(float _x1, float _y1, float _x2, float _y2){
    VLine tmp = new VLine(_x1, _y1, _x2, _y2);
    vgeoms.add(tmp);
    perimeter+=tmp.perimeter;
  }
  void translate(float x, float y){
    for(int i=0; i<vgeoms.size(); i++){
      VGeom tmp = (VGeom)vgeoms.get(i);
      tmp.translate(x,y);
    }
  }
  void scale(float s){
    for(int i=0; i<vgeoms.size(); i++){
      VGeom tmp = (VGeom)vgeoms.get(i);
      tmp.scale(s);
    }
  }
  void startRun(float speed, float step){
    runspeed = speed;//perimeter*speed;
    runstep =  step;//perimeter*step;
    //println(runstep);
    run = true;
  }
  void startRun(float speed, float step, float pos){
    runspeed = speed;//perimeter*speed;
    runstep =  step;//perimeter*step;
    runpos  = pos;
    //println(runstep);
    run = true;
  }
  void stopRun(){
    runpos = 0;
    runpath = 0;
    run = false;
  }
  void pauseRun(){
    runpos = 0;
    runpath = 0;
    run = false;
  }
  void draw(PGraphics pg){
//    pg.beginDraw();

    if(run && vgeoms.size()>1){
      runRoutine(pg);
    }
    else{
      for(int i=0; i<vgeoms.size(); i++){
        VGeom tmp = (VGeom)vgeoms.get(i);
        tmp.draw(pg);
      }
    }
//    pg.endDraw();
  }
  void setStrokeWeight(float sw){
    strokeW = sw;
    for(int i=0; i<vgeoms.size(); i++){
      VGeom tmp = (VGeom)vgeoms.get(i);
      tmp.setStrokeWeight(sw);
    }
  }
  void runRoutine(PGraphics pg){
    float remstep = runstep;
    float rempos  = runpos;
    float remperimeter = 0;
    int index = 0;


    ArrayList points = new ArrayList();
    while(remstep>0){
      try{VGeom tmp = (VGeom)vgeoms.get(index%vgeoms.size());
      float ipos, epos;
      ipos = rempos-remperimeter;
      epos = ipos+remstep;
      if(epos>tmp.perimeter)epos=tmp.perimeter;
      float dpos = epos-ipos;
      boolean drawcondition = ipos >=0 && ipos <= tmp.perimeter;

      if(drawcondition){
        float mv = map(rempos,0,perimeter,0,255)%255;
        tmp.setcolor(color(mv,255,255));
        PVector[] vv = tmp.draw(ipos, epos, pg);
        remstep-=dpos;
        rempos +=dpos;
        points.add(vv[0]);
        if(remstep<=0)points.add(vv[1]);
      }
      remperimeter+=tmp.perimeter;
      index++;
      }catch(Exception e){
      }
    }

    halloesRoutine(points, pg);


    runpos+=runspeed;
    runpos%=perimeter;
  }
  void halloesRoutine(ArrayList points, PGraphics pg){
    //Point[] points = blobs[i].points;
    Poligon somePoligon = new Poligon(points);
    Poligon[] inners, halloes;
    inners = new Poligon[4];
    halloes = new Poligon[6];
    pg.noFill();
    pg.strokeWeight(1);
    for(int j=0; j<inners.length; j++){
      inners[j] = new Poligon(calcInners(somePoligon, -2*(j+1)));
    }
    for(int j=0; j<halloes.length; j++){
      halloes[j] = new Poligon(calcInners(somePoligon, -pow((j+1)/2,1.2*1)));
    }

    if(innerOn){
      for(int j=0; j<inners.length; j++){
        pg.stroke(0,255,map(j,0,inners.length,255,0));
        inners[j].draw(pg);
      }
    }
    if(halloesOn){
      for(int j=0; j<halloes.length; j++){
        pg.stroke(map((halloes.length-j+0.2*frameCount)%halloes.length,0,halloes.length,256,0),255,255,map(j,0,halloes.length,256,0));
        halloes[j].draw(pg);
      }
    }
    if(outLineOn){
      pg.stroke(255);
      somePoligon.draw(pg);
    }
    if(vertexOn){
      pg.stroke(255);
      somePoligon.vertexDraw(pg);
    }
    if(cycleOn){
      pg.stroke(255);
      somePoligon.cycle(pg);
    }
  }
}
class VArc extends VGeom{
  float x,y,width,height,start,stop;

  VArc(float _x, float _y, float _width, float _height, float _start, float _stop){
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
  void draw(){
    arc(x,y,width,height,start,stop);
  }
  void translate(float _x, float _y){
    x+=_x;
    y+=_y;
  }
}
class VLine extends VGeom{
  float x1,y1,x2,y2;
  float angle;

  VLine(float _x1, float _y1, float _x2, float _y2){
    x1=_x1;
    y1=_y1;
    x2=_x2;
    y2=_y2;

    perimeter = dist(x1,y1,x2,y2);
    angle = atan2((y2-y1), x2-x1);

    //println(perimeter);
  }
  void draw(PGraphics pg){
    pg.strokeWeight(1);
    pg.stroke(keylineKolor);
    //pg.line(x1,y1,x2,y2);
  }
  PVector[] draw(float frompos, float topos, PGraphics pg){
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
    a[0] = new PVector(xx1,yy1);
    a[1] = new PVector(xx2,yy2);
    return a;
  }
  void translate(float x, float y){
    x1+=x;
    x2+=x;
    y1+=y;
    y2+=y;
  }
  void scale(float s){
    x1*=s;
    x2*=s;
    y1*=s;
    y2*=s;
  }  
}
class VGeom{
  float perimeter;
  color strokeKolor = color(255);
  color keylineKolor = color(0,255,255);
  float strokeW = 1;

  VGeom(){
  }
  void draw(){
  }
  void draw(PGraphics pg){
  }
  PVector[] draw(float frompos, float topos){
    PVector[] a = new PVector[0];
    return a;
  }
  PVector[] draw(float frompos, float topos, PGraphics pg){
    PVector[] a = new PVector[0];
    return a;
  }
  void translate(float x, float y){
  }
  void scale(float s){
  }
  void setStrokeWeight(float sw){
    strokeW = sw;
  }
  void setcolor(color k){
    strokeKolor = k;
  }
}















