import ddf.minim.*;
import oscP5.*;
import netP5.*;

Minim       minim;
AudioInput  in;
OscP5 oscP5;
NetAddress myRemoteLocation;

Environment environment;
PsyDreams   psydreams;

PGraphics  buffer;
PImage     cover;
PShader    shader;

void setup(){
  size(800, 400, P3D);
  colorMode(HSB);
  textureWrap(REPEAT);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  
  buffer      = createGraphics(800, 400, P3D);
  cover       = loadImage("../_data/psyLive01_cover.png");
  shader      = loadShader("../_data/psyDrShader_002.glsl");
  environment = new Environment();
  psydreams   = new PsyDreams();
  
  oscP5 = new OscP5(this,12000);
  String ip = "192.168.1.8";//"192.168.0.183"
  myRemoteLocation = new NetAddress(ip,12000);//
  oscP5.plug(environment,"setDo",    "/process/do");
  oscP5.plug(environment,"setCop",   "/process/cop");
  oscP5.plug(environment,"setLG",    "/process/lg");
  oscP5.plug(environment,"setRG",    "/process/rg");
  oscP5.plug(environment,"setHC",    "/process/hc");
  oscP5.plug(environment,"setInter", "/process/sc");//<--corregir
  oscP5.plug(environment,"setHSA",   "/process/hsa");
  oscP5.plug(environment,"setVSA",   "/process/vsa");
    
  oscP5.plug(environment,"setBgm",   "/process/bgm");
    
  oscP5.plug(environment,"setCols",  "/model/cols");
  oscP5.plug(environment,"setRoWs",  "/model/rows");
  oscP5.plug(environment,"setR1",    "/model/r1");
  oscP5.plug(environment,"setR2",    "/model/r2");
    
  oscP5.plug(environment,"setSCL",   "/model/scale");
  oscP5.plug(environment,"setRXS",   "/model/rxs");
  oscP5.plug(environment,"setRXSM",  "/model/rxsm");
  oscP5.plug(environment,"setRYSM",  "/model/rysm");
  oscP5.plug(environment,"setASF",   "/model/asf");
}
void oscEvent(OscMessage theOscMessage) {
  /* with theOscMessage.isPlugged() you check if the osc message has already been
   * forwarded to a plugged method. if theOscMessage.isPlugged()==true, it has already 
   * been forwared to another method in your sketch. theOscMessage.isPlugged() can 
   * be used for double posting but is not required.
  */  
  if(theOscMessage.isPlugged()==false) {
  /* print the address pattern and the typetag of the received OscMessage */
  println("### received an osc message.");
  println("### addrpattern\t"+theOscMessage.addrPattern());
  println("### typetag\t"+theOscMessage.typetag());
  }
}
void draw(){
  drawBuffer();
  if(environment.doProcess)shaderStuff();else resetShader();
  image(buffer,0,0,width,height);
}
void shaderStuff(){
  shader.set("resolution", float(width), float(height));
  shader.set("time", frameCount*0.1*.3);  //500.0
  //shader.set("mouse", float(mouseX), float(mouseY));
  shader.set("leftGlitch", environment.leftGlitch);
  shader.set("rightGlitch", environment.rightGlitch);
  shader.set("interlaceF", environment.interlaceF);
  shader.set("hueCyclingF", environment.hueCyclingF);
  shader.set("hShearAmp", environment.hSideShearAmp);
  shader.set("vShearAmp", environment.vSideShearAmp);
  shader.set("micLevel", abs(in.left.get(0)));
  shader(shader);
}
void drawBuffer(){
  buffer.beginDraw();
  buffer.background(240, 255, 255);
  buffer.colorMode(HSB);
  buffer.translate(width/2.0,height/2.0);
  psydreams.draw(buffer);
  buffer.endDraw();
  buffer.updatePixels();
  buffer.beginDraw();
  buffer.tint(255,environment.coverOpacity);
  buffer.image(cover,0,0,buffer.width,buffer.height);
  buffer.endDraw();
  buffer.updatePixels();
}
class Environment{
  boolean doProcess;
  float   coverOpacity;
  float   leftGlitch, rightGlitch;
  float   hueCyclingF;
  float   interlaceF;
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
    hueCyclingF    = 1.0;
    hSideShearAmp = 1.0;
    vSideShearAmp = 1.0;
    
    bgMode        = 1;
    interlaceF    = 1.0;
    
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
  
  void setDo(float v)   {  doProcess                 = v!=0;                      }
  void setCop(float v)  {  coverOpacity              = map(v,0.0,1.0,0,255);      }
  void setLG(float v)   {  leftGlitch                = map(v,0.0,1.0,-1,1);       }
  void setRG(float v)   {  rightGlitch               = map(v,0.0,1.0,-1,1);       }
  void setHC(float v)   {  hueCyclingF               = map(v,0.0,1.0,0,1);        }
  void setInter(float v){  interlaceF                = map(v,0.0,1.0,0.0,2.0);   }
  void setHSA(float v)  {  hSideShearAmp             = map(v,0.0,1.0,0,1);        }
  void setVSA(float v)  {  vSideShearAmp             = map(v,0.0,1.0,0,1);        }
    
  void setBgm(float v)  {  bgMode                    = (int)map(v,0.0,1.0,0,16);  }
 
  void setCols(float v) {  modelCols                 = (int)map(v,0.0,1.0,1,36);  }
  void setRoWs(float v) {  modelRows                 = (int)map(v,0.0,1.0,1,18);  }
  void setR1(float v)   {  modelR1                   = map(v,0.0,1.0,0,800);      }
  void setR2(float v)   {  modelR2                   = map(v,0.0,1.0,0,800);      }
    
  void setSCL(float v)  {  scaleModel                = map(v,0.0,1.0,1.0,4.0);    }
  void setRXS(float v)  {  rotateXSpeed              = map(v,0.0,1.0,0.0,PI/3.0); }
  void setRXSM(float v) {  rotateXSpeedMultiplicator = map(v,0.0,1.0,0,1);        }
  void setRYSM(float v) {  rotateYSpeedMultiplicator = map(v,0.0,1.0,0,1);        }
  void setASF(float v)  {  audioScaleFactor          = map(v,0.0,1.0,0,1);        }
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
    //pg.translate(pg.width/2, pg.height/2);
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
