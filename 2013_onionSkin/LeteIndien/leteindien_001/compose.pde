void compose(){
  for(part = -1; part<36; part++){
    switch(part){
      case -1:
        part00();
        break;
      case 0:
      case 3:
        part01();
        break;
      case 1:
      case 2:
      case 4:
      case 5:
        part02();
        break;
    }
  }
}
void part00(){
  position+=quantization;
  bar=0;
}
void part01(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000();//rem
    if(bar==1)riff000();//rem
    if(bar==2)riff001();//solm
    if(bar==3)riff002();//laM
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
      doDrums(position, i, 42, 110, 120);   
      doDrums(position, i+1, 42, 110, 120);   
    }
    if(i%8==4)doDrums(position, i, 38, 110, 120);
}
void riff000(){//rem
  for(int i=0; i<quantization; i++){
    if(i%4==0){
      doBass(position,i,2,1);
      doBass(position,i+1,2,1);
    }
    if(i%4==2){
      doBass(position,i,2+12,1);
      doBass(position,i+1,2+12,1);
    }
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff000M(){//reM
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,2,1);
    if(i%4==2)doBass(position,i,2+12,1);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff001(){//solm
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,-5,1);
    if(i%4==2)doBass(position,i,-5+12,1);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff001M(){//solM
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,-5,1);
    if(i%4==2)doBass(position,i,-5+12,1);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff002(){//laM
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,-3,1);
    if(i%4==2)doBass(position,i,-3+12,1);    
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff002m(){//lam
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,-3,1);
    if(i%4==2)doBass(position,i,-3+12,1);    
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff003(){//sibm
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,-2,1);
    if(i%4==2)doBass(position,i,-2+12,1);    
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff004(){//mim
  for(int i=0; i<quantization; i++){
    if(i%4==0)doBass(position,i,4,1);
    if(i%4==2)doBass(position,i,4+12,1);    
    danceDrum(position,i);
  }
  position+=quantization;
}
