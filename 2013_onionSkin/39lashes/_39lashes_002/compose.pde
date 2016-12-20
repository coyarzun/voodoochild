void compose(int i){
  switch(part){
    case -1:
    default:
      phrase00(i);
      break;
  }
}
void phrase00(int i){
  riff000(i);
  if(i==(quantization-1)){bar=0;part++;}
}
void riff000(int i){//rem
    doDrums(i,0); 
    doBass(i,0,2);
    doGuitar(i,0,5,2,0);
}
