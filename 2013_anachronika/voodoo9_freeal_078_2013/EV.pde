class Evolution{
  EvolutionKnob[][] knobs;
  EvolutionSlide[]  slides;
  EvolutionSlide mainslide;
  EvolutionNumPad numpad;
  EvolutionControlPad controlpad;

  Evolution(int midiPort){
    for(int i=0; i<16; i++){
      //if(realmidi)midiIO.openInput(midiPort,i);//evolution
    }
    knobs = new EvolutionKnob[8][3];
    for(int i=0; i<knobs.length; i++){
      for(int j=0; j<knobs[i].length; j++){
        knobs[i][j] = new EvolutionKnob(i*20,j*20);
      }
    }
    slides = new EvolutionSlide[8];
    for(int i=0; i<slides.length; i++){
      slides[i] = new EvolutionSlide(i*20, 60);
    }
    mainslide = new EvolutionSlide(8*20, 60);

    numpad = new EvolutionNumPad(9*20, 0);
    
    controlpad = new EvolutionControlPad(9*20, 4*20);
    
  }
  void noteOff(Note note, int deviceNumber, int midiChannel){
    int vel = note.getVelocity();
    int pitch = note.getPitch();  
    println("off!: "+pitch+" "+vel+" "+deviceNumber+" "+midiChannel);
    if(pitch==10 || pitch==12 || pitch==13){//los knobs
      if(pitch>10)pitch--;
      pitch-=10;
      knobs[midiChannel][2-pitch].setvalue(vel);
    }else if(pitch==7){//sliders
      slides[midiChannel].setvalue(vel);      
    }else if(pitch==28){
      mainslide.setvalue(vel);
    }else if(pitch>=18 && pitch<=27){
      numpad.press(pitch-18);
    }else if(pitch>=14 && pitch<=17){
      controlpad.press(pitch-14);
    }
  }
  void controllerIn(Controller controller, int deviceNumber, int midiChannel){
    int num = controller.getNumber();
    int val = controller.getValue();
    println(midiChannel+" "+deviceNumber+" "+num+" "+val);
    if(num==10 || num==12 || num==13){//los knobs
      if(num>10)num--;
      num-=10;
      knobs[midiChannel][2-num].setvalue(val);
    }else if(num==7){//sliders
      slides[midiChannel].setvalue(val);      
    }else if(num==28){
      mainslide.setvalue(val);
    }else if(num>=18 && num<=27){
      numpad.press(num-18);
    }else if(num>=14 && num<=17){
      controlpad.press(num-14);
    }
  }
  void draw(){
    pushMatrix();
    translate(10,10);
    for(int i=0; i<8; i++){
      for(int j=0; j<3; j++){
        knobs[i][j].draw();
      }
      slides[i].draw();
    }
    mainslide.draw();
    numpad.draw();
    controlpad.draw();
    popMatrix();
  }
}
class EvolutionKnob{
  int x,y;
  int value;

  EvolutionKnob(int $x, int $y){
    x = $x; 
    y = $y;
  }
  void setvalue(int val){
    value = val;
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    float v = map(value,0,127,0,16);
    fill(255);
    noStroke();
    rect(0,0,v,16);
    noFill();
    stroke(0);
    rect(0,0,16,16);
    popMatrix();  
  }
}
class EvolutionSlide{
  int x,y;
  int value;

  EvolutionSlide(int $x, int $y){
    x = $x; 
    y = $y;
  }
  void setvalue(int val){
    value = val;
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    float v = map(value,0,127,0,64);
    fill(255);
    noStroke();
    rect(0,64-v,16,v);
    noFill();
    stroke(0);
    rect(0,0,16,64);
    popMatrix();
  }
}
class EvolutionNumPad{
  int x,y;
  EvolutionButton[] buttons;
  
  EvolutionNumPad(int $x, int $y){
    x = $x; 
    y = $y;
    buttons = new EvolutionButton[10];
    for(int i=0; i<buttons.length; i++){
      int x = 20*((i-1)%3);
      int y = 20*((i-1)/3);
      if(i==0){x=20;y=60;}
      buttons[i] = new EvolutionButton(x,y,i);
    }
  }
  void press(int index){
    buttons[index].press();
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    for(int i=0; i<buttons.length; i++){
      buttons[i].draw();
    }
    popMatrix();
  }
}
class EvolutionControlPad{
  int x,y;
  EvolutionButton[] buttons;
  
