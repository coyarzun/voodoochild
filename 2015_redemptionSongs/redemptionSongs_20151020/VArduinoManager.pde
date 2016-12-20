class VArduinoManager {//en el futuro extender esta clase "scroll menu" o algo asi
  Arduino arduino;
  int     serialPort;
  boolean on;

  String[] devices;
  int      operationFlag;
  int      scrollPos;

  int potePin  = 0;
  int kickPin  = 3;
  int snarePin = 5;
  int hihatPin = 6;

  int kickVal, snareval, hihatVal;
  int poteVal, maxVal;

  VArduinoManager() {
    devices = new String[Arduino.list().length+1];

    for (int i=0; i<devices.length; i++) {
      if (i<devices.length-1)
        devices[i] = Arduino.list()[i];
      else
        devices[i] = "Plese no Arduino today";
    }
    serialPort = -1;
    scrollPos = -1;
  }
  void initArduino(int sch) {
    on = (sch!=devices.length-1);
    if (on) {
      try {
        arduino = new Arduino(p, devices[sch], 57600);
        arduino.pinMode(kickPin, Arduino.OUTPUT);
        arduino.pinMode(snarePin, Arduino.OUTPUT);
        arduino.pinMode(hihatPin, Arduino.OUTPUT);
      }
      catch(Exception e) {
        on = false;
      }
      serialPort = sch;
    }
    println("arduino on: "+on);
  }
  void doPote() {
    poteVal = arduino.analogRead(potePin);
    maxVal  = (int)map(poteVal, 0, 1023, 0, 255);
  }
  void doKick() {
    try {
      arduino.analogWrite(kickPin, maxVal);
      println("arduino.analogWrite("+kickPin+", "+maxVal+")");
    }
    catch(Exception e) {
    }
  }
  void muteKick() {
    try {
      arduino.analogWrite(kickPin, 0);
    }
    catch(Exception e) {
    }
  }
  void doSnare() {
    try {
      arduino.analogWrite(snarePin, int(maxVal*0.75));
    }
    catch(Exception e) {
    }
  }
  void muteSnare() {
    try {
      arduino.analogWrite(snarePin, 0);
    }
    catch(Exception e) {
    }
  }
  void doHat() {
    try {
      arduino.analogWrite(hihatPin, int(maxVal*.5));
    }
    catch(Exception e) {
    }
  }
  void muteHat() {
    try {
      arduino.analogWrite(hihatPin, 0);
    }
    catch(Exception e) {
    }
  }
  void draw() {
    switch(operationFlag) {
    case 0:
    default:
      drawSelectOutput();
      break;
    }
  }
  void keyReleased() {
    switch(operationFlag) {
    case 0:
    default:
      keyReleasedSelectOutput();
      break;
    }
  }
  void keyReleasedSelectOutput() {
    if (keyCode==32 || keyCode==10) {//spacebar o return
      if (scrollPos>-1) {
        initArduino(scrollPos);
        gOperationFlag = 2;
      }
    }
    else if (keyCode>=48 && keyCode <=57) {     
      int pnum = constrain(keyCode-48, 0, 9);
      pnum%=devices.length;
      scrollPos = pnum;
    }
    else if (keyCode>=37 && keyCode<=40) {
      //println(keyCode);
      if (keyCode==38) {
        scrollPos--; 
        if (scrollPos<-1)scrollPos=devices.length-1;
      }
      else if (keyCode==40) {
        scrollPos++; 
        scrollPos%=devices.length;
      }
    }
  }
  void noteOn(int pit){
    //println(">>>"+pit);
    if(pit==0){
      scrollPos--; 
      if (scrollPos<-1)scrollPos=devices.length-1;
    }
    if(pit==1){
      scrollPos++; 
      scrollPos%=devices.length;
    }
    if(pit==2){
      if (scrollPos>-1) {
        initArduino(scrollPos);
        gOperationFlag = 2;
      }
    }
  }
  void drawSelectOutput() {
    int scrollW = 240;
    //background(255);
    pushMatrix();
    translate(16, 16);
    noSmooth();
    fill(255);
    rect(0, 3, scrollW, (devices.length+1)*12);
    fill((frameCount/2)%2==0?240:122, 240, 240);
    noStroke();
    rect(0, (scrollPos+1)*12+3, scrollW, 12);
    fill(0);
    text("PLEASE SELECT AN ARDUINO DEVICE:", 8, 12);
    for (int i=0; i<devices.length; i++) {
      translate(0, 12);
      text("["+i+"] "+devices[i], 8, 12);
    }
    popMatrix();
  }
}
