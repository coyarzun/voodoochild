void compose() {
  for (part = -1; part<24; part++) {
    switch(part) {
    case -1:
      silence();
      break;
    case 0:
      counter();
      break;
    case 1:
    case 3:
    //case 5:
      part001();
      break;
    case 2:
    //case 4:
      part002();
      //silence();
      break;
    default:
      part003();
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
void prediend() {
  for (int i=0; i<quantization; i++) {
    if (i==0) {
      doBass(position, i, 45-12, 12);
      doKboard(position, i, solM[0], 160);
      doKboard(position, i, solM[1], 160);
      doKboard(position, i, solM[2], 160);
    }
  }
  position+=quantization;
}
void diend() {
  int i=0;
  doKboard(position, i, solM[0], 160);
  doKboard(position, i, solM[1], 160);
  doKboard(position, i, solM[2], 160);
  position+=quantization;
}
void part001() {  
  for (bar=0; bar<4*4; bar++) {
    switch(bar%4) {
    default: 
      riff000();
      break;
    case 1:
      riff002();
      break;
    }
  }
}
void part002() {  
  for (bar=0; bar<4*2; bar++) {
    switch(bar%4) {
    case 0: 
      riff001();
      break;
    case 1:
      riff002();
      break;
    default:
      riff000();
      break;
    }
  }
}
void part003() {  
  for (bar=0; bar<4*2; bar++) {
      riff001();
      break;
  }
}
void riff000() {
  for (int i=0; i<quantization; i++) {
    drums001(position, i);
    bassSolM(position, i);
    kboardSolM(position, i);
  }
  position+=quantization;
}
void riff001() {
  for (int i=0; i<quantization; i++) {
    drums001(position, i);
    bassSim(position, i);
    kboardSim(position, i);
  }
  position+=quantization;
}
void riff002() {
  for (int i=0; i<quantization; i++) {
    drums001(position, i);
    bassDoM(position, i);
    kboardDoM(position, i);
  }
  position+=quantization;
}
/***************************/
void drums001(int position, int i) {
  if (i%4==0)// || i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  if (i%3==0){
    doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
    doDrums(position, i+1, 44, i%6==0?127:96, i%6==0?127:96);
  }
  else
    doDrums(position, i, 42, i%6==0?127:96, i%6==0?127:96);
    
  if (i%8==4)
    doDrums(position, i, 38, 96, 100);
}
void drums002(int position, int i) {
  if (i%4==0 )//|| i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  if (i%3==0)
    doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
  else //if(i%4==2)
  doDrums(position, i, 42, 110, 120);
  if (i%8==4)
    doDrums(position, i, 38, 96, 100);
}
void drums003(int position, int i) {
  if (i%8==0)
    doDrums(position, i, 38, 96, 100);
  else if (i%4==0 || i%10==0)
    doDrums(position, i, 36, i%6==0?127:96, i%6==0?127:96);
  if (i%3==0)
    doDrums(position, i, 44, i%6==0?127:96, i%6==0?127:96);
  else if (i%4==2)
    doDrums(position, i, 42, 110, 120);
}
//
void bassSolM(int position, int i) {
  int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
  if (i%2==0) {
    doBass(position, i, 43-12, 1);
  }
  else doBass(position, i, 43, 1);//doBass(position, i, 43-24, 1);
}
void bassSim(int position, int i) {
  int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
  if (i%2==0) {
    doBass(position, i, 47-12, 1);
  }
  //else doBass(position, i, 47, 1);//doBass(position, i, 47-24, 1);
}
void bassDoM(int position, int i) {
  int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
  if (i%2==0) {
    doBass(position, i, 36-12, 1);
  }
  else      doBass(position, i, 36, 1);//doBass(position, i, 36-12, 1);
}
//
void kboardSolM(int position, int i) {
  //if(i%2==0)// || i%3==0)
  //doKboard(position, i%quantization, solM[3-i%4], 8);
  //if(i%2==1)
// if(i==0) 
//  doKboard(position, i, solM[0], 16);
  int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
  if (i%6==0) {
    doKboard(position, i, 43-12+24, 1);
  }else if (i==0 || i==6 || i==10 || i==13){
    doKboard(position, i, 43+xtra+24, 2);
  }
  //else if(i%3==0)  doKboard(position, i+1, 43+24, 1);
}
void kboardSim(int position, int i) {
  //if(i%2==1)
//  if(i==0) 
//  doKboard(position, i, sim[0], 16);
int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
  if (i%3==0) {
    doKboard(position, i, 47-12+24, 1);
  }
  else if (i==6){//2 || i==6 || i==10 || i==13) {
    doKboard(position, i, 47+xtra+24, 1);
    if (xtra!=0) {
      xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
      doKboard(position, i+1, 47+xtra+24, 1);
    }
  }
  else doKboard(position, i+1, 47+xtra+24, 1);//doBass(position, i, 47-24, 1);
}
void kboardDoM(int position, int i) {
  //if(i%2==0 || i%3==0)
//  if(i==0) 
//  doKboard(position, i, doM[0], 16);
  int xtra = random(100)>90?0:(random(100)>40)?3:(random(100)>50)?7:5;
  if (i%3==0) {
    doKboard(position, i, 36+24, 1);
  }
  else if (i==2 || i==6 || i==10 || i==13) {
    doKboard(position, i, 36+12+xtra+24, 2);
  }
  //else      doKboard(position, i, 36+7+24, 1);
}

