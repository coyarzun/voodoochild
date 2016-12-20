class VMidiManager {
  
  int      outputChan, outputChan2;
  String[] inputDevices, outputDevices;
  int      operationFlag;
  int      scrollPos;

  VMidiManager() {
    
    inputDevices   = new String[midiIO.numberOfInputDevices()];
    outputDevices  = new String[midiIO.numberOfOutputDevices()];
    for (int i=0; i<inputDevices.length; i++) {
      inputDevices[i] = midiIO.getInputDeviceName(i);
    }
    for (int i=0; i<outputDevices.length; i++) {
      outputDevices[i] = midiIO.getOutputDeviceName(i);
    }
    outputChan = -1;
    outputChan2 = 1;
    scrollPos = -1;
  }
  void initMidi(int mch) {
    outputChan = mch;
    for (int j=0; j<16; j++) {
      for (int i=0; i<127; i++) {
        (midiIO.getMidiOut(j, outputChan)).sendNote(new Note(i, 0, 0));
        (midiIO.getMidiOut(j, outputChan2)).sendNote(new Note(i, 0, 0));
      }
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
        initMidi(scrollPos);
        gOperationFlag = 1;
      }
    }
    else if (keyCode>=48 && keyCode <=57) {     
      int pnum = constrain(keyCode-48, 0, 9);
      pnum%=outputDevices.length;
      scrollPos = pnum;
    }
    else if (keyCode>=37 && keyCode<=40) {
      //println(keyCode);
      if (keyCode==38) {
        scrollPos--; 
        if (scrollPos<-1)scrollPos=outputDevices.length-1;
      }
      else if (keyCode==40) {
        scrollPos++; 
        scrollPos%=outputDevices.length;
      }
    }
  }
  void noteOn(int pit){
    println(">>>"+pit);
    if(pit==0){
      scrollPos--; 
      if (scrollPos<-1)scrollPos=outputDevices.length-1;
    }
    if(pit==1){
      scrollPos++; 
      scrollPos%=outputDevices.length;
    }
    if(pit==2){
      if (scrollPos>-1) {
        initMidi(scrollPos);
        gOperationFlag = 1;
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
    rect(0, 3, scrollW, (outputDevices.length+1)*12);
    fill((frameCount/2)%2==0?240:122, 240, 240);
    noStroke();
    rect(0, (scrollPos+1)*12+3, scrollW, 12);
    fill(0);
    text("PLEASE SELECT A MIDI OUTPUT DEVICE:", 8, 12);
    for (int i=0; i<outputDevices.length; i++) {
      translate(0, 12);
      text("["+i+"] "+outputDevices[i], 8, 12);
    }
    popMatrix();
  }
}







void noteOn(Note note, int device, int channel){
  int vel = note.getVelocity();
  int pit = note.getPitch();
  println("Note On: "+pit+" "+vel+" "+device+" "+channel);
  switch(gOperationFlag){
    case 0:
      midiManager.noteOn(pit);
      break;
    case 1:
      arduinoManager.noteOn(pit);
      break;
    case 2:
      stageManager.noteOn(pit);
      break;
  }
}

void noteOff(Note note, int device, int channel){
  int pit = note.getPitch();
  //println("Note Off: "+pit+" "+device+" "+channel);
}

void controllerIn(Controller controller, int device, int channel){
  int num = controller.getNumber();
  int val = controller.getValue();
  //println("controller in: "+num+" "+val+" "+device+" "+channel);
}

void programChange(ProgramChange programChange, int device, int channel){
  int num = programChange.getNumber();
  //println("Program Change: "+num+" "+device+" "+channel);
}



