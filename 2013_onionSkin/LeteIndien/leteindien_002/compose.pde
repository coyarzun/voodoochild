void compose(){
  for(part = -1; part<10; part++){
    switch(part){
      case -1:
      case 6:
        part00();
        break;
      case 0:
      case 3:
      case 7:
        part01();
        break;
      case 1:
      case 2:
      case 4:
      case 5:
      case 8:
        part02();
        break;
      case 9:
        part00x();
        break;
    } 
  }
}
void part00(){
  position+=quantization;
  bar=0;
}
void part00x(){  
  riff000x();//rem
}
void part01(){  
  for(bar=0; bar<8; bar++){
    if(bar==0)riff000();//rem
    if(bar==1)riff000();//rem
    if(bar==2)riff001();//solm
    if(bar==3)riff002();//laM
    if(bar==4)riff000();//rem
    if(bar==5)riff000();//rem
    if(bar==6)riff001();//solm
    if(bar==7)riff002();//laM
  }
}
void part02(){  
  for(bar=0; bar<16; bar++){
    if(bar==0)riff000();//rem
    if(bar==1)riff000();//rem
    if(bar==2)riff002();//laM
    if(bar==3)riff002();//laM
    if(bar==4)riff000M();//reM
    if(bar==5)riff000M();//reM
    if(bar==6)riff001();//solm
    if(bar==7)riff001();//solm
    if(bar==8)riff003();//sib
    if(bar==9)riff003();//sib
    if(bar==10)riff000();//rem
    if(bar==11)riff000();//rem
    if(bar==12)riff004();//mi
    if(bar==13)riff004();//mi
    if(bar==14)riff002();//la7
    if(bar==15)riff002();//la7
  }
}
void danceDrum(int position, int i){
    if(i%4==0)doDrums(position, i, 36, 110, 120);
    if(i%4==2){
      doDrums(position, i, 44, 110, 120);   
      doDrums(position, i+1, 44, 110, 120);   
    }else{
      doDrums(position, i, 44, 110, 120);   
    }
    if(i%8==4)doDrums(position, i, 38, 110, 120);
}
void danceBass(int position, int i, int pitch, int mode){
  if(i%4==0){
      doBass(position,i,pitch,mode==9?16:1);
      doBass(position,i+1,pitch,mode==9?16:1);
  }
  if(i%4==2){
      doBass(position,i,pitch+12,1);
      doBass(position,i+1,pitch+12,1);
  }
}
void riff000(){//rem
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,2,16);
      doGuitar(position,i,2+3,16);
      doGuitar(position,i,2+7,16);
    }
    danceBass(position,i,2,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff000x(){//rem
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,2,16);
      doGuitar(position,i,2+3,16);
      doGuitar(position,i,2+7,16);
      danceBass(position,i,2,9);
      danceDrum(position,i);
    }
  }
  position+=quantization;
}
void riff000M(){//reM
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,2,16);
      doGuitar(position,i,2+4,16);
      doGuitar(position,i,2+7,16);
    }
    danceBass(position,i,2,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff001(){//solm
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,-5,16);
      doGuitar(position,i,-5+3,16);
      doGuitar(position,i,-5+7,16);
    }
    danceBass(position,i,-5,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff001M(){//solM
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,-5,16);
      doGuitar(position,i,-5+4,16);
      doGuitar(position,i,-5+7,16);
    }
    danceBass(position,i,-5,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff002(){//laM
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,-3,16);
      doGuitar(position,i,-3+4,16);
      doGuitar(position,i,-3+7,16);
    }
    danceBass(position,i,-3,0);   
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff002m(){//lam
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,-3,16);
      doGuitar(position,i,-3+3,16);
      doGuitar(position,i,-3+7,16);
    }
    danceBass(position,i,-3,0); 
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff003(){//sibM
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,-2,16);
      doGuitar(position,i,-2+4,16);
      doGuitar(position,i,-2+7,16);
    }
    danceBass(position,i,-2,0); 
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff004(){//miM
  for(int i=0; i<quantization; i++){
    if(i==0){
      doGuitar(position,i,4,1);
      doGuitar(position,i,4+4,16);
      doGuitar(position,i,4+7,16);
    }
    danceBass(position,i,4,0);    
    danceDrum(position,i);
  }
  position+=quantization;
}
