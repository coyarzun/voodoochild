void doDrums(int positiom, int i, int pitch, int minv, int maxv) {
  drumstrack.addEvent(new Note(pitch, (int)random(minv, maxv), 1), position+i);
  drumstrack.addEvent(new Note(pitch, 0, 1), position+i+1);
}
void doBass(int position, int i, int pitch, int duration) {
  int basescale = 36;
  int nn = basescale+pitch;//+12*(random(100)>50?1:0);
  basstrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
  basstrack.addEvent(new Note(nn, 0, 1), position+i+duration);
}
void doGuitar(int position, int i, int pitch, int duration) {
  int basescale = 36+36;
  int nn = basescale+pitch;
  guitartrack.addEvent(new Note(nn, (int)random(100, 120), duration), position+i);
  
  guitartrack.addEvent(new Note(nn, 0, 1), position+i+duration);
}
void checkLyrics(int i) {
  //  if(part==2 && bar==1 && i==0)donmiguel.sing("abre sendas por los cerros");
  //String rnd = ""+(part);//random(127);
  //if (i%quantization==0)donmiguel.sing(rnd);
}

