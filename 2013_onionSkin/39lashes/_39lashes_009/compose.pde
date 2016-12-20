void compose(int i){
  if(part>43)part=43;
  switch(part){
    case -4:
    case 43:
      phrase00(i);
      break;
    case -3:
    case -2:      
    case -1:
    case 0:
    case 41:
    case 42:
      phrase01(i);
      break;    
    default:
      phrase02(i);
      break;
      case 40:
      phrase00(i);
        break;
  }
  //if(i==15)part++;
}
void phrase00(int i){
  if(i==(quantization-1)){bar=0;part++;}
}
void phrase01(int i){  
  riff000(i);
  if(i==(quantization-1)){bar=0;part++;}
}
void phrase02(int i){  
  checkLyrics(i);
  riff001(i);
  if(i==(quantization-1)){bar=0;part++;}
  //if(part==40)
}
void riff000(int i){//rem
    doDrums(i,0); 
}
void riff001(int i){//rem
    doDrums(i,1+(int)map(part,0,40,0,4)); 
    int bm = int(((10*part)%100)/5);
    bm = 0;
    if(part>12)    doBass(i,bm, 2);
    
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
