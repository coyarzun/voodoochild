/********************************************************/
/*                                                      */
/*                    VOODOOCHILD/:                     */
/*                  REDEMPTION SONGS                    */
/*                     2007-2015                        */
/*                  EXTENDED PLAYBACK                   */
/*                                                      */
/*    coded & composed by: coyarzun@error404.cl         */
/*                                                      */
/********************************************************/
import processing.serial.*;
import cc.arduino.*;
import hypermedia.net.*;
import promidi.*;
import rita.*;
import arb.soundcipher.*;
import de.looksgood.ani.*;

PApplet p = this;

SCScore score = new SCScore();
VArduinoManager arduinoManager;
VMidiManager    midiManager;
VStageManager   stageManager;
int             gOperationFlag;
PFont   mono;
boolean mini = true;
DonMiguel       donmiguel;

boolean scrollOn, halloesOn, innerOn, outLineOn, vertexOn, cycleOn;
int screendiv = 1;
float wscalef, ydisplacement;

MidiIO   midiIO;

void setup(){
  if(!mini)size(displayWidth,displayHeight,P3D);
  else
  size(512,384,P3D);
  colorMode(HSB);
  wscalef = width/float(512);
  ydisplacement = (height-384*wscalef)*.25;
  mono = loadFont("AndaleMono-8.vlw");//CoyarzunAtarinormal-8.vlw");//
  textFont(mono, 8);
  midiIO   = MidiIO.getInstance(p);
  midiIO.openInput(0,0);
  donmiguel      = new DonMiguel();
  midiManager    = new VMidiManager();
  arduinoManager = new VArduinoManager();
  stageManager   = new VStageManager();
  
  halloesOn = true;
  innerOn   = true;
  outLineOn = false;
  vertexOn  = false;
  cycleOn   = false;
  scrollOn  = false;
  

}
void draw(){
  background(240,255,255);
  noSmooth();
  noCursor();
  switch(gOperationFlag){
    case 0:
      midiManager.draw();
      break;
    case 1:
      arduinoManager.draw();
      break;
    case 2:
      stageManager.draw();
      break;
    case 3:
      break;
  }
  fill(112);
  pushMatrix();
  text("VOODOOCHILD/:REDEMPTION SONGS: ", 8, 12);
  if(gOperationFlag!=0 && gOperationFlag!=1 && (gOperationFlag==2 && stageManager.operationFlag!=0)){
    text("MIDI Out Ch# "+midiManager.outputChan, 8, 24+12);
    if(arduinoManager.on)
      text("Arduino Enabled on Port "+arduinoManager.serialPort, 8, 36+12);
    else
      text("Arduino Disabled ", 8, 36+12);
  }
  if(gOperationFlag==2 && stageManager.operationFlag!=0){
    float aux = textWidth("VOODOOCHILD/:REDEMPTION SONGS: ");
    noStroke();
    if(!stageManager.daSong.sequencer.isRunning())
      fill(255);
    else
      fill(112,255,255);
    rect(0, 16, textWidth(stageManager.daSong.name)+8+8, 12);
    fill(112);
    text(stageManager.daSong.name, 8, 24);
  }
  popMatrix();
  
}
void keyReleased(){
  switch(gOperationFlag){
    case 0:
      midiManager.keyReleased();
      break;
    case 1:
      arduinoManager.keyReleased();
      break;
    case 2:
      stageManager.keyReleased();
      break;
  }
}
