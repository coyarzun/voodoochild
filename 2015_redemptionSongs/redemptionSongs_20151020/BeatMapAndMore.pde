class BeatMap {
  Boolean[] kicklist, snarelist, hatlist, rimlist;
  Boxy      kick, snare, hat;
  Texty     rim;
  int cpos;

  BeatMap() {
    kicklist  = new Boolean[1024*16];
    snarelist = new Boolean[1024*16];
    hatlist   = new Boolean[1024*16];
    rimlist   = new Boolean[1024*16];

    kick  = new Boxy(-50, 0, 0, 100, color(0, 256, 256));
    snare = new Boxy(50, 0, 0, 100, color(128, 256, 256));
    hat   = new Boxy(0, 0, 0, 100, color(64, 256, 256));
    rim   = new Texty(0, 0, 0, 100, color(0, 0, 255));

    for (int i=0; i<kicklist.length; i++) {
      kicklist[i]=false;
      snarelist[i]=false;
      hatlist[i]=false;
      rimlist[i]=false;
    }
    cpos = -1;
  }
  void addKick(int pos) {
    kicklist[pos] = true;
  }
  void addSnare(int pos) {
    snarelist[pos] = true;
  }
  void addHat(int pos) {
    hatlist[pos] = true;
  }
  void addRim(int pos) {
    rimlist[pos] = true;
  }
  void update(int pos) {
    kick.update();
    snare.update();
    hat.update();
    rim.update();

    if (pos>=0 && cpos!= pos) {
      arduinoManager.doPote();
      if (kicklist[pos]) {
        kick.beat();
        arduinoManager.doKick();
      }
      else {
        arduinoManager.muteKick();
      }
      if (snarelist[pos]) {
        snare.beat();
        arduinoManager.doSnare();
      }
      else {
        arduinoManager.muteSnare();
      }
      if (hatlist[pos]) {
        hat.beat();
        arduinoManager.doHat();
      }
      else {
        arduinoManager.muteHat();
      }
      if (rimlist[pos])rim.beat();
      cpos = pos;
    }
  }
  void draw(PGraphics pg) {
    kick.draw(pg);
    snare.draw(pg);
    hat.draw(pg);
    rim.draw(cpos, pg);
  }
  void drawrim(PGraphics pg) {
    rim.draw(cpos, pg);
  }
}

class Boxy {
  int x, y, z;
  float maxside, minside, currentside;
  color kolor;
  Boxy() {
  }
  Boxy(int x, int y, int z, float maxside, color kolor) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.maxside = maxside;
    this.kolor = kolor;
    minside = 0;//maxside/10;
    currentside = minside;
  }
  void draw(PGraphics pg) {
    /**/
    float alfa = map(currentside, minside, maxside, 0, 96);
    //z = int(currentside-minside);
    pg.noSmooth();
    pg.pushMatrix();
    pg.translate(x, y, z);
    pg.noStroke();
    pg.fill(kolor, alfa);
    pg.box(currentside);
    pg.fill(kolor, alfa*.5);
    pg.box(currentside*.6);
    pg.popMatrix();/**/

    //update();
  }
  void update() {
    currentside*=0.6;
    if (currentside<minside)currentside=minside;
  }
  void beat() {
    currentside = maxside;
  }
}
class Texty extends Boxy {
  PFont font;

  Texty(int x, int y, int z, float maxside, color kolor) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.maxside = maxside;
    this.kolor = kolor;
    minside = 0;//maxside/10;
    currentside = minside;
    font = loadFont("CoyarzunAtarinormal-100.vlw");
  }
  void draw(int pos, PGraphics pg) {
    /**/
    float alfa = map(currentside, minside, maxside, 0, 96);
    //z = int(currentside-minside);
    pg.noSmooth();
    pg.pushMatrix();
    pg.translate(x, y, z);
    pg.noStroke();
    pg.fill(kolor, alfa);
    pg.textFont(font, currentside);
    String t = nf( 3-(pos%16)/4, 1);
    pg.text(t, -currentside/2, currentside/2);//-128*fs, -128*fs);
    pg.popMatrix();
  }
  void beat() {
    currentside = maxside;
  }
}
