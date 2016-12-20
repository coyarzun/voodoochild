/*
import com.sun.speech.engine.synthesis.*;
import com.sun.speech.freetts.cart.*;
import com.sun.speech.freetts.diphone.*;
import com.sun.speech.freetts.relp.*;
import com.sun.speech.freetts.*;
import com.sun.speech.engine.*;
import de.dfki.lt.freetts.*;
import com.sun.speech.freetts.clunits.*;
import com.sun.speech.freetts.jsapi.*;
import com.sun.speech.freetts.audio.*;
import com.sun.speech.freetts.lexicon.*;
import com.sun.speech.engine.synthesis.text.*;
import com.sun.speech.freetts.util.*;*/
//import interfascia.*;
//import processing.opengl.*;
import rita.*;
import promidi.*;

PApplet p;

MidiIO midiIO;
Band band;
Zong slightreturn[];
//  GUIController c;
//  IFTextField t;
  
void setup(){
  //size(screen.width, screen.height, OPENGL);
  size(800, 600, P3D);
  frameRate(30);
  background(0);
  
  programDaZhow();
  
  midiIO = MidiIO.getInstance(this);
  band = new Band();
  
//  c = new GUIController(this);
//  t = new IFTextField("input", width-350, height-25, 340);
//  c.add(t);
//  t.addActionListener(this);
}

void draw(){
  band.checksong();
}
void keyReleased() {
  switch(key){
    case '1':
      band.loadZong(slightreturn[0]);
      break;
    case '2':
      band.loadZong(slightreturn[1]);
      break;
    case '3':
      band.loadZong(slightreturn[2]);
      break;
    case '4':
      band.loadZong(slightreturn[3]);
      break;
    case '5':
      band.loadZong(slightreturn[4]);
      break;
  }
  if (keyCode == 32) {
    band.rock();
  }
}
/*void actionPerformed(GUIEvent e) {
  if (e.getMessage().equals("Completed")) {
    band.donmiguel.speak(t.getValue());
    t.setValue("");
  }
}*/
