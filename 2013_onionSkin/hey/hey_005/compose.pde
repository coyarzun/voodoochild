void compose(){
  for(part = -1; part<6; part++){
    switch(part){
      case -1:
      default:
        part00();
        break;
      case 0:
        part01();
        break;
      case 1:
        part02();
        break;
      case 2:
        part03();
        break;
      case 3:
        part03x();
        break;        
      case 4:
        part02x();
        break;
      case 5:
        part04();
        break;
    }
  }
}
void part00(){
  position+=quantization;
  bar=0;
}
void part04(){
  for(bar=0; bar<4; bar++){
  if(bar==0)riff012();
  }
  position+=quantization;
  bar=0;
}
void part01(){  
  for(bar=0; bar<16; bar++){
  if(bar==0)riff000();
  if(bar==1)riff001();
  if(bar==2)riff002();
  if(bar==3)riff003();
  if(bar==4)riff004();
  if(bar==5)riff005();
  if(bar==6)riff002();
  if(bar==7)riff003();
  if(bar==8)riff004();
  if(bar==9)riff005();
  if(bar==10)riff002();
  if(bar==11)riff003();
  if(bar==12)riff004();
  if(bar==13)riff005();
  if(bar==14)riff002();
  if(bar==15)riff006();
  }
}
void part02(){  
  for(bar=0; bar<16; bar++){
  if(bar==0)riff007();
  if(bar==1)riff008();
  if(bar==2)riff009();
  if(bar==3)riff007();
  if(bar==4)riff008();
  if(bar==5)riff009();
  if(bar==6)riff007();
  if(bar==7)riff008();
  if(bar==8)riff009();
  if(bar==9)riff007();
  if(bar==10)riff008();
  if(bar==11)riff009();
  if(bar==12)riff007();
  if(bar==13)riff008();
  if(bar==14)riff010();
  if(bar==15)riff011();
  }
}
void part02x(){  
  for(bar=0; bar<13; bar++){
  if(bar==0)riff007();
  if(bar==1)riff008();
  if(bar==2)riff009();
  if(bar==3)riff007();
  if(bar==4)riff008();
  if(bar==5)riff009();
  if(bar==6)riff007();
  if(bar==7)riff008();
  if(bar==8)riff009();
  if(bar==9)riff007();
  if(bar==10)riff008();
  if(bar==11)riff009();
  if(bar==12)riff007();
  if(bar==13)riff008();
  }
}
void part03(){  
  for(bar=1; bar<16; bar++){
  //if(bar==0)riff005();
  if(bar==1)riff001();
  if(bar==2)riff002();
  if(bar==3)riff003();
  if(bar==4)riff004();
  if(bar==5)riff005();
  if(bar==6)riff002();
  if(bar==7)riff003();
  if(bar==8)riff004();
  if(bar==9)riff005();
  if(bar==10)riff002();
  if(bar==11)riff003();
  if(bar==12)riff004();
  if(bar==13)riff005();
  if(bar==14)riff002();
  //if(bar==15)riff006();
  if(bar==15)riff003x();
  }
}
void part03x(){  
  for(bar=0; bar<16; bar++){
  //if(bar==0)riff002x();
  if(bar==0)riff004x();
  if(bar==1)riff005();
  if(bar==2)riff002();
  if(bar==3)riff003();
  if(bar==4)riff004();
  if(bar==5)riff005();
  if(bar==6)riff002();
  if(bar==7)riff003();
  if(bar==8)riff004();
  if(bar==9)riff005();
  if(bar==10)riff002();
  if(bar==11)riff003();
  if(bar==12)riff004();
  if(bar==13)riff005();
  if(bar==14)riff002();
  if(bar==15)riff006();
  }
}
void riff000(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,6,16);
  }
  position+=quantization;
}
void riff001(){
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,9,2);
    if(i==2)doBass(position,i,10,2);
    if(i==4)doBass(position,i,11,4);
    if(i==10)doBass(position,i,11,4);
    if(i==14)doBass(position,i,11,2);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    //if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(true)doGuitar(position, i, (random(100)>50?0:12)+i>3?11:9, 1);
  }
  position+=quantization;  
}

void riff002(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,12,2);
    if(i==2)doBass(position,i,13,2);
    if(i==4)doBass(position,i,14,4);
    if(i==10)doBass(position,i,14,4);
    if(i==14)doBass(position,i,14,2);
    
    if(i%3==1 || i%3==2)doDrums(position, i, 42, 110, 120);
    //if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(i%3==0 || random(100)>50)doGuitar(position, i, (random(100)>50?0:12)+i>3?14:12, 1);
  }
  position+=quantization;  
}

