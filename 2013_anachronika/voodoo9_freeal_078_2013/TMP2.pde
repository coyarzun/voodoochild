class GuemboiV{

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
    cosmos, cordillera, edificiosatras, edificios, arbolesatras, postes, panderetas, arbolesfrente, primerplano, rejas, groundx                                                };

  float[] planes_faktor = {
    1, .9, .6, .55, .36, .25, .18, .14, 0, -.5, -.5                                                };
  float[] planes_skroll = {
    0, 1024, 1024, 1024, 1024, 1024, 1024, 832, 722, 960, 1024                                                };
  float[] planes_xx = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0                                                };

  Slideclip pivote;

  float cam_xoff, cam_yoff, dcam_xoff, dcam_yoff, cam_friction;
  float xx, speed, dspeed, tospeed, maxspeed, speedfriction;

  float direction, olddirection;

  Pacos pacos;
  Encapuxaos encapuxaos;
  Molotovs molotovs;

  GuemboiV(){
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

    pacos = new Pacos(200,5);
    encapuxaos = new Encapuxaos(-200,5);
    molotovs = new Molotovs();
  }
  void draw(PGraphics pg){
    pg.pushMatrix();
    //pg.scale(2);
    pg.translate(-pg.width/2,-pg.height/2);

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
    for(int i=0;i<planes_array.length;i++){

      planes_array[i].x = cam_xoff*planes_faktor[i];
      planes_array[i].y = cam_yoff*planes_faktor[i];
      //
      float pfaktor = -(planes_faktor[i]-1);
      planes_xx[i] += speed*pfaktor;
      if(planes_xx[i]<-planes_skroll[i])planes_xx[i]+=planes_skroll[i];
      if(planes_xx[i]>0)planes_xx[i]-=planes_skroll[i];
      //planes_mcxx[i]._x = planes_xx[i];
      planes_array[i].xtra_x = planes_xx[i];
      if(i==8){
        pacos.draw(pg);
        encapuxaos.draw(pg);
        molotovs.draw(pg);
      };
      /*if(i==0){
       planes_array[i].draw(pg);
       }else if(random(10)>8){*/
      planes_array[i].draw(pg);
      if(i==10){
        pg.fill(0);//64,255,255);
        pg.noStroke();
        pg.rectMode(CORNER);
        pg.rect(0,500,800,100);
      } 
      //}
    }

    cosmos.rotation-=radians(20);
    pg.popMatrix();
  }

  class Slideclip{
    float x = 0;
    float xtra_x = 0;
    float y = 0;
    PImage img;
    String name;
    float xoff, yoff;
    float rotation = 0;

    Slideclip(String $1, float $2, float $3){
      img = loadImage($1);
      xoff = $2; 
      yoff = $3;
    }
    void draw(PGraphics pg){
      pg.pushMatrix();
      pg.translate(400,300);
      pg.rotateZ(rotation);
      pg.translate(xoff, yoff);
      pg.translate(-img.width*.5, -img.height*.5);
      pg.translate(x+xtra_x, y);
      pg.translate(0, img.height);
      pg.image(img,0,0);
      pg.image(img,img.width,0);
      pg.popMatrix();
    }
  }


  class Encapuxaos{
    ArrayList grupo;
    float xbase;
    float x, tox, dx, friction;
    int cuantos;
    int current;
    boolean attackFlag;

    Encapuxaos(float xbase, int cuantos){
      this.xbase = xbase;
      x = 0;
      tox = x;
      dx = 0;
      friction = .6;//.16;
      this.cuantos = cuantos;
      grupo = new ArrayList();
      for(int i=0; i<cuantos; i++){
        grupo.add(new Encapuxao(random(-100, 100)));
      }
    }
    void draw(PGraphics pg){
      update();
      pg.pushMatrix();
      pg.translate(400,300+84);
      pg.translate(xbase+x,0);
      boolean areCurrent=false;
      for(int i=0; i<grupo.size(); i++){
        Encapuxao tmp = (Encapuxao)grupo.get(i);      
        if(tmp.isDead){
          grupo.remove(i);
        }
        else{
          if(tmp.isCurrent){
            areCurrent = true;
          }
          else{
            tmp.draw(pg);
          }
        }
      }
      if(!areCurrent)setCurrent();
      Encapuxao upper = (Encapuxao)grupo.get(current);
      upper.draw(pg);
      pg.popMatrix();
    }
    void setCurrent(){
      int ncurrent = current;
      while(ncurrent ==current){
        ncurrent = (int)random(grupo.size());
      }
      current = ncurrent;
      Encapuxao tmp = (Encapuxao)grupo.get(current);
      tmp.isCurrent = true;
    }
    void update(){
      dx = tox - x;
      if(abs(dx)<1)tox = random(-200,0);
      x += dx*friction;

      if(!attackFlag && random(100)>95){
        attack();
      }
    }
    void attack(){
      Encapuxao tmp = (Encapuxao)grupo.get(current);
      tmp.attack();
      attackFlag = true;
    }

    class Encapuxao{
      PImage[] skin;
      float x, tox, dx, friction;
      boolean isDead;
      int direction = 1;
      int olddirection = 1;
      int pdirection = 1;
      boolean isCurrent = false;
      boolean isAttacking = false;
      int attackframe;

      Encapuxao(float x){
        this.x = x;
        tox = x;
        dx = 0;
        friction = .96;
        skin = new PImage[3];
        skin[0] = loadImage("visuals/ahardplace/encapuchao_nada.png");
        skin[1] = loadImage("visuals/ahardplace/encapuchao.png");
        skin[2] = loadImage("visuals/ahardplace/encapuchao_throw.png");
      }
      void draw(PGraphics pg){
        update();
        pg.pushMatrix();
        pg.translate(x,0);
        pg.scale(.4);
        if((olddirection==-1 && direction==0)||direction==-1){
          pdirection=-1;
        }
        else if((olddirection==1 && direction==0)||direction==1){
          pdirection=1;
        }
        if(pdirection==-1)pg.rotateY(-PI);

        if(isCurrent){
          pg.noTint();
          pg.noStroke();
          pg.fill(255);
          pg.triangle(0,-170,-20,-200,20,-200);
          pg.pushMatrix();
          if(pdirection==-1)pg.rotateY(-PI);
          pg.text("P1", -32, -200);
          pg.popMatrix();
        }
        else{
          if(frameCount%3==0){
            pg.tint(255, 0 , 0);
          }
          else if(frameCount%3==1){
            pg.tint(255);
          }
          else{
            pg.tint(0);
          }
        }

        PImage cskin;
        if(isCurrent){
          if(attackframe>20){
            cskin = skin[1];
          }
          else if(attackframe>10){
            cskin = skin[2];
          }
          else{
            cskin = skin[0];
          }
        }
        else{
          cskin = skin[0];
        }
        pg.translate(-cskin.width*.5,-cskin.height);
        pg.image(cskin,0,0);
        pg.popMatrix();
        olddirection = direction;
        pg.noTint();
      }
      void update(){
        if(!isAttacking){
          if((dx>=0 && x>=tox) || (dx<=0 && x<=tox)){
            tox = random(-100,100);
            if(tox>x){
              dx=4;
              direction = 1;
            }
            else if(tox<x){
              dx=-4;
              direction = -1;
            }
            else{
              dx=0;
              direction = 0;
            }
          }
          x += dx;
        }
        else{
          if(attackframe==20)molotovs.addMolotov(x);
          if(attackframe>6)x += dx;
          attackframe--;
          if(attackframe<=0)endAttack();
        }
      }
      void attack(){
        isAttacking = true;
        direction = 1;
        dx = 8;
        attackframe = 40;
      }
      void endAttack(){
        isCurrent = false;
        isAttacking = false;
        direction = -1;
        tox = -100;
        attackframe = 0;
        attackFlag = false;
      }
    }

  }



  class Pacos{
    ArrayList grupo;
    float xbase;
    float x, tox, dx, friction;
    int cuantos;
    int current;
    boolean attackFlag;

    Pacos(float xbase, int cuantos){
      this.xbase = xbase;
      x = 0;
      tox = x;
      dx = 0;
      friction = .6;
      this.cuantos = cuantos;
      grupo = new ArrayList();
      for(int i=0; i<cuantos; i++){
        grupo.add(new Paco(random(-100, 100)));
      }
    }
    void draw(PGraphics pg){
      update();
      pg.pushMatrix();
      pg.translate(400,300+84);
      pg.translate(xbase+x,0);
      boolean areCurrent=false;
      for(int i=0; i<grupo.size(); i++){
        Paco tmp = (Paco)grupo.get(i);      
        if(tmp.isDead){
          grupo.remove(i);
        }
        else{
          if(tmp.isCurrent){
            areCurrent = true;
          }
          else{
            tmp.draw(pg);
          }
        }
      }
      if(!areCurrent)setCurrent();
      if(current>=grupo.size())current=grupo.size()-1;
      Paco upper = (Paco)grupo.get(current);
      upper.draw(pg);
      pg.popMatrix();
    }
    void setCurrent(){
      int ncurrent = current;
      while(ncurrent ==current ){
        ncurrent = (int)random(grupo.size());
      }
      current = ncurrent;
      Paco tmp = (Paco)grupo.get(current);
      if(!tmp.isDead)
        tmp.isCurrent = true;
      else
        setCurrent();
    }
    void update(){
      dx = tox - x;
      if(abs(dx)<1)tox = random(-50,200);
      x += dx*friction;

      if(!attackFlag && random(100)>95){
        attack();
      }
    }
    void attack(){
      Paco tmp = (Paco)grupo.get(current);
      tmp.attack();
      attackFlag = true;
    }

    class Paco{
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

      Paco(float x){
        this.x = x;
        tox = x;
        dx = 0;
        friction = .96;
        skin = new PImage[3];
        skin[0] = loadImage("visuals/ahardplace/ffee.png");
        skin[1] = loadImage("visuals/ahardplace/ffee_2.png");
        skin[2] = loadImage("visuals/ahardplace/ffee.png");
      }
      void draw(PGraphics pg){
        update();
        pg.pushMatrix();
        pg.translate(x,0);
        pg.scale(.4);
        if((olddirection==-1 && direction==0)||direction==-1){
          pdirection=-1;
        }
        else if((olddirection==1 && direction==0)||direction==1){
          pdirection=1;
        }
        if(pdirection==-1)pg.rotateY(-PI);

        if(isCurrent){
          pg.noTint();
          pg.noStroke();
          pg.fill(255);
          pg.triangle(0,-170,-20,-200,20,-200);
          pg.pushMatrix();
          if(pdirection==-1)pg.rotateY(-PI);
          pg.text("P2", -32, -200);
          pg.popMatrix();
        }
        else{
          if(frameCount%3==0){
            pg.tint(255, 0 , 0);
          }
          else if(frameCount%3==1){
            pg.tint(255);
          }
          else{
            pg.tint(0);
          }
        }

        PImage cskin;
        if(isCurrent){
          if(attackframe>2){
            if(frameCount%10<=5){
              cskin = skin[1];
            }
            else{
              cskin = skin[0];
            }
          }
          else{
            cskin = skin[0];
          }
        }
        else{
          cskin = skin[0];
        }
        pg.translate(-cskin.width*.5,-cskin.height);
        pg.image(cskin,0,0);
        pg.popMatrix();
        olddirection = direction;
        pg.noTint();
      }
      void update(){
        if(!isAttacking){
          if((dx>=0 && x>=tox) || (dx<=0 && x<=tox)){
            tox = random(-100,100);
            if(tox>x){
              dx=4;
              direction = 1;
            }
            else if(tox<x){
              dx=-4;
              direction = -1;
            }
            else{
              dx=0;
              direction = 0;
            }
          }
          x += dx;
        }
        else{
          if(attackframe>6)x += dx;
          attackframe--;
          if(attackframe<=0)endAttack();
        }
      }
      void attack(){
        isAttacking = true;
        direction = -1;
        dx = -8;
        attackframe = 60;
      }
      void endAttack(){
        isCurrent = false;
        isAttacking = false;
        direction = 1;
        tox = 100;
        attackframe = 0;
        attackFlag = false;
      }
      void goneToHeaven(){
        isGoneToHeaven = true;
        isCurrent = false;
        isAttacking = false;
      }
      void damage(){
        life--;
        if(life<=0){
          isDead = true;
          isCurrent = false;
          isAttacking = false;
        }
      } 
    }

  }

  class Molotovs{
    ArrayList mismolotovs;
    Molotovs(){
      mismolotovs = new ArrayList();
    }
    void draw(PGraphics pg){
      for(int i=0; i<mismolotovs.size(); i++){
        Molotov tmp = (Molotov)mismolotovs.get(i);
        if(tmp.isDead){
          mismolotovs.remove(i);
        }
        else{
          tmp.draw(pg);
        }
      }
    }
    void addMolotov(float x){
      try{
        mismolotovs.add(new Molotov(x));
      }catch(Exception e){
        println("fiuu");
      }
    }
    class Molotov{
      float x,y;
      float tox, toy, dx, dy, friction;
      PImage[] skin;
      boolean isDead, isXplode;
      int xplodelife;

      Molotov(float x){
        this.x = x+encapuxaos.x;
        tox = this.x + 300;
        friction = .4;
        skin = new PImage[3];
        skin[0] = loadImage("visuals/ahardplace/molotov.png");
        skin[1] = loadImage("visuals/ahardplace/molotovxplode1.png");
        skin[2] = loadImage("visuals/ahardplace/molotovxplode2.png");
      }
      void draw(PGraphics pg){
        pg.pushMatrix();
        pg.translate(400,300+84);
        pg.translate(encapuxaos.xbase+encapuxaos.x,0);
        pg.translate(x,y);
        pg.scale(.4);
        PImage cskin;
        if(!isXplode){
          cskin = skin[0];
        }
        else{
          cskin = skin[1+frameCount%2];
        }
        pg.translate(-cskin.width*.5,-cskin.height);
        pg.image(cskin, 0, 0);
        pg.popMatrix();
        update();
      }
      void update(){
        dx = tox-x;
        dy = (1-dx/300)*20;
        x+= dx*friction;
        if(y<=24){
          y+=dy;
        }
        else if(!isXplode){
          xplode();
        }
        else{
          xplodelife--;
          if(xplodelife<=0)isDead = true;
        }
        //check collisions
        for(int i=0; i<pacos.grupo.size();i++){
          Pacos.Paco tmp = (Pacos.Paco)pacos.grupo.get(i);
          float cx = pacos.x+tmp.x;
          if(x>=cx-40 && x<=cx+40){
            xplode();
            //tmp.damage();
            break;
          }
        }
      }
      void xplode(){
        isXplode = true;
        xplodelife = 200;
      }
    }
  }
}

