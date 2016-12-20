void compose(int i){
  switch(part){
    case -1:
    default:
      phrase00(i);
      break;
  }
  checkLyrics(i);
  if(i==15)part++;
}
void phrase00(int i){
  riff000(i);
  if(i==(quantization-1)){bar=0;part++;}
}
void riff000(int i){//rem
    doDrums(i,0); 
    int bm = int(((10*part)%100)/5);
    bm = 0;
    doBass(i,bm, 0);
    doGuitar(i,0,5,2,0);
}
float modeQuantize(float pitch, float[] mode, int keyOffset) {
  pitch = round(pitch);
  boolean inScale = false;
  while(!inScale) {
    for(int i=0; i<mode.length; i++) {
      if ((pitch - keyOffset)%12 == mode[i]) inScale = true;
      if(!inScale) pitch++;
    }
  }
  return pitch;
}
