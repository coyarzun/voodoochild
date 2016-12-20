class VLoogoo extends VScreen{
  ArrayList glows;
  BlobWorld blobworld;

  boolean logon, glowson;
  boolean morelineson;
  PGraphics pg;
  float scalevalue;
  float auxxoff, auxyoff;
  float outerscalevalue = 1;
  
  
  VLoogoo(int _x, int _y, int _width, int _height){
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
    
    alfa = 0; toalfa = 255;
  }
  void outerscale(float s){
    outerscalevalue = s;
  }
  void glowsRoutine(){
    //glows = new VShape();
    glows = new ArrayList();
    blobworld = new BlobWorld("visuals/loogoo.xml");
    for(int i=0; i<blobworld.blobs.length; i++){
      //blobs[i].draw();
      VShape tmp = new VShape();
      for(int j=0; j<blobworld.blobs[i].points.length; j++){
        tmp.addLine(
        blobworld.blobs[i].points[j].x,
        blobworld.blobs[i].points[j].y,
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].x,//+random(-10,10),
        blobworld.blobs[i].points[(j+1)%blobworld.blobs[i].points.length].y//+random(-10,10)
        );
      }
      tmp.setStrokeWeight(1);

      //tmp.translate(auxxoff,auxyoff);


      //tmp.translate(-120/(2/scalevalue),-(250-100)/(2/scalevalue));      
      //tmp.translate(auxxoff,auxyoff);
      float sscalevalue = 1;
      tmp.scale(sscalevalue/2);//;//-120,-(250-100));

      tmp.translate(-120/(2*sscalevalue),-(250-100)/(2*sscalevalue));
      tmp.translate(auxxoff*sscalevalue,auxyoff*sscalevalue);
      //tmp.translate(pg.width/2,pg.height/2);

      tmp.startRun(2, tmp.perimeter*.3);
      glows.add(tmp);
    }
  }
  void draw(PGraphics pg){
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(0,alfa);
    pg.translate(pg.width/2,pg.height/2);
    pg.pushMatrix();
    pg.scale(outerscalevalue);
    pg.scale(scalevalue);
    pg.pushMatrix();
    pg.noSmooth();
    for(int i=0; i<glows.size(); i++){
      VShape tmp = (VShape)glows.get(i);
      //pg.translate(-(720-512)/2,-(768-384)/2);
      //pg.translate((720-pg.width)/4,(768-pg.height)/4);
      //
      //pg.scale(scalevalue);//
      tmp.draw(pg);//, outerscalevalue);
    }
    pg.stroke(255);
    pg.popMatrix();

    if(logon){
      pg.pushMatrix();

      //pg.scale(scalevalue);
      pg.translate(auxxoff,auxyoff);
      //pg.translate(auxxoff/scalevalue,auxyoff/scalevalue);
      //pg.translate(auxxoff,auxyoff);//(720-pg.width)/4,(768-pg.height)/4);
      //pg.smooth();
      loogoo(pg);
      pg.popMatrix();
    }
    vplayer.draw(pg);
    pg.popMatrix();
    
  }
  void loogoo(PGraphics pg){
    pg.pushMatrix();
    pg.strokeJoin(ROUND);
    pg.strokeCap(ROUND);
    //pg.scale(2);
    for(int j=0; j<2; j++){
      pg.stroke(j==0?
      color(4*frameCount%255,255,255,220)
        :255);// color(random(100,120),255,random(128,255),128):0);//color(random(255),255,255));//color(255,0,0));
      pg.noFill();
      //pg.fill(0);//,255,255);
      //if(j==0)//pg.fill(0);else pg.noFill();
      pg.strokeWeight(2-j);//*2);
      //V
      pg.pushMatrix();
      //pg.stroke(255);
      //pg.fill(0);//
      pg.translate(5,5);
      pg.beginShape();
      pg.vertex(10-5,0+10-10);
      pg.vertex(20,20+10);
      pg.vertex(35+5,20+10);
      pg.vertex(45,40);
      pg.vertex(55,40);
      //pg.vertex(50,50);
      pg.vertex(72.5,5);
      pg.vertex(107.5,5);
      pg.vertex(105,0);
      pg.vertex(75,0);
      pg.vertex(65,0);
      pg.vertex(50,30);
      pg.vertex(35+5-5,0+10-10);
      pg.endShape(CLOSE);


      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<5;i++){
          pg.beginShape();
          pg.vertex(10+5+1.1*(5-i),20+2*(5-i));
          pg.vertex(40+1.1*i,20+2*(5-i));
          pg.vertex(50,50-4*i);
          pg.vertex(50+15-2*i,20);
          pg.endShape();
        }
      }

      pg.popMatrix();
      //O
      pg.pushMatrix();
      //pg.stroke(255);
      //pg.fill(0);//
      pg.translate(5,5);
      pg.translate(70,10);
      pg.beginShape();
      pg.vertex(5,0);
      pg.vertex(0,10);
      pg.vertex(10,30);
      pg.vertex(20,30);
      //pg.vertex(15,40);
      pg.vertex(30,10);
      pg.vertex(25,0);
      pg.endShape(CLOSE);
      //o calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(8,10);
      pg.vertex(15,24);
      pg.vertex(22,10);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<4;i++){
          pg.beginShape();
          pg.vertex(0+2*i,10);
          pg.vertex(15,40-4*i);
          pg.vertex(15+15-2*i,10);
          pg.endShape();
        }
      }
      pg.popMatrix();


      //O 2
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(95,10);
      pg.beginShape();
      pg.vertex(10,10);
      //pg.vertex(15,0);
      pg.vertex(0,30);
      pg.vertex(5,40);
      pg.vertex(25,40);
      pg.vertex(30,30);
      pg.vertex(20,10);
      pg.endShape(CLOSE);
      //pg.fill(255);//
      //o calatto
      pg.beginShape();
      pg.vertex(8,30);
      pg.vertex(22,30);
      pg.vertex(15,16);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<4;i++){
          pg.beginShape();
          pg.vertex(0+2*i,10+20);
          pg.vertex(15,0+4*i);
          pg.vertex(15+15-2*i,10+20);
          pg.endShape();
        }
      }
      pg.popMatrix();

      //D
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(70+40,0);
      pg.beginShape();
      pg.vertex(0,0);
      pg.vertex(20,40);
      pg.vertex(30,40);
      //pg.vertex(25,50);
      pg.vertex(45,10);
      pg.vertex(40,0);
      pg.endShape(CLOSE);
      //D calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(10+8,10+10);
      pg.vertex(10+15,10+24);
      pg.vertex(10+22,10+10);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<4;i++){
          pg.beginShape();
          pg.vertex(10+2*i,10+10);
          pg.vertex(25,40+10-4*i);
          pg.vertex(25+15-2*i,10+10);
          pg.endShape();
        }
      }

      pg.popMatrix();

      //O 3
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(60+75+10,10);
      pg.beginShape();
      pg.vertex(10,10);
      //pg.vertex(15,0);
      pg.vertex(0,30);
      pg.vertex(5,40);
      pg.vertex(25,40);
      pg.vertex(30,30);
      pg.vertex(20,10);
      pg.endShape(CLOSE);
      //o calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(8,30);
      pg.vertex(22,30);
      pg.vertex(15,16);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<4;i++){
          pg.beginShape();
          pg.vertex(0+2*i,10+20);
          pg.vertex(15,0+4*i);
          pg.vertex(15+15-2*i,10+20);
          pg.endShape();
        }
      }
      pg.popMatrix();

      //O4
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(85+75+10,10);
      pg.beginShape();
      pg.vertex(5,0);
      pg.vertex(0,10);
      pg.vertex(10,30);
      pg.vertex(20,30);
      //pg.vertex(15,40);
      pg.vertex(30,10);
      pg.vertex(25,0);
      pg.endShape(CLOSE);
      //o calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(8,10);
      pg.vertex(15,24);
      pg.vertex(22,10);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<4;i++){
          pg.beginShape();
          pg.vertex(0+2*i,10);
          pg.vertex(15,40-4*i);
          pg.vertex(15+15-2*i,10);
          pg.endShape();
        }
      }
      pg.popMatrix();

      //C
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(55,55);
      pg.beginShape();
      pg.vertex(5,0);
      pg.vertex(0,10);
      pg.vertex(15,40);
      pg.vertex(25,40);
      //pg.vertex(20,50);
      pg.vertex(25,40);

      pg.vertex(30,30);
      pg.vertex(20,30);
      pg.vertex(10,10);
      pg.vertex(15,10);
      pg.vertex(20,20);
      pg.vertex(35,20);
      pg.vertex(45,0);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<5;i++){
          pg.beginShape();
          pg.vertex(5+2*i,10+10);
          pg.vertex(20,40+10-4*i);
          pg.vertex(25-i,30+10-2*i);//20,40+10-4*i);
          pg.vertex(25+i,30+10-2*i);

          pg.endShape();
        }
      }
      pg.popMatrix();
      //hI
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(55+40,55);
      pg.beginShape();
      pg.vertex(10,0);
      pg.vertex(7.5,5);
      pg.vertex(32.5,5);
      pg.vertex(35,0);
      pg.endShape(CLOSE);

      pg.beginShape();
      pg.vertex(20-15,10);
      pg.vertex(0-15,50);
      pg.vertex(10-15,50);
      pg.vertex(10-15+5,50-10);
      pg.vertex(10-15+5+5,50-10);

      pg.vertex(0,50);
      pg.vertex(10,50);
      pg.vertex(30,10);
      pg.vertex(20,10);

      pg.vertex(10-15+5+5+5,50-10-10);
      pg.vertex(10-15+5+5,50-10-10);
      pg.vertex(30-15,10);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,255,255);
        pg.noFill();
        for(int i=1; i<12; i++){
          //pg.line();
          if(!(i>=4 && i<=8)){
            pg.line(+2.1*i-1,   10+10+2,
            -15+2.1*i,    50
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
      pg.translate(5,5);
      pg.translate(55+40+15,55);
      pg.beginShape();
      pg.beginShape();
      pg.vertex(20,10);
      pg.vertex(5,40);
      pg.vertex(10,50);
      //pg.vertex(0,50);
      pg.vertex(35,50);
      pg.vertex(40,40);
      pg.vertex(15,40);
      pg.vertex(30,10);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<5; i++){
          pg.beginShape();
          pg.vertex(22+.2+2*(1-i),10+2+10);
          pg.vertex(9+3*(2-i),42-2*(1-i));
          pg.vertex(37 + (1-i),42-2*(1-i));
          pg.endShape();
        }
      }

      pg.popMatrix();

      //D
      pg.pushMatrix();
      //pg.fill(0);//
      //pg.stroke(255);
      pg.translate(5,5);
      pg.translate(55+40+30+15,55);
      pg.beginShape();
      pg.vertex(0,0);
      pg.vertex(20,40);
      pg.vertex(30,40);
      //pg.vertex(25,50);
      pg.vertex(45,10);
      pg.vertex(40,0);
      pg.endShape(CLOSE);
      //D calatto
      //pg.fill(255);//
      pg.beginShape();
      pg.vertex(10+8,10+10);
      pg.vertex(10+15,10+24);
      pg.vertex(10+22,10+10);
      pg.endShape(CLOSE);

      if(morelineson){
        //pg.stroke(255,0,0);
        pg.noFill();
        for(int i=1; i<4;i++){
          pg.beginShape();
          pg.vertex(10+2*i,10+10);
          pg.vertex(25,40+10-4*i);
          pg.vertex(25+15-2*i,10+10);
          pg.endShape();
        }
      }
      pg.popMatrix();
    }
    pg.popMatrix();

    pg.endDraw();

  }

  void keyPressed(){
    if(key=='z')logon=!logon;
    if(key=='x')halloesOn=!halloesOn;
    if(key=='c')innerOn=!innerOn;
    if(key=='v')morelineson=!morelineson;
  }

}