  EvolutionControlPad(int $x, int $y){
    x = $x; 
    y = $y;
    buttons = new EvolutionButton[4];
    /*
    for(int i=0; i<buttons.length; i++){
      int x = 20*i;
      int y = 0;
      buttons[i] = new EvolutionButton(x,y,i);
    }
    */
    buttons[0] = new EStopButton(0,0,0);
    buttons[1] = new EPlayButton(20,0,1);
    buttons[2] = new ERevButton(40,0,2);
    buttons[3] = new EFowButton(60,0,3);
    //EStopButton
  }
  void press(int index){
    buttons[index].press();
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    for(int i=0; i<buttons.length; i++){
      buttons[i].draw();
    }
    popMatrix();
  }
}
class EvolutionButton{
  int index;
  int x,y;
  int value;
  EvolutionButton(){
  }
  EvolutionButton(int $x, int $y, int i){
    x = $x; 
    y = $y;
    index = i;
    value = 255;
  }
  void press(){
    value = 0;
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    fill(value);
    noStroke();
    rect(0,0,16,16);
    noFill();
    stroke(0);
    rect(0,0,16,16);
    popMatrix();
    value = constrain(value+=10, 0, 255);
  }
}
class EStopButton extends EvolutionButton{
  EStopButton(int $x, int $y, int i){
    x = $x; 
    y = $y;
    index = i;
    value = 255;
  }
  void press(){
    value = 0;
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    fill(value);
    noStroke();
    rect(0,0,16,16);
    noFill();
    stroke(0);
    rect(0,0,16,16);
    fill(0);
    rect(4,4,8,8);
    popMatrix();
    value = constrain(value+=10, 0, 255);
  }
}
class EPlayButton extends EvolutionButton{
  EPlayButton(int $x, int $y, int i){
    x = $x; 
    y = $y;
    index = i;
    value = 255;
  }
  void press(){
    value = 0;
    session.rock();
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    fill(value);
    noStroke();
    rect(0,0,16,16);
    noFill();
    stroke(0);
    rect(0,0,16,16);
    fill(0);
    //rect(4,4,8,8);
    triangle(4,4,2+10,8,4,12);
    popMatrix();
    value = constrain(value+=10, 0, 255);
  }
}
class ERevButton extends EvolutionButton{
  ERevButton(int $x, int $y, int i){
    x = $x; 
    y = $y;
    index = i;
    value = 255;
  }
  void press(){
    value = 0;
    session.prev();
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    fill(value);
    noStroke();
    rect(0,0,16,16);
    noFill();
    stroke(0);
    rect(0,0,16,16);
    fill(0);noStroke();
    //rect(4,4,8,8);
    //translate(-1,0);
    triangle(4,8,8,4,8,12);
    triangle(4+4,8,2+10,4,2+10,12);
    popMatrix();
    value = constrain(value+=10, 0, 255);
  }
}
class EFowButton extends EvolutionButton{
  EFowButton(int $x, int $y, int i){
    x = $x; 
    y = $y;
    index = i;
    value = 255;
  }
  void press(){
    value = 0;
    session.next();
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    fill(value);
    noStroke();
    rect(0,0,16,16);
    noFill();
    stroke(0);
    rect(0,0,16,16);
    fill(0);noStroke();
    //rect(4,4,8,8);
    triangle(4,4,8,8,4,12);
    triangle(4+4,4,2+10,8,4+4,12);
    popMatrix();
    value = constrain(value+=10, 0, 255);
  }
}

class MidiKb{
  KbKey[] keys;
  
  MidiKb( int midiPort ){
    //if(realmidi)midiIO.openInput(midiPort, 0);
    keys = new KbKey[61];
    
    int kcell = 8;
    int kpos = 0;
    for(int i=0; i<keys.length; i++){
      int n = i%12;
      boolean k = (n==1 || n==3 || n==6 || n==8 || n==10);
      keys[i] = new KbKey(kpos,0,i,k,kcell);
      kpos += (n==4 || n==11) ? kcell : kcell/2 ;
    }
  }
  void noteOn(Note note, int deviceNumber, int midiChannel){
    int vel = note.getVelocity();
    int pitch = note.getPitch();
    //println("on!!: "+pitch+" "+vel+" "+deviceNumber+" "+midiChannel);
    //kbout.sendNote(new Note(pitch-24, 100, 2000/4));
    keys[pitch-36].press();
  }
  void noteOff(Note note, int deviceNumber, int midiChannel){
    int vel = note.getVelocity();
    int pitch = note.getPitch();
    //println("off!: "+pitch+" "+vel+" "+deviceNumber+" "+midiChannel);
    keys[pitch-36].release();
  }
  void draw(){
    pushMatrix();
    translate(10,150);
    for(int i=0; i<keys.length; i++){
      if(!keys[i].isBlack)keys[i].draw();
    }
    for(int i=0; i<keys.length; i++){
      if(keys[i].isBlack)keys[i].draw();
    }
    popMatrix();
  }
}
class KbKey{
  boolean isBlack;
  int x, y;
  int index;
  int value;
  int w,h;
  
  KbKey(int $x, int $y, int i, boolean b, int _w){
    x = $x;
    y = $y;
    index = i;
    isBlack = b;
    w = _w;
    h = w*(b? 3:5);
    if(b)x+= .3*w/2;
    w *= b? .7:1;
    release();
  }
  void draw(){
    pushMatrix();
    translate(x,y);
    fill(value);stroke(0);
    rect(0,0,w,h);
    popMatrix();
    //value = constrain(value+=10, 0, 255);
  }
  void press(){
    value = 128;
  }
  void release(){
    value = isBlack? 0:255;
  }
}








void noteOn(Note note, int deviceNumber, int midiChannel){
  int vel = note.getVelocity();
  int pitch = note.getPitch();
  if(deviceNumber!=5){//kitamos el evolution
    //println("on!!: "+pitch+" "+vel+" "+deviceNumber+" "+midiChannel);
    if(vel>0){
      ;//kbout.sendNote(new Note(pitch-24, 100, 2000/4));
      midikb.noteOn(note,deviceNumber,midiChannel);
    }
  }  
}
void noteOff(Note note, int deviceNumber, int midiChannel){
  int vel = note.getVelocity();
  int pitch = note.getPitch();
  if(deviceNumber!=5){//kitamos el evolution
    ;//println("off!: "+pitch+" "+vel+" "+deviceNumber+" "+midiChannel);
    midikb.noteOff(note, deviceNumber, midiChannel);
  }else{
    //println("algo desde el evolution");
    evolution.noteOff(note, deviceNumber, midiChannel);
  }
}
void controllerIn(Controller controller, int deviceNumber, int midiChannel){
  int num = controller.getNumber();
  int val = controller.getValue();
  println(midiChannel+" "+deviceNumber+" "+num+" "+val);
  evolution.controllerIn(controller, deviceNumber, midiChannel);
}





