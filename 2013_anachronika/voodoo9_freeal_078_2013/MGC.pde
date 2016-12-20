class BlobWorld{
  float ratio;
  int _width, _height;
  Blob[] blobs;
  
  BlobWorld(String url){
    XMLElement xml = new XMLElement(p, url);
    _width  = xml.getIntAttribute("width"); 
    _height = xml.getIntAttribute("height");
    ratio = float(_width)/TWO_PI;
    blobs   = new Blob[xml.getChild(0).getChildCount()];
    for(int i=0; i<blobs.length; i++){
      blobs[i]=new Blob(xml.getChild(0).getChild(i));
    }
  }
  void draw(PGraphics pg){
    for(int i=0; i<blobs.length; i++){
      blobs[i].draw(pg);
    }
  }
  class Blob{
    boolean isHole;
    float area, circumference;
    Rectangle bounding_rect;
    Point centroid;
    Point[] points;
    PVector[] vectors;

    Blob(XMLElement xml){
      isHole = xml.getStringAttribute("isHole")=="true"? true:false;
      area   = xml.getFloatAttribute("area");
      circumference = xml.getFloatAttribute("circumference");
      bounding_rect = new Rectangle();
      bounding_rect.x = xml.getChild(0).getIntAttribute("x");
      bounding_rect.y = xml.getChild(0).getIntAttribute("y");
      bounding_rect.width = xml.getChild(0).getIntAttribute("width");
      bounding_rect.height = xml.getChild(0).getIntAttribute("height");
      centroid = new Point();
      centroid.x = xml.getChild(1).getIntAttribute("x");
      centroid.y = xml.getChild(1).getIntAttribute("y");
      points = new Point[xml.getChild(2).getChildCount()];
      vectors = new PVector[xml.getChild(2).getChildCount()];
      for(int i=0; i<points.length; i++){
        int x = xml.getChild(2).getChild(i).getIntAttribute("x");
        int y = xml.getChild(2).getChild(i).getIntAttribute("y");
        points[i] = new Point(x,y);
        vectors[i] = vectorFromPoint(points[i]);
      }
    }
    PVector vectorFromPoint(Point pp){
      /*float a = map(pp.x,0,_width,TWO_PI,0);
      float x = ratio*cos(a);
      float z = ratio*sin(a);
      float y = pp.y-_height/2;*/
      float longitud = map(pp.x,0,_width,0,TWO_PI);
      float latitud  = map(pp.y,0,_height,PI,0);
      
      float x = ratio*sin(latitud)*sin(longitud);
      float y = ratio*cos(latitud);
      float z = ratio*sin(latitud)*cos(longitud);
      
      PVector vector = new PVector(x,y,z);
      return vector;
    }
    void draw(PGraphics pg){
      pg.noFill();//stroke(255);
      pg.beginShape();
      for(int i=0; i<points.length; i++){
         pg.vertex(vectors[i].x,vectors[i].y,vectors[i].z);
      }
      pg.endShape(CLOSE);
    }
  }
}










class Poligon{
  PVector[] vertices;

  Poligon(float cx, float cy, float ratio, int $sides){
    vertices = new PVector[$sides];
    float da = TWO_PI/$sides;
    float a = 0;
    for(int i=0; i<vertices.length; i++){
      float r = random(0.4*ratio,ratio);
      float x = cx+r*cos(a);
      float y = cy+r*sin(a);
      vertices[i] = new PVector(x,y);
      a+=da;
    }
  }
  Poligon(PVector[] bertices){
    vertices = new PVector[bertices.length];
    for(int i=0; i<vertices.length; i++){
      vertices[i] = bertices[i];
    }
  }
  Poligon(Point[] bertices){
    vertices = new PVector[bertices.length];
    for(int i=0; i<vertices.length; i++){
      vertices[i] = new PVector(bertices[i].x, bertices[i].y);
    }
  }
  Poligon(ArrayList bertices){
    vertices = new PVector[bertices.size()];
    for(int i=0; i<vertices.length; i++){
      PVector tmp = (PVector)bertices.get(i);
      vertices[i] = tmp;//new PVector(tmp.x, tmp.y);
    }
  }
  void draw(PGraphics pg){
    pg.beginShape();
    for(int i=0; i<vertices.length; i++){
      //if(vertices[i].y>=0)
      if(i>0 && dist(vertices[i].x,vertices[i].y,vertices[i-1].x,vertices[i-1].y)<100)
      pg.vertex(vertices[i].x,vertices[i].y);
    }
    pg.endShape();
  }
  void vertexDraw(PGraphics pg){
    for(int i=0; i<vertices.length; i++){
      float sz=2;
      pg.noFill();
      pg.pushMatrix();
      pg.translate(vertices[i].x,vertices[i].y);
      pg.strokeWeight(1);stroke(255,random(96,128));
      pg.rect(0,0,sz,sz);
      pg.popMatrix();
    }
  }
  void cycle(PGraphics pg){
    int i = int(1*frameCount)%vertices.length;
    float sz=8;
    pg.noFill();
    pg.pushMatrix();
    pg.translate(vertices[i].x,vertices[i].y);
    pg.strokeWeight(1);stroke(255,random(192,240));
    pg.rect(0,0,sz,sz);
    pg.popMatrix();
  }
}

PVector[] calcInners(Poligon polig, float zTep){
  PVector[] vertices = polig.vertices;
  PVector[] inners = new PVector[vertices.length];
  for(int i=0; i<vertices.length; i++){
    PVector prev, midprev, me, midnext, next;
    prev = new PVector(vertices[(vertices.length+i-1)%vertices.length].x, vertices[(vertices.length+i-1)%vertices.length].y);
    me = new PVector(vertices[i].x,vertices[i].y);
    next = new PVector(vertices[(i+1)%vertices.length].x, vertices[(i+1)%vertices.length].y);
    midprev  = new PVector((me.x+prev.x)/2, (me.y+prev.y)/2);
    midnext  = new PVector((me.x+next.x)/2, (me.y+next.y)/2);

    float aprev = atan2((me.y-prev.y),(me.x-prev.x));
    float antiAprev = aprev+PI/2;
    float anext = atan2((next.y-me.y),(next.x-me.x));
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
    float x1,x2,x3,x4,y1,y2,y3,y4;

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

if(((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1))!=0){
    inners[i] = new PVector(x,y);
}else{
    if(i>0)
    inners[i] = inners[i-1];
    else
    inners[i] = new PVector(360,240);//width/2,height/2);//0,0);//
}
  }
  return(inners);
}


