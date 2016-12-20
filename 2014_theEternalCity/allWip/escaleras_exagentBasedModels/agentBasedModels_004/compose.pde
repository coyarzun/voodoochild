void compose(){
  for(part = -1; part<20; part++){
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
        part002b();
      case 9:
        part003b();
        break;
      case 10:
        part004b();
        break;
      case 11:
        part005b();
        break;
      
      case 12:
      case 13:
        part002();
      case 14:
        part003();
        break;
      case 15:
        part004b();
        break;
      case 16:
      case 17:
        part006b();
        break;
        
      case 18:
        diend();
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
void diend(){
  for(int i=0; i<quantization; i++){
    if(i==0){
      doDrums(position, i, 36, 120, 127);
      doDrums(position, i, 38, 96, 120);
      doDrums(position, i, 44, 110, 120);
      doBass(position, i, 45-12, 16);
      doKboard(position, i, mim[0], 16);doKboard(position, i, mim[1], 16);doKboard(position, i, mim[2], 16);
    }
  }
  position+=quantization;
}
void part001(){  
  for(bar=0; bar<4*4*1; bar++){
    riff000();
  }
}
void part002(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff000b();
    else riff001b();
  }
}
void part002b(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff000c();
    else riff001c();
  }
}
void part003(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff002b();
    else riff001b();
  }
}
void part003b(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff002c();
    else riff001c();
  }
}
void part004(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff002b();
    else if(bar<6)riff003b();
    else riff000b();
  }
}
void part004b(){  
  for(bar=0; bar<8; bar++){
    if(bar<4)riff002c();
    else if(bar<6)riff003c();
    else riff000c();
  }
}
void part005(){  
  for(bar=0; bar<4*2; bar++){
    riff001b();
  }
}
void part005b(){  
  for(bar=0; bar<4*2; bar++){
    riff001c();
  }
}
void part006(){  
  for(bar=0; bar<4*4; bar++){
    riff001();
  }
}
void part006b(){  
  for(bar=0; bar<4*4; bar++){
    riff001b();
  }
}
void part006c(){  
  for(bar=0; bar<4*4; bar++){
    riff001c();
  }
}
void riff000(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassLam(position, i);
    kboardLam(position, i);
  }
  position+=quantization;
}
void riff000b(){
  for(int i=0; i<quantization; i++){
    drums002(position,i);
    bassLam(position, i);
    kboardLam(position, i);
  }
  position+=quantization;
}
void riff000c(){
  for(int i=0; i<quantization; i++){
    drums003(position,i);
    bassLam(position, i);
    kboardLam(position, i);
  }
  position+=quantization;
}
void riff001(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassMim(position, i);
    kboardMim(position, i);
  }
  position+=quantization;
}
void riff001b(){
  for(int i=0; i<quantization; i++){
    drums002(position,i);
    bassMim(position, i);
    kboardMim(position, i);
  }
  position+=quantization;
}
void riff001c(){
  for(int i=0; i<quantization; i++){
    drums003(position,i);
    bassMim(position, i);
    kboardMim(position, i);
  }
  position+=quantization;
}
void riff002(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassDoM(position, i);
    kboardDoM(position, i);
  }
  position+=quantization;
}
void riff002b(){
  for(int i=0; i<quantization; i++){
    drums002(position,i);
    bassDoM(position, i);
    kboardDoM(position, i);
  }
  position+=quantization;
}
void riff002c(){
  for(int i=0; i<quantization; i++){
    drums003(position,i);
    bassDoM(position, i);
    kboardDoM(position, i);
  }
  position+=quantization;
}
void riff002d(){
  for(int i=0; i<quantization; i++){
    drums003(position,i);
    bassDoM(position, i);
    kboardDoMb(position, i);
  }
  position+=quantization;
}
void riff003(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bassSim(position, i);
    kboardSim(position, i);
  }
  position+=quantization;
}
void riff003b(){
  for(int i=0; i<quantization; i++){
    drums002(position,i);
    bassSim(position, i);
    kboardSim(position, i);
  }
  position+=quantization;
}
void riff003c(){
  for(int i=0; i<quantization; i++){
    drums003(position,i);
    bassSim(position, i);
    kboardSim(position, i);
  }
  position+=quantization;
}
/***************************/
void drums001(int position, int i){
  if(i%4==0 || i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
}
void drums002(int position, int i){
  if(i%4==0 || i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  if(i%4==0)
    doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
  else if(i%4==2)
    doDrums(position, i, 44, 110, 120);
}
void drums003(int position, int i){
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
  i*=2;
  doKboard(position, i%quantization, lam[2-i%3], 1);
  i*=2;
  doKboard(position, i%quantization, lam[2-i%3], 1);
}
void kboardSim(int position, int i){
  i*=4;
  doKboard(position, i%quantization, sim[2-i%3], 1);
}
void kboardMim(int position, int i){
  i*=2;
  doKboard(position, i%quantization, mim[2-i%3], 1);
  doKboard(position, (i+2)%quantization, mim[2-i%3]+12, 1);
}
void kboardDoM(int position, int i){
  i*=2;
  doKboard(position, i%quantization, doM[2-i%3], 1);
}
void kboardDoMb(int position, int i){
  doKboard(position, i%quantization, doM[2-i%3], 1);
}
