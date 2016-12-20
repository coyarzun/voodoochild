void compose() {
  for (part = -1; part<11; part++) {
    switch(part) {
    case -1:
      silence();
      break;
    case 0:
      counter();
      break;
    default:
      part001();
      break;
     case 2:
     case 4:
     case 6:
       part002();
       break;
     case 9:
       part003();
       break; 
     case 10:
       finalx();
       break; 
    }
  }
}
void silence() {
  position+=quantization;
  bar=0;
}
void counter() {
  for (int i=0; i<quantization; i++) {
    if (i%4==0) {
      doDrums(position, i, 37, 120, 120);
    }
  }
  position+=quantization;
}
void finalx() {
  for (int i=0; i<quantization; i++) {
    if (i==0) {
      doDrums(position, i, 36, 120, 127);
      doDrums(position, i, 38, 120, 127);
      doDrums(position, i, 49, 120, 127);
      doKboard(position, i, 33, 16);
    }
  }
  position+=quantization;
}
void part001() {  
  for (bar=0; bar<4*2; bar++) {
    switch(bar%2) {
    default: 
      riff001a();
      break;
     case 1:
       riff001b();
    }
  }
}
void part002() {  
  for (bar=0; bar<4*2; bar++) {
    switch(bar%2) {
    default: 
      riff002a();
      break;
     case 1:
       riff002b();
    }
  }
}
void part003() {  
  for (bar=0; bar<4*2; bar++) {
    switch(bar%2) {
    default: 
      riff003a();
      break;
     case 1:
       riff003b();
    }
  }
}
void riff001a() {
  for (int i=0; i<quantization; i++) {
    drums001(position, i);
    bass001a(position, i);
    kboard001a(position, i);
  }
  position+=quantization;
}
void riff001b() {
  for (int i=0; i<quantization; i++) {
    drums001(position, i);
    bass001b(position, i);
    kboard001b(position, i);
  }
  position+=quantization;
}
void riff002a() {
  for (int i=0; i<quantization; i++) {
    drums002(position, i);
    //bass001a(position, i);
    kboard001a(position, i);
  }
  position+=quantization;
}
void riff002b() {
  for (int i=0; i<quantization; i++) {
    drums002(position, i);
    //bass001b(position, i);
    kboard001b(position, i);
  }
  position+=quantization;
}
void riff003a() {
  for (int i=0; i<quantization; i++) {
    drums004(position, i);
    //bass001a(position, i);
    kboard001a(position, i);
  }
  position+=quantization;
}
void riff003b() {
  for (int i=0; i<quantization; i++) {
    drums004(position, i);
    //bass001b(position, i);
    kboard001b(position, i);
  }
  position+=quantization;
}
/***************************/
void drums001(int position, int i) {
  if (i==0 || i==40 || i==6 || i==8 || i==11 || i==14)
    doDrums(position, i, 36, 120, 127);
  if (i==3 || i==5 || i==10 || i==13){// ||i%12==2){
    doDrums(position, i, 38, 127, 100);
    doDrums(position, i, 46, 100, 100);
  }else{
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
  }
}
void drums002(int position, int i) {
  if (i==0 || i==40 || i==6 || i==8 || i==12 || i==14)
    doDrums(position, i, 36, 120, 127);
  if (i==3 || i==5 || i==11 || i==13){// ||i%12==2){
    doDrums(position, i, 38, 127, 100);
    doDrums(position, i, 46, 100, 100);
  }else{
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
  }
}
void drums003(int position, int i) {
  if (i==0 || i==40 || i==6 || i==8 || i==12 || i==14)
    doDrums(position, i, 36, 120, 127);
  if (i==3 || i==5 || i==11 || i==13){// ||i%12==2){
    doDrums(position, i, 38, 127, 100);
    doDrums(position, i, 46, 100, 100);
  }else if(i%2==0 || i==15){
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
  }
}
void drums004(int position, int i) {
  if (i==0 || i==40 || i==6 || i==8 || i==11 || i==14)
    doDrums(position, i, 36, 120, 127);
  if (i==3 || i==5 || i==10 || i==13){// ||i%12==2){
    //doDrums(position, i, 38, 127, 100);
    doDrums(position, i, 46, 100, 100);
  }else if(i%2==0 || i==15){
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
  }
}
void bass001a(int position, int i) {
  if(i==0){
    doBass(position, -2, 28+24, 1);
    doBass(position, i, 31+24, 1);
  }
  else if(i==1 || i==9)  doBass(position, i, 33+24, 2);
  else if(i==3 || i==10)  doBass(position, i, 40+24, 3);
  else if(i==6 )  doBass(position, i, 31+24, 1);
  else if(i==7)  doBass(position, i, 33+24, 8);
  else if(i==14)  doBass(position, i, 28+24, 1);
}
void bass001b(int position, int i) {
  if(i==0){
    doBass(position, i, 31+24, 1);
  }
  else if(i==1 || i==9)  doBass(position, i, 33+24, 2);
  else if(i==3 || i==10)  doBass(position, i, 31+5+24, 3);
  else if(i==6 )  doBass(position, i, 31+2+24, 1);
  else if(i==7)  doBass(position, i, 33+24, 8);
}

void kboard001a(int position, int i) {
  if(i==0)  doKboard(position, i, 33, 16);
}
void kboard001b(int position, int i) {
  if(i==0)  doKboard(position, i, 33+3, 12);
  if(i==12)  doKboard(position, i, 33+3+2, 4);
}
