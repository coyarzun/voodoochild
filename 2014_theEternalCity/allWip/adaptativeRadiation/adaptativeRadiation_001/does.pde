void doDrums(int positiom, int i, int pitch, int minv, int maxv) {
  drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
  drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
}
void doBass(int position, int i, int pitch, int duration) {
  basstrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
  basstrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
}
void doKboard(int position, int i, int pitch, int duration){
  kboardtrack.addEvent(new Note(pitch, (int)random(100, 120), duration), position+i);
  kboardtrack.addEvent(new Note(pitch, 0, 1), position+i+duration);
}
