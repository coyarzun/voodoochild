void compose(){
  for(part = -1; part<30; part++){
    switch(part){
      case -1:
        silence();
        break;
      case 0:
        counter();
        break;
      case 1:
      case 2:
      case 3:
        part001();
        break;
      case 4:
        part001b();
        break;
      case 5:
      case 6:
      case 7:
        part001();
        break;
      case 8:
        part001b();
        break;
        /*
      case 9:
      case 10:
      case 11:
        part001();
        break;
      case 12:
        part001b();
        break;
        */
        /*
      case 13:
      case 14:
      case 15:
        part001();
        break;
      case 16:
        part001b();
        break;
      */
      case 9:
      case 10:
      case 11:
      case 12:
        part002();
        break;
        
      case 13:
      case 14:
      case 15:
        part001();
        break;
      case 16:
        part001b();
        break;
      
        
      case 17:
      case 18:
      case 19:
        part002();
        break;
      case 20:
        part003();
         break;
       
      case 21:
      case 22:
      case 23:
        part001();
        break;
      case 24:
        part001b();
        break;
      //  part001();
      //  break;
      case 25:
      case 26:
      case 27:
      case 28:
        part001b();
        break;
     
      case 29:
        part001f();
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
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000();
    if(bar==1)riff000();
    if(bar==2)riff001();
    if(bar==3)riff002();
  }
}
void part001b(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000();
    if(bar==1)riff000();
    if(bar==2)riff001b();
    if(bar==3)riff002b();
  }
}
void part002(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff002();
    if(bar==1)riff003();
    if(bar==2)riff000b();
    if(bar==3)riff000b();
  }
}
void part003(){  
  for(bar=0; bar<8; bar++){
    if(bar==0)riff002();
    if(bar==1)riff003();
    if(bar==2)riff002();
    if(bar==3)riff003();
    
    if(bar==4)riff002();
    if(bar==5)riff003();
    if(bar==6)riff000bx();
    if(bar==7)riff000bx();
  }
}

void part001f(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000();
    if(bar==1)riff001();
    if(bar==2)riff002();
    if(bar==3)riff002f();
  }
}
void riff000(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bass001(position, i);
    keyb002(position, i);
  }
  position+=quantization;
}
void riff000b(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bass001b(position, i);
    keyb001(position, i);
  }
  position+=quantization;
}
void riff000bx(){
  for(int i=0; i<quantization; i++){
    drums001f(position,i);
    bass001b(position, i);
    keyb001(position, i);
  }
  position+=quantization;
}
void riff001(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bass002(position, i);
    keyb002(position, i);
  }
  position+=quantization;
}
void riff001b(){
  for(int i=0; i<quantization; i++){
    drums001f(position,i);
    bass002(position, i);
  }
  position+=quantization;
}
void riff002(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bass003(position, i);
    keyb002(position, i);
  }
  position+=quantization;
}
void riff002b(){
  for(int i=0; i<quantization; i++){
    drums001f(position,i);
    bass003(position, i);
    keyb001(position, i);
  }
  position+=quantization;
}
void riff003(){
  for(int i=0; i<quantization; i++){
    drums001(position,i);
    bass004(position, i);
    keyb002(position, i);
  }
  position+=quantization;
}
void riff002f(){
  for(int i=0; i<quantization+1; i++){
    drums001f(position,i);
    bass003f(position, i);
  }
  position+=quantization;
}
/***************************/
//int raska;

void drums001(int position, int i){
  //if((raska/16)%2==0){
    if(i%8==0 || i%16==10){//(i==0 || i==8 || i==10){
      doDrums(position, i, 36, 110, 120);
    }
  /*}else{
    if(i%4==0 || i==14){//(i==0 || i==8 || i==10){
      doDrums(position, i, 36, 110, 120);
    }
  }*/
  if(i==4 || i==12){
    doDrums(position, i, 38, 110, 120);
  }
  if(i%2==0){
    //doDrums(position, i, 42, 110, 120);
    doDrums(position, i, 44, 110, 120);
  }
  //raska++;
}
void drums001f(int position, int i){
  if(i%4==0){//(i==0 || i==8 || i==10){
    doDrums(position, i, 36, 110, 120);
  }
  //if(i==4 || i==12 || i==8 || i==0){
    doDrums(position, i, 38, 110+int(random(16)), 120);
  //}
  if(true){
    doDrums(position, i, i%4==3?42:44, 110, 120);
  }
}
void bass001(int position, int i){
  if(i%2==0)
    doBass(position, i, 38+2, 1);
}
void bass001b(int position, int i){
  if(i%2==0)
    doBass(position, i, 38-12+2, 1);
}
void bass002(int position, int i){
 if(i%2==0)
    doBass(position, i, 31+2, 1);
 
}
void bass003(int position, int i){
  if(i%2==0)
    doBass(position, i, 34+2, 1);
 
}
void bass004(int position, int i){
  if(i%2==0)
    doBass(position, i, 33+2, 1);
 
}

void bass003f(int position, int i){
  if(i%2==0)
    doBass(position, i, 38+2, 8);
 }
void bass004f(int position, int i){
  if(i%2==0)
    doBass(position, i, 34+2, 1);
 
}

void keyb001(int position, int i){
  if(i%3==0)
   doKboard(position, i, 59+24, 1);
}
void keyb002(int position, int i){
  if(i%3==0)
   doKboard(position, i, 59+24, 1);
   else if(i%2==0)
   if(random(100)>30)
     doKboard(position, i, 59+24+12, 1);
   else if(random(100)>50)
   doKboard(position, i, 59+24+12-2, 1);
   else
   doKboard(position, i, 59+24+12-5, 1);
}
