class Skreener{
  Splash splash;
  Txtoutput txtoutput;
  PImage lyric = loadImage("mono_splash.png");
  
  Skreener(){
    splash = new Splash();
    //splash.fadein();
    txtoutput = new Txtoutput();
  }
  void draw(){
    background(0);//255,128,0);
    image(lyric,0,0);
    //splash.draw();
    txtoutput.draw();
  }
  void songon(int $1){
    switch($1){
      case 0:
          lyric = loadImage("songzero.png");
          break;
      case 1:
            lyric = loadImage("anemic.png");
            break;
      case 2:
            lyric = loadImage("forest.png");
            break;
      case 3:
            lyric = loadImage("ahardplace.png");
            break;
    }
    splash.fadeout();
  }
  void songoff(){
    splash.fadein();
  }
}

class Splash{
  PImage buffer;
  PImage splashon, blender;
  int fadespeed = 0;
  int falpha = 0;
  
  Splash(){
    buffer = loadImage("mono_splash.png");
    splashon = new PImage(buffer.width, buffer.height, ARGB);
    fadein();
  }
  void draw(){
   if(fadespeed!=0){ 
     falpha+=fadespeed;
     if(falpha<0){
       falpha = 0;
       fadespeed = 0;
     }
     if(falpha>255){
       falpha = 255;
       fadespeed = 0;
     }
     splashon.loadPixels();
     buffer.loadPixels();
     for(int i=0; i<splashon.pixels.length; i++){
       color p = buffer.pixels[i];
       splashon.pixels[i] = color(red(p),green(p),blue(p),falpha);
     }
     splashon.updatePixels();
     buffer.updatePixels();
   }

   if(falpha>0)image(splashon, 0, 0);
  }
  void fadein(){
    fadespeed = 16;
  }
  void fadeout(){
    fadespeed = -16;
  }
}

class Txtoutput{
  PFont myFont;
  String display = "HELLOWORLD";
  String bars = "";
  String tempo = "";
  String frame = "";
  
  Txtoutput(){
    myFont = createFont("coyarzunAtari _normal", 8);
    textFont(myFont);
  }
  void draw(){
    fill(0);
    pushMatrix();
    translate(0,height-12);
    rect(0,0,width,12);
    fill(255);
    text(display, 2, 10);
    text(bars, 200, 10);
    text(tempo, 300, 10);
    text(frame, 380, 10);
    popMatrix();
  }
}