class Anemiko{
  int cycles;
  float rotation, faktor, ratio; 
  int frameaux = 0;

  String ticker;
  String txt = "";
  float txtslide = 0;

  color[] colors;

  Anemiko(color[] c){//1, color c2, color c3){
    rotation = 0;
    cycles = 32;//zpectral.bufferSize;
    faktor = .8;
    ratio = width*.75;
    colors = c;/*new color[3];
     colors[0] = c1;
     colors[1] = c2;
     colors[2] = c3;*/
  }

  void draw(PGraphics pg){
    pg.pushMatrix();
    //colorMode(RGB, 255);
    //background(0);
    //translate(width*.5, height*.8);
    pg.translate(width*.0, height*.3);

    pg.pushMatrix();
    pg.rotateZ(rotation);

    //float percent=0;//max(0,(zpectral.myFFT.max-zpectral.minLimit)/zpectral.limitDiff);
    pg.scale(6);//+percent/100);

    for(int i=0; i<cycles; i++){
      int sign;
      if(i%2==0){
        sign=1;
      }
      else{
        sign=-1;
      };

      for(int j=0; j<colors.length; j++){
        if(i%colors.length==j){
          for(int k=0; k<colors.length; k++){
            if(frameaux%colors.length==k){
              pg.fill(colors[j]);
              break;
            }
          }
          break;
        }
      }

      pg.noStroke();
      if(i>0 && i%3!=0){
        pg.scale(faktor);
        pg.translate(0,sign*ratio*.25*.9);
      }
      else{
        pg.scale(faktor);//.95);
      }

      //float spc = 1;//+zpectral.myFFT.spectrum[i];
      float spc = 2;
      if(i%3==0){
        spc-=session.zong.beatMap.kick.currentside/100;
      }
      else if(i%3==1){
        spc-=session.zong.beatMap.snare.currentside/100;       
      }
      else{
        spc-=session.zong.beatMap.hat.currentside/100;
      }
      pg.ellipse(0,0,2*ratio*spc,2*ratio*spc);
    }
    rotation+=PI/30;

    pg.popMatrix();
    pg.popMatrix();
  }
}


