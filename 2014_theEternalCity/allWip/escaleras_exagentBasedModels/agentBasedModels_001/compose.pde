void compose(){
  for(part = -1; part<23; part++){
    switch(part){
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      case 1:
        part001();
        break;
      case 2:
      case 3:
        part002();
      case 4:
        part003();
        break;
      case 5:
        part004();
        break;
      case 6:
        part005();
        break;
      
      case 7:
      case 8:
        part002();
      case 9:
        part003();
        break;
      case 10:
        part004();
        break;
      case 11:
        part005();
        break;
      
      /*case 12:
      case 13:
        part002();*/
      case 12:
        part003();
        break;
      case 13:
        part004();
        break;
      case 14:
        part006();
        break;
        
        
      default:
        silence();
        break;
    } 
  }
}
void silence(){
  position+=quantization;
  bar=0;
}
void counter(){
  for(int i=0; i<quantization; i++){
    if(i%4==0){
      doDrums(position, i, 37, 120, 120);
    }
  }
  position+=quantization;
}

void part001(){  
  for(bar=0; bar<4*4; bar++){
    riff000();
  }
}
void part002(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff000();
    else riff001();
  }
}
void part003(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff002();
    else riff001();
  }
}
void part004(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff002();
    else if(bar<6)riff003();
    else riff000();
  }
}
void part005(){  
  for(bar=0; bar<4*2; bar++){
    riff001();
  }
}
void part006(){  
  for(bar=0; bar<4*4; bar++){
    riff001();
  }
}
void riff000(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassLam(position, i);
  }
  position+=quantization;
}
void riff001(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassMim(position, i);
  }
  position+=quantization;
}
void riff002(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassDoM(position, i);
  }
  position+=quantization;
}
void riff003(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassSim(position, i);
  }
  position+=quantization;
}
/***************************/
void drums001(int position, int i){
  if(i%6==0)
    doDrums(position, i, 38, 96, 100);
  else
  if(i%4==0 || i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  if(i%4==0)
    doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
  else if(i%4==2)
    doDrums(position, i, 44, 110, 120);
}
void drums002(int position, int i){
  if(i%6==0)
    doDrums(position, i, 38, 96, 100);
  else if(i%4==0 || i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  if(i%4==0)
    doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
  else if(i%4==2)
    doDrums(position, i, 44, 110, 120);
}
//
void bassLam(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 45-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 45+12-12, 1);
  }
}
void bassSim(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 45+2-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 45+12+2-12, 1);
  }
}
void bassMim(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 40+12-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 40+12+12-12, 1);
  }
}
void bassDoM(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 40+12-4-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 40+12+12-4-12, 1);
  }
}
//
void kboardLam(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 45-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 45+12-12, 1);
  }
}
void kboardSim(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 45+2-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 45+12+2-12, 1);
  }
}
void kboardMim(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 40+12-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 40+12+12-12, 1);
  }
}
void kboardDoM(int position, int i){
  if(i==0 || i==4 || i==8 || i==12){
    doBass(position, i, 40+12-4-12, 1);
  }
  if(i==2 || i==6 || i==10 || i==14){
    doBass(position, i, 40+12+12-4-12, 1);
  }
}