void riff003(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,4,2);
    if(i==2)doBass(position,i,6,2);
    if(i==4)doBass(position,i,7,4);
    if(i==10)doBass(position,i,7,4);
    if(i==14)doBass(position,i,7,2);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    //if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(true)doGuitar(position, i, (random(100)>50?0:12)+i>3?7:4, 1);
  }
  position+=quantization;  
}
void riff003x(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,4,2);
    if(i==2)doBass(position,i,6,2);

    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    if(i%8==0)doDrums(position, i, 38, 110, 120);
    //if(i%8==4)doDrums(position, i, 36, 110, 120);
    //if(true)doGuitar(position, i, (random(100)>50?0:12)+i>3?7:4, 1);
  }
  position+=quantization;  
}
void riff004(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,4,2);
    if(i==2)doBass(position,i,5,2);
    if(i==4)doBass(position,i,6,4);
    if(i==10)doBass(position,i,6,4);
    if(i==14)doBass(position,i,6,2);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    //if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(true)doGuitar(position, i, (random(100)>50?0:12)+i>3?6:4, 1);
  }
  position+=quantization;  
}
void riff004x(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,4,2);
    if(i==2)doBass(position,i,5,2);
    if(i==4)doBass(position,i,6,4);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    //if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(i%3==0 || random(100)>50)doGuitar(position, i, (random(100)>50?0:12)+i>3?6:4, 1);
  }
  position+=quantization;  
}
void riff005(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,9,2);
    if(i==2)doBass(position,i,10,2);
    if(i==4)doBass(position,i,11,4);
    if(i==10)doBass(position,i,11,4);
    if(i==14)doBass(position,i,11,2);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
   // if(true)doGuitar(position, i, (random(100)>50?0:12)+i>3?11:9, 1);
  }
  position+=quantization;  
}
void riff006(){//
  for(int i=0; i<quantization+2; i++){
    if(i==0)doBass(position,i,4,2);
    if(i==2)doBass(position,i,6,2);
    if(i==4)doBass(position,i,7,2);
    if(i==6)doBass(position,i,7+12,2);
    if(i==8)doBass(position,i,7,2);
    if(i==10)doBass(position,i,7+12,2);    
    if(i==12)doBass(position,i,7,2);    
    if(i==14)doBass(position,i,7+12,2);    
    //yeah!
    if(i==16)doBass(position,i,7,2);    
    if(i==18)doBass(position,i,7+12,2); 

    if(i%2==0 || i>8)doDrums(position, i, 42, 110, 120);
    //if(i%8==0 && i<16)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(true)doGuitar(position, i, (random(100)>50?0:12)+i>3?7:4, 1);
  }
  position+=quantization+2;  
}
void riff007(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,4,2);
    if(i==2)doBass(position,i,4+12,2);
    if(i==4)doBass(position,i,4,2);
    if(i==6)doBass(position,i,4+12,2);
    if(i==8)doBass(position,i,4,2);
    if(i==10)doBass(position,i,4+12,2);    
    if(i==12)doBass(position,i,4,2);    
    if(i==14)doBass(position,i,4+12,2);    
    
    //if(i%2==0)
    doDrums(position, i, 42, 110, 120);
    if(i%8==4)doDrums(position, i, 38, 110, 120);
    if(i%8==0)doDrums(position, i, 36, 110, 120);
    
    if(i%3==0 || random(100)>50)doGuitar(position, i, random(100)>50?4:16, 1);
  }
  position+=quantization;  
}
void riff008(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,11,2);
    if(i==2)doBass(position,i,11+12,2);
    if(i==4)doBass(position,i,11,2);
    if(i==6)doBass(position,i,11+12,2);
    if(i==8)doBass(position,i,11,2);
    if(i==10)doBass(position,i,11+12,2);    
    if(i==12)doBass(position,i,11,2);    
    if(i==14)doBass(position,i,11+12,2);  
  
    //if(i%2==0)
    doDrums(position, i, 42, 110, 120);  
    if(i%8==4)doDrums(position, i, 38, 110, 120);
    if(i%8==0)doDrums(position, i, 36, 110, 120);
    
    if(true)doGuitar(position, i, random(100)>50?11:23, 1);
  }
  position+=quantization;  
}
void riff009(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,7,2);
    if(i==2)doBass(position,i,7+12,2);
    if(i==4)doBass(position,i,7,2);
    if(i==6)doBass(position,i,7+12,2);
    if(i==8)doBass(position,i,7,2);
    if(i==10)doBass(position,i,7+12,2);    
    if(i==12)doBass(position,i,7,2);    
    if(i==14)doBass(position,i,7+12,2); 
 
    //if(i%2==0)
    doDrums(position, i, 42, 110, 120);   
    if(i%8==4)doDrums(position, i, 38, 110, 120);
    if(i%8==0)doDrums(position, i, 36, 110, 120);
    
    if(i%3==0 || random(100)>50)doGuitar(position, i, random(100)>50?19:7, 1);
  }
  position+=quantization;  
}
void riff010(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,7,4);
    if(i==6)doBass(position,i,7,4);
    if(i==10)doBass(position,i,7,2);
    if(i==12)doBass(position,i,4,2);
    if(i==14)doBass(position,i,5,2);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%8==4)doDrums(position, i, 36, 110, 120);
    
    //if(i%3==0 || random(100)>50)doGuitar(position, i, (random(100)>50?0:12)+i>11?4:7, 1);
  }
  position+=quantization;  
}

void riff011(){//
  for(int i=0; i<12; i++){
    if(i==0)doBass(position,i,6,4);
    if(i==6)doBass(position,i,6,4);
    if(i==10)doBass(position,i,6,2);
    
    if(i%2==0)doDrums(position, i, 42, 110, 120);
    if(i%8==0)doDrums(position, i, 38, 110, 120);
    if(i%4==8)doDrums(position, i, 36, 110, 120);
    
    if(i%3==0 || random(100)>50)doGuitar(position, i,random(100)>50?6:18, 1);
  }
  position+=12;  
}
void riff012(){//
  for(int i=0; i<quantization; i++){
    if(i==0)doBass(position,i,11,4*4);
  }
  position+=quantization;
}