class Emo{
  int w, h;
  float cellw, cellh;
  PImage[] zqnce;
  int frame = 0;

  Emo(){
    w = 100; 
    h = 50;
    cellw = 800/w;
    cellh = 600/h;
    zqnce = new PImage[28];
    for(int i=0; i<zqnce.length; i++){
      zqnce[i]=loadImage("visuals/punkrocker/donfrancischavo_"+nf(i+1,4)+".gif");
    }

  }  
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(-pg.width/2,-pg.height/2);
    pg.noStroke();
    pg.translate(cellw/2, cellh/2);
    zqnce[frame].loadPixels();
    for(int i=0; i<w; i++){
      for(int j=0; j<h; j++){
        int m = int((i+j*w)%random(50));
        //float spc = 0;//2*zpectral.myFFT.spectrum[m];//*PI;
        float spc = i<w/2 ? session.zong.beatMap.kick.currentside/100 : session.zong.beatMap.snare.currentside/100;
        color k = zqnce[frame].pixels[i+j*w];
        pg.pushMatrix();
        pg.translate(i*cellw,j*cellh);
        pg.scale(spc);
        dddot(k,pg);
        pg.popMatrix();
      }
    }
    pg.filter(POSTERIZE, 4);
    frame++;
    if(frame>zqnce.length-1)frame=0;
    pg.popMatrix();
  }
  void dddot(color k, PGraphics pg){
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
  void ddot(PGraphics pg){
    pg.ellipse(0,0,cellw,cellh);
  }
}






