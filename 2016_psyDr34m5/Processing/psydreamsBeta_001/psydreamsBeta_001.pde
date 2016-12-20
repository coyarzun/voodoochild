import ddf.minim.*;

Minim       minim;
AudioInput  in;
Environment environment;
PsyDreams   psydreams;

PGraphics  buffer;
PShader    shader;

void setup(){
  size(800, 400, P3D);
  colorMode(HSB);
  textureWrap(REPEAT);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  
  buffer      = createGraphics(800, 400, P3D);
  shader      = loadShader("psyDrShader_001.glsl");
  environment = new Environment();
  psydreams   = new PsyDreams();
}
void draw(){
  drawBuffer();
  shader.set("resolution", float(width), float(height));
  shader.set("time", frameCount*0.1*.3);  //500.0
  shader.set("mouse", float(mouseX), float(mouseY));
  shader.set("leftGlitch", environment.leftGlitch);
  shader.set("rightGlitch", environment.rightGlitch);
  shader(shader);
  image(buffer,0,0,width,height);
}
void drawBuffer(){
  buffer.beginDraw();
  buffer.background(240, 255, 255);
  buffer.colorMode(HSB);
  buffer.translate(width/2.0,height/2.0);
  psydreams.draw(buffer);
  buffer.endDraw();
}
class Environment{
  boolean doProcess;
  float   coverOpacity;
  float   leftGlitch, rightGlitch;
  float   hueCycling, satCycling, brightCycling;
  float   hSideShearAmp, vSideShearAmp;
  
  int     bgMode;
  
  int     modelCols, modelRows;
  float   modelR1, modelR2;
  float   scaleModel,rotateXSpeed, rotateXSpeedMultiplicator, rotateYSpeedMultiplicator;
  float   audioScaleFactor;
  
  Environment(){
    init();
  }
  void init(){
    doProcess     = true;
    coverOpacity  = 0;
    leftGlitch    = -0.8;
    rightGlitch   = -leftGlitch;
    hueCycling    = 1.0;
    hSideShearAmp = 1.0;
    vSideShearAmp = 1.0;
    
    bgMode        = 1;
    
    modelCols     = 36;
    modelRows     = 18;
    modelR1       = 200;
    modelR2       = 500;
    
    scaleModel    = 1.0;
    rotateXSpeed  = 0.0;
    rotateXSpeedMultiplicator = 0.1;
    rotateYSpeedMultiplicator = 0.1;
    audioScaleFactor          = 1.0;
  }
}
class PsyDreams{
  Dream[] dreams;
  ArrayList dreamHistory;
  int     cdream, pdream;

  PsyDreams(){
    init();
  }
  void init(){
    dreams = new Dream[1];
    dreams[0] = new Toroid();
    dreamHistory = new ArrayList();
    cdream = 0;
  }
  void draw(PGraphics pg){
    dreams[cdream].draw(pg);
  }
  void goDream(int i){
    i+=dreams.length;
    i%=dreams.length;
    pdream = cdream; dreamHistory.add(pdream);
    cdream = i;
  }
  void nextDream(){
    pdream = cdream; dreamHistory.add(pdream);
    cdream++;
    cdream%=dreams.length;
  }
  void prevDream(){
    pdream = cdream; dreamHistory.add(pdream);
    cdream--;
    cdream+=dreams.length;
    cdream%=dreams.length;
  }
}

class Dream{
  Dream(){
  }
  void draw(PGraphics pg){
  }
}
class Toroid extends Dream{
  int rows, cols;
  float radioMayor, radioMenor;

  Toroid(){
  }
  void updateValues(){
    cols = environment.modelCols;
    rows = environment.modelRows;
    radioMayor  = environment.modelR1;
    radioMenor  = environment.modelR2;
  }
  void draw(PGraphics pg){
    updateValues();
    pg.pushMatrix();
    pg.translate(pg.width/2, pg.height/2);
    pg.scale(environment.scaleModel);
    pg.rotateX(environment.rotateXSpeed+frameCount*environment.rotateXSpeedMultiplicator);
    pg.rotateY(radians(frameCount*environment.rotateYSpeedMultiplicator));
    float da = TWO_PI/cols;
    float db = TWO_PI/rows;
    for (int i=0; i<cols; i++){
      for (int j=0; j<rows; j++){
        pg.pushMatrix();
        pg.rotateY(i*da);
        pg.translate(radioMayor, 0, 0);
        float dx = radioMenor*cos(4*j*db);
        float dy = radioMenor*sin(j*db);
        pg.rotateZ(j*db);
        pg.rotateZ(map((i)%cols, 0, cols, 0, TWO_PI));
        pg.translate(radioMenor, 0, 0);
        float cellsize = 20*(1+in.left.get((i+j*cols)%1024)*environment.audioScaleFactor*20);//
        
        pg.fill(   ((i%2==0&&j%2!=0)||(i%2!=0&&j%2==0))? 255:0);
        pg.box(cellsize);
        pg.box(cellsize*4, cellsize/5, cellsize/5);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}
