class VScreen extends Rectangle{
  PFont font;
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
  
  VScreen(){
  }
  VScreen(int _x, int _y, int _width, int _height){
    x = _x;
    y = _y;
    width  = _width;
    height =  _height;
    pg = createGraphics((int)width, (int)height, P2D);
  }
  void draw(PGraphics pg){
  }
  void mouseMoved(){
    if(mouseX>=x && mouseX<x+width && mouseY>=y && mouseY<y+height){
      if(showCursor){
        noCursor();
      }
      else{
        noCursor();
      }
    }
  }
  void fadein(){
    toalfa = 255;
  }
  void fadeout(){
    toalfa = 0;
  }
  void fade(){
    dalfa = (toalfa-alfa)*.12;
    alfa+=dalfa;
  }
  void addLyric(String l){
    lastlyric = l;
    vislyric = " "+lastlyric+" ";
    
    vl = vislyric.length();
    vislyric+=" *** ";
    
    lyricop = 180;
    lyricd  = 1.012;
  }
}
class Rectangle{
  float x,y,width,height;
  Rectangle(){
  }
}
class Point{
  float x,y;
  Point(){
  }
  Point(float _x, float _y){
    x = _x; y = _y;
  }
}