class Flag{
  PImage[] flags;
  PImage world;
  int total, kurrent;
  int w, h;
  int spacing;
  int f = 0;
  PFont myFont;
  String txt;
  float txtslide = 0;

  Flag(){
    myFont = loadFont("CoyarzunAtarinormal-8.vlw");
    world = loadImage("visuals/antarctic/flag/world_bn.gif");

    total = 245;
    flags = new PImage[total];
    for(int i=0; i<total; i++){
      String tmp = "";
      tmp+= i;
      if(i<10)tmp="0"+tmp;
      if(i<100)tmp="0"+tmp;
      tmp+="_48.gif";
      tmp = "visuals/antarctic/flag/"+tmp;
      flags[i] = loadImage(tmp);
    };
    kurrent = int(random(total));

    txt = "CON LA AUTORIDAD QUE NOS DA EL BUEN JUICIO Y EN PLENO USO DE NUESTRA RAZON, DECLARAMOS ROMPER EN FORMA OFICIAL LOS LAZOS QUE NOS PUDIERON ATAR ALGUNA VEZ A UNA SOLA INSTITUCION O FORMA DE REPRESENTACION QUE NOS DECLARE PARTE DE SU TOTAL.CON TODA HONESTIDAD Y CON LA MENTE FRIA RENEGAMOS DE CUALQUIER PATRON. YA TODAS LAS DIVISAS NOS DAN INDIFERENCIA, RENEGAMOS DEL CUALQUIER COLOR, SE LLAME RELIGION,SE LLAME NACIONALIDAD, NO QUEREMOS REPRESENTATIVIDAD.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.ES FACIL VEGETAR, DEJAR QUE OTROS HABLEN Y DECIR ELLOS SABEN MAS QUE YO. PONERSE UNA INSIGNIA,MARCHAR DETRAS DE UN LIDER Y DEJAR QUE NOS ESGRIMAN COMO RAZON.NO VAMOS A ESPERAR, LA IDEA NUNCA NOS GUSTO, ELLOS NO ESTAN HACIENDO LO QUE AL COMIENZO SE PACTO.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.";

  }
  void draw(PGraphics pg){
    pg.pushMatrix();
    pg.translate(-pg.width/2,-pg.height/2);
    pg.noStroke();
    pg.rectMode(CENTER);

    //pg.textFont(myFont,8);

    if(random(100)>90)kurrent = int(random(total));
    w = flags[kurrent].width;
    h = flags[kurrent].height;
    int xspacing = pg.width/(w-4);
    int yspacing = pg.height/(h-4);

    txtslide++;

    for(int i=1; i<w-1; i++){
      for(int j=1; j<h-1; j++){
        pg.pushMatrix();
        int sz;
        pg.translate(-w*.5+(i)*xspacing, -h*.5+(j)*yspacing);
        sz = 2;

        color c = flags[kurrent].pixels[i+j*w];
        color k = world.pixels[i+j*w];

        if(k==-15132391){
          pg.fill(c);
          sz*=1;
        }
        else{
          pg.fill(c, 64);
          sz*=.6;
        }
        int txtoff = int(txtslide)%flags[kurrent].pixels.length;
        int indec = (i+j*w+txtoff)%txt.length();
        String shar = txt.substring(indec, indec+1);
        pg.scale(sz);
        pg.scale(pg.width/800,pg.height/600);
        pg.text(shar, 2, 10);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}


class Antarctic{
  PImage[] flags;
  PImage world;
  int total, kurrent;
  int w, h;
  int spacing;
  PFont myFont;
  String txt;
  float txtslide = 0;

  Antarctic(){
    myFont = loadFont("CoyarzunAtarinormal-8.vlw");
    world = loadImage("visuals/antarctic/flag/world_bn.gif");
    total = 245;
    flags = new PImage[total];
    for(int i=0; i<total; i++){
      String tmp = "";
      tmp+= i;
      if(i<10)tmp="0"+tmp;
      if(i<100)tmp="0"+tmp;
      tmp+="_48.gif";
      tmp = "visuals/antarctic/flag/"+tmp;
      flags[i] = loadImage(tmp);
    };
    kurrent = int(random(total));

    txt = "CON LA AUTORIDAD QUE NOS DA EL BUEN JUICIO Y EN PLENO USO DE NUESTRA RAZON, DECLARAMOS ROMPER EN FORMA OFICIAL LOS LAZOS QUE NOS PUDIERON ATAR ALGUNA VEZ A UNA SOLA INSTITUCION O FORMA DE REPRESENTACION QUE NOS DECLARE PARTE DE SU TOTAL.CON TODA HONESTIDAD Y CON LA MENTE FRIA RENEGAMOS DE CUALQUIER PATRON. YA TODAS LAS DIVISAS NOS DAN INDIFERENCIA, RENEGAMOS DEL CUALQUIER COLOR, SE LLAME RELIGION,SE LLAME NACIONALIDAD, NO QUEREMOS REPRESENTATIVIDAD.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.ES FACIL VEGETAR, DEJAR QUE OTROS HABLEN Y DECIR ELLOS SABEN MAS QUE YO. PONERSE UNA INSIGNIA,MARCHAR DETRAS DE UN LIDER Y DEJAR QUE NOS ESGRIMAN COMO RAZON.NO VAMOS A ESPERAR, LA IDEA NUNCA NOS GUSTO, ELLOS NO ESTAN HACIENDO LO QUE AL COMIENZO SE PACTO.NO NECESITAMOS BANDERAS, NO RECONOCEMOS FRONTERAS, NO ACEPTAREMOS FILIACIONES, NO ESCUCHAREMOS MAS SERMONES.";
  }

  void draw(PGraphics pg){
    if(random(100)>90)kurrent = int(random(total));
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

    for(int i=1; i<w-1; i++){
      for(int j=1; j<h-1; j++){
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

        if(k==-15132391){
          pg.fill(c);
          sz*=1;
        }
        else{
          pg.fill(c, 64);
          sz*=.6;
        }
        int txtoff = int(txtslide)%flags[kurrent].pixels.length;
        int indec = (i+j*w+txtoff)%txt.length();
        String shar = txt.substring(indec, indec+1);

        pg.scale(sz);
        pg.scale(pg.width/800,pg.height/600);
        pg.text(shar, 2, 10);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}

class WOklr{

  WOklr(){

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
    for(int i=0;i<64;i++){//zpectral.bufferSize;i++){
      pg.pushMatrix();
      float left=0;
      float right=0;
      //if (i+zpectral.wave_interp+1<zpectral.myInput.buffer2.length) {
      left-=random(-.2,.2);//zpectral.myInput.buffer2[i+zpectral.wave_interp];
      right-=random(-.2,.2);//zpectral.myInput.buffer2[i+1+zpectral.wave_interp];
      //}
      pg.rotateY(i*dangle);
      pg.rotateZ(left*amp);
      pg.translate(r,0,0);
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
      pg.stroke(i*255/64,255,204);
      pg.noFill();
      float w = 2*r*.6;
      float h = 2*r*.6;
      float fa = (TWO_PI-spc)*.5;
      float ta = fa+spc;
      pg.strokeWeight(1);//.5);
      pg.arc(0,0,w,h,fa,ta);
      pg.rotateY(TWO_PI-(i)*dangle);
      pg.arc(0,0,w,h,fa,ta);
      pg.popMatrix();
      //
      pg.fill(128);
      //box(30);

    }  
    pg.popMatrix();
    pg.popMatrix();
  }
}

class Lnr{

  Lnr(){

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

    for(int i=0;i<64;i++){
      pg.pushMatrix();
      float spc = random(1);//i/64;//(i+1)/64;//i/64;//i/100;
      pg.stroke(spc*255,255,255,random(255));
      pg.noFill();
      float w = 2*r*.6;
      float h = 2*r*.6;
      float fa = (TWO_PI-spc)*.5;
      float ta = fa+spc;
      pg.strokeWeight(1);
      pg.translate(ii,jj,0);
      pg.ellipse(0,0,w*spc,h*spc);
      pg.popMatrix();
      pg.fill(128);
    }  
    pg.popMatrix();
    pg.popMatrix();
  }
}

class AntarcticLogo{
  PImage splash;

  AntarcticLogo(){
    splash = loadImage("visuals/antarctic/flag/antarctic_flagx.jpg");
  }
  void draw(PGraphics pg) {

    pg.pushMatrix();
    pg.translate(-pg.width*.5, -pg.height*.5);
    pg.scale(pg.width/splash.width, pg.height/splash.height);
    pg.image(splash, 0, 0);
    pg.popMatrix();
  }
}

class TScreen{
  String mytext;
  int cols, rows;
  int cell = 8*1;
  int vel = 16;
    color[] colors;
  
  TScreen(color[] c){
    cols = 800/cell;
    rows = 600/cell;
    colors = c;
  }
  void setCell(int k){
    cell = k;
    cols = 800/cell;
    rows = 600/cell;
  }
  void setText(String t){
      mytext=t;
  }
  void setVel(int v){
    vel = v;
  }
  void draw(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(-pg.width/2, -pg.height/2);
    for(int i=0; i<cols;i++){for(int j=0; j<rows; j++){
      int k = i+j*cols;
      
      //pg.fill(colors[k%colors.length]);
      
      k+=frameCount*(j+rows/4)/vel;//+j;
      int l = mytext.length()-1;
      String tmp = l>1? mytext.substring(k%l,k%l+1) : "";

      pg.fill(colors[k%colors.length]);

      pg.pushMatrix();
      pg.translate(i*cell,j*cell+cell);
      pg.scale(cell/8);
      pg.text(tmp,0,0);//i*8,j*8+8);
      pg.popMatrix();
    }}
    pg.popMatrix();
  }

}






class Alebrije{
  float x,y,z;
  float caminangulo;

  PImage[] t;
  int tframes;

  Head head;

  Alebrije(float x, float y, float z){
    this.x=x;
    this.y=y;
    this.z=z;

    head = new Head();

    tframes = 18;
    t = new PImage[tframes];
    for(int i=0; i<tframes;i++){
      t[i] = loadImage("visuals/songzero/twinkling/twinkling_100_f"+nf(i+1, 2)+".gif");
    }
  }
  void draw(PGraphics pg){
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
    pg.ambientLight(16,255,64);//128, 64, 0);
    pg.spotLight(16,255,128, 80, 20, 40, -1, 0, 0, PI/2, 2);//255, 128, 0, 80, 20, 40, -1, 0, 0, PI/2, 2);
    //directionalLight(51, 102, 126, 0, -1, 0);
    pg.pointLight(96/2, 255/2, 240, 0, -500, 1000);//255/2, 200/2, 30/2, 0, -500, 1000);
    //if(random(100)>70);pointLight(240+random(15), 0,0, 0, 0, 2000);
    pg.stroke(16,255,255);//255,128,0);
    float f = 9;//4;
    //caminangulo = radians(60*sin(radians(f*frameCount%360)));
    //float eleva = 20*sin(radians(f*frameCount%360));
    caminangulo = radians(90*sin(radians(f*frameCount%360)));
    float eleva = 40*sin(radians(f*frameCount%360));

    pg.fill(255);
    pg.pushMatrix();
    pg.translate(0,20-abs(eleva),0);
    //torso
    textureBox(pg, current,30,40,10);
    //right napier
    pg.pushMatrix();
    pg.translate(10,20,0);
    pg.rotateX(caminangulo);
    pg.translate(0,10,0);
    textureBox(pg, current,10,20,10);
    pg.popMatrix();
    //left napier
    pg.pushMatrix();
    pg.translate(-10,20,0);
    pg.rotateX(-caminangulo);
    pg.translate(0,10,0);
    textureBox(pg, current,10,20,10);
    pg.popMatrix();


    //middle leg
    pg.pushMatrix();
    float erektangulo = radians(145);
    float dotation = 12;//12;//20;//6;//15;//6;//15;//20;
    float contrapeso = dotation/5;
    float grip = 4;//3;//4;//6; 
    pg.translate(0,20,5);

    pg.pushMatrix();
    pg.rotateX(erektangulo);
    //if(erektangulo<PI/2)
    pg.rotateX(map(erektangulo,radians(15),radians(145),1,0)*abs(caminangulo));
    pg.translate(0,(dotation+contrapeso)/2-contrapeso,-grip/2);
    textureBox(pg, current,grip,dotation+contrapeso,grip);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(-2.5,2.25,-2.5);
    pg.rotateX(caminangulo);
    textureBox(pg, current,4.5);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(2.5,2.25,-2.5);
    pg.rotateX(-caminangulo);
    textureBox(pg, current,4.5);
    pg.popMatrix();
    pg.popMatrix();
    //right arm
    pg.pushMatrix();
    pg.translate(20,-20,0);
    pg.rotateX(-caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0,25,0);
    textureBox(pg, current,10,50,10);
    pg.popMatrix();
    //left arm
    pg.pushMatrix();
    pg.translate(-20,-20,0);
    pg.rotateX(caminangulo);
    pg.rotateZ(-caminangulo/2);
    pg.translate(0,25,0);
    textureBox(pg, current,10,50,10);
    pg.popMatrix();
    //kabeza

    pg.pushMatrix();
    pg.translate(0,-20-5,5);
    //pg.rotateX(caminangulo/4);
    head.draw(pg);

    pg.popMatrix();
    pg.popMatrix();
    pg.popMatrix();
  }



  void textureBox(PGraphics pg, PImage $1, float $2){
    //textureBox(pg, $1, $2, $2, $2);
    pg.box($2);
  }
  void textureBox(PGraphics pg, PImage $1, float $2, float $3, float $4){
    pg.box($2,$3,$4);
  }
  void textureBox(PGraphics pg, PImage $1, float $2, float $3, float $4, boolean $5){
    float xratio, yratio, zratio;
    xratio = $2*.5;
    yratio = $3*.5;
    zratio = $4*.5;
    //front face
    pg.pushMatrix();
    pg.translate(-$2*.5,-$3*.5,zratio);
    pg.image($1, 0, 0, $2, $3);
    pg.popMatrix();
    //top face
    pg.pushMatrix();
    pg.rotateX(HALF_PI);
    pg.translate(-$2*.5,-$4*.5,yratio);
    pg.image($1, 0, 0, $2, $4);
    pg.popMatrix();
    //rear face
    pg.pushMatrix();
    pg.rotateX(PI);
    pg.translate(-$2*.5,-$3*.5,zratio);
    pg.image($1, 0, 0, $2, $3);
    pg.popMatrix();
    //bottom face
    pg.pushMatrix();
    pg.rotateX(-HALF_PI);
    pg.translate(-$2*.5,-$4*.5,yratio);
    pg.image($1, 0, 0, $2, $4);
    pg.popMatrix();
    //left face
    pg.pushMatrix();
    pg.rotateY(-HALF_PI);
    pg.translate(-$4*.5,-$3*.5,xratio);
    pg.image($1, 0, 0, $4, $3);
    pg.popMatrix();
    //right face
    pg.pushMatrix();
    pg.rotateY(HALF_PI);
    pg.translate(-$4*.5,-$3*.5,xratio);
    pg.image($1, 0, 0, $4, $3);
    pg.popMatrix();
  }
}


class Head{
  Head(){

  }
  void draw(PGraphics pg){
    float anchodehociko = 16;
    float salidadeojos = 4+10*session.zong.beatMap.snare.currentside/100;//*abs(in.left.get(0));
    float aperturadehociko = 3+10*session.zong.beatMap.kick.currentside/100;//*abs(in.left.get(0));

    pg.pushMatrix();
    //kabeza
    pg.pushMatrix();
    pg.translate(0,-15,-5);
    //rotateY(caminangulo/4);
    pg.fill(255);
    pg.box(20,30,30);//,30,20);


    pg.pushMatrix();//alerones
    pg.translate(0,5,0);
    pg.box(30,10,20);//,30,20);
    pg.box(50,4,15);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(0,10,12+5);
    //pointLight(200, 0, 30, 5, -5, 0);
    pg.pushMatrix();
    pg.translate(0,-17,-1);
    corolla(pg, 12);
    pg.popMatrix();

    pg.pushMatrix();//kresta
    pg.translate(0,-26,-4);
    pg.box(2,6,10);
    pg.translate(0,0,-14);
    pg.box(2,10,14);
    pg.translate(0,3+2,-14);
    pg.box(2,16,10);
    pg.popMatrix();

    float cachangulo = -radians(30);
    pg.pushMatrix();//kachos
    pg.translate(-10,-26,-2);
    pg.rotateZ(cachangulo);
    pg.rotateX(cachangulo);
    pg.box(6,12,6);
    pg.box(4,24,4);
    pg.box(2,50,2);
    pg.popMatrix();
    pg.pushMatrix();//kachos
    pg.translate(10,-26,-2);
    pg.rotateZ(-cachangulo);
    pg.rotateX(cachangulo);
    pg.box(6,12,6);
    pg.box(4,24,4);
    pg.box(2,50,2);
    pg.popMatrix();
    pg.pushMatrix();//kachos
    pg.translate(-10,-26,-2-30);
    pg.rotateZ(cachangulo);
    pg.rotateX(-cachangulo);
    pg.box(6,12,6);
    pg.box(4,24,4);
    pg.box(2,50,2);
    pg.popMatrix();
    pg.pushMatrix();//kachos
    pg.translate(10,-26,-2-30);
    pg.rotateZ(-cachangulo);
    pg.rotateX(-cachangulo);
    pg.box(6,12,6);
    pg.box(4,24,4);
    pg.box(2,50,2);
    pg.popMatrix();

    pg.fill(0,255,255);//255,0,0);
    pg.pushMatrix();
    pg.translate(5,-5,0);
    pg.box(5,5,salidadeojos);
    pg.rotateZ(radians(45));
    pg.box(5,5,salidadeojos);
    pg.popMatrix();
    pg.pushMatrix();
    pg.translate(-5,-5,0);
    pg.box(5,5,salidadeojos);
    pg.rotateZ(radians(45));
    pg.box(5,5,salidadeojos);
    pg.popMatrix();

    pg.popMatrix();

    pg.popMatrix();

    pg.pushMatrix();
    pg.fill(255);

    pg.stroke(32,255,255);//255,128,0);

    pg.translate(0,4,3);
    pg.translate(-anchodehociko/2+1,-3,6);
    for(int i=0; i<10; i++){
      pg.box(1.5,2,1);
      pg.translate(anchodehociko/10,0,0);
    }
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(0,2.5,2.5);//-5);

    pg.translate(0,aperturadehociko,0);
    pg.fill(255);
    pg.box(anchodehociko,5,15);

    pg.pushMatrix();
    pg.translate(-anchodehociko/2+1,-3,6);
    for(int i=0; i<10; i++){
      pg.box(1.5,2,1);
      pg.translate(anchodehociko/10,0,0);
    }
    pg.popMatrix();

    pg.pushMatrix();//
    pg.translate(anchodehociko/2-2.5,-aperturadehociko/2-2.5,-2.5);
    pg.box(5,aperturadehociko,10);
    pg.popMatrix();
    pg.pushMatrix();//
    pg.translate(-anchodehociko/2+2.5,-aperturadehociko/2-2.5,-2.5);
    pg.box(5,aperturadehociko,10);
    //box(
    pg.popMatrix();

    pg.popMatrix();

    pg.popMatrix();
  }

  void corolla(PGraphics pg, float diam){
    pg.pushMatrix();
    pg.pushStyle();
    pg.rotateZ(radians(2*frameCount%360));
    pg.noStroke();
    pg.fill(0,255,255);
    pg.ellipse(0,0,diam,diam);
    pg.translate(diam/6,0,.01);
    diam*=.6;
    pg.fill(255);
    pg.ellipse(0,0,diam,diam);
    pg.translate(-diam/6,0,.01);
    diam*=.6;
    pg.fill(0);
    pg.ellipse(0,0,diam,diam);
    pg.translate(diam/6,0,.01);
    diam*=.6;
    pg.fill(0,255,255);//,0,0);
    pg.ellipse(0,0,diam,diam);
    pg.popStyle();
    pg.popMatrix();
  }

}





























class GFlag{
  PImage[] flags;
  int total, kurrent;
  int w, h;
  int spacing;
  int f = 0;
  PFont myFont;
  String txt;
  float txtslide = 0;
  color[] colors;// = new color[3];
    
  GFlag(){
    myFont = loadFont("CoyarzunAtarinormal-8.vlw");

    total = 5;
    flags = new PImage[total];
    for(int i=0; i<total; i++){
      String tmp = "";
      tmp+= i;
      if(i<10)tmp="0"+tmp;
      if(i<100)tmp="0"+tmp;
      tmp+=".png";
      tmp = "visuals/ahardplace/gflag/"+tmp;
      flags[i] = loadImage(tmp);
    };
    kurrent = int(random(total));

    txt = "NO ES COMODO ESTE LUGAR; TIENDO A PENSAR Q ESTA REUNION ES ANACRONICA O Q MI MIRADA SOBRE ELLA LO ES; MI MIRADA SIN DUDA LO ES; GGGGTTTT; DE LO Q HABIA Q SAKAR LECCIONES NO SE HA SACADO NADA; GGGGTTTT; LA PALABRA CIUDADANIA LAMENTABLEMENTE SE WELVE UNA FIGURA INSTITUCIONAL; CIUDADANOS SOMOS AQUELLOS QUE MANIFESTAMOS NUESTRA VOLUNTAD EN UN SISTEMA POLITICO ESTABLECIDO Y NO REPRESENTATIVO; CIUDADANOS SON LOS BUENOS CIUDADANOS, AQUELLOS QUE RESPETAN EL ORDEN PUBLICO, PAGAN SUS IMPUESTOS, TRABAJAN PARA EL PAIS; SIN EMBARGO LA MAYORIA DE LOS CIUDADANOS TIENE UNA VIDA HECHA MIERDA; EN UNA CIUDAD QUE SE HA INTENTADO RACIONALIZAR SIN PROFUNDIZAR EN SU ESTRUCTURA; EL CRITERIO TECNICO PRIMARA EN TODO, EN ADELANTE, X SIEMPRE; GGGGTTTT; LA VIDA CIVIL NO EXISTE MAS; SOMOS CONSUMIDORES; O EXCLUIDOS; EL PODER POLITICO ES SOLO UNA FACHADA DE INTERESES ECONOMICOS; CONOCEMOS REALMENTE EL ROL QUE ESPERAMOS TENER EN EL PROCESO DE GLOBALIZACION? PUEDE TORCERSE EL SIGNO DE ESTOS PROCESOS? TENEMOS ALGUNA CAPACIDAD DE REACCION E INTEGRACION?; GGGGTTTT; BUSKAMOS EN UNA DIRECCION EKIVOKADA; ESTOY CANSADO Y NO KIERO ARGUMENTOS; PREFIERO TEJER CHALECOS CON ANCIANOS QUE CORRER DETRAS DE LO NUEVO; Q ESCALAR LUGARES Y PEGAR CODAZOS; GGGGTTTT; VOY A TOMAR SUS CUERPOS Y VACIARLOS, CONVERTIR SUS GEOMETRIAS EN UN MUNDO EN ROJO, NEGRO Y BLANCO; EN ESTE OTRO RITUAL VACIADO DE PRENDER FUEGO A TU NOMBRE;";
    
    colors = new color[3];
    colors[0] = color(0,255,255);
    colors[1] = color(0);
    colors[2] = color(255);
  }
  void draw(PGraphics pg){

    pg.pushMatrix();
    pg.background(colors[session.zong.frame%colors.length]);
    pg.translate(-pg.width/2,-pg.height/2);
    pg.noStroke();
    pg.rectMode(CENTER);

    //pg.textFont(myFont,8);

    //if(random(100)>90)
    if(session.zong.beatMap.snare.currentside>90){
      int prev = kurrent;
      while(kurrent==prev){
        kurrent = int(random(total));
      }
    }
    w = flags[kurrent].width;
    h = flags[kurrent].height;
    int xspacing = pg.width/(w-4);
    int yspacing = pg.height/(h-4);

    txtslide++;

    for(int i=1; i<w-1; i++){
      for(int j=1; j<h-1; j++){
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
        pg.scale(pg.width/800,pg.height/600);
        pg.text(shar, 2, 10);
        pg.popMatrix();
      }
    }
    pg.popMatrix();
  }
}






class SapoLivingstone{
  PImage sapo;
    
  SapoLivingstone(){
      sapo = loadImage("visuals/silverstein/sapolivingstone.gif");
  }
  void draw(PGraphics pg){
    pg.pushMatrix();
    pg.translate(-sapo.width/2,-sapo.height/2);
    pg.image(sapo,0,0);
    pg.popMatrix();
  }
}



