void compose(){
  for(part = -1; part<18; part++){
    switch(part){
      case -1:
      
        part00();
        break;
      case 0:
      default:
        part01();
        break;
      case 1:
      case 2:
      case 3:
        part02();
        break;
      case 4:
        part03();
        break;
      case 5:
      case 6:
      case 7:

        part04();
        break;
    } 
  }
}


void part00(){
  position+=quantization;
  bar=0;
}
void part01(){  
  for(bar=0; bar<8; bar++){
    riff000();//SOLM
  }
}
void part02(){  
  for(bar=0; bar<6; bar++){
    if(bar==0)riff000();//SOLM
    if(bar==1)riff000();//SOLM
    if(bar==2)riff000();//SOLM
    if(bar==3)riff000();//SOLM
    if(bar==4)riff001();//mim
    if(bar==5)riff001();//mim
  }
}
void part03(){  
  for(bar=0; bar<10; bar++){
    if(bar==0)riff000();//SOLM
    if(bar==1)riff000();//SOLM
    if(bar==2)riff001();//mim
    if(bar==3)riff001();//mim
    if(bar==4)riff002();//laM
    if(bar==5)riff000();//solM
    if(bar==6)riff000();//solM
    if(bar==7)riff001();//mim
    if(bar==8)riff002();//laM
    if(bar==9)riff002();//laM
  }
}
void part04(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000();//SOLM
    if(bar==1)riff002();//laM
    if(bar==2)riff003();//doM
    if(bar==3)riff004();//Ab-->G
  }
}

void riff000(){//SOLM
  for(int i=0; i<quantization; i++){
    tryGuitar(position,i,7,11,12,14,0);
    tryBass(position,i,7,11,12,14,0);
    tryDrum(position,i);
  }
  position+=quantization;
}
void riff001(){//mim
  for(int i=0; i<quantization; i++){
    tryGuitar(position,i,9,13,14,16,0);
    tryBass(position,i,4,7,9,11,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff002(){//LaM
  for(int i=0; i<quantization; i++){
    tryGuitar(position,i,9,13,14,16,0);
    tryBass(position,i,9,13,14,16,0);
    tryDrum(position,i);
  }
  position+=quantization;
}
void riff003(){//DoM
  for(int i=0; i<quantization; i++){
    tryGuitar(position,i,12,16,17,19,0);
    tryBass(position,i,12,16,17,19,0);
    tryDrum(position,i);
  }
  position+=quantization;
}
void riff004(){//otra cosa
  for(int i=0; i<quantization; i++){
    int f = (i<3)?0:-1;
    tryGuitar(position,i,8+f,12+f,13+f,15+f,0);
    tryBass(position,i,8+f,12+f,13+f,15+f,0);
    danceDrum(position,i);
  }
  position+=quantization;
}


/***************************/
/***************************/
/***************************/
/***************************/
void danceDrum(int position, int i){
    if(i%4==0)doDrums(position, i, 36, 110, 120);
    if(i%2==0){
      doDrums(position, i, 44, 110, 120);   
      doDrums(position, i+1, 44, 110, 120);   
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
void tryDrum(int position, int i){
    if(i%8==0 || i==3 || i==5 || i==10 || i==11 || i==1 || i==15){
      doDrums(position, i, 36, 110, 120);
      //doDrums(position, i+2, 36, 110, 120);
    }
    if(true){//i%2==0){
      doDrums(position, i, 42, 110, 120);   
    }
    if(i%8==4){
      doDrums(position, i, 38, 110, 120);
      //doDrums(position, i+1, 38, 110, 120);
      //doDrums(position, i+2, 38, 110, 120);
    }
}
void tryGuitar(int position, int i, int p1, int p2, int p3, int p4, int mode){
      //p1-=12;p2-=12;p3-=12;p4-=12;
      int[] p = {p1,p2,p3,p4};
      p1 = p[(2*i)%p.length];
      p1-=48;
      doGuitar(position,i,p1,mode==9?16:1);
      doGuitar(position,i+1,p1,mode==9?16:1);
}
void tryBass(int position, int i, int p1, int p2, int p3, int p4, int mode){
      //p1-=12;p2-=12;p3-=12;p4-=12;
      int[] p = {p1,p2,p3,p4};
      p1 = p[(2*i)%p.length];
      doBass(position,i,p1,mode==9?16:1);
      doBass(position,i+1,p1,mode==9?16:1);
}
void tryNOBass(int position, int i, int p1, int p2, int p3, int p4, int mode){
  p1-=12;p2-=12;p3-=12;p4-=12;
  if(i==0 || i==2){
      doBass(position,i,p1,mode==9?16:1);
      doBass(position,i+1,p1,mode==9?16:1);
  }else
  if(i==4 || i==6){
      doBass(position,i,p2,mode==9?16:1);
      doBass(position,i+1,p2,mode==9?16:1);
  }else
  if(i==8+1 || i==10+1){
      doBass(position,i,p3,mode==9?16:1);
      doBass(position,i+1,p3,mode==9?16:1);
  }else
  if(i==12+1 || i==14+1){
      doBass(position,i,p4,mode==9?16:1);
      doBass(position,i+1,p4,mode==9?16:1);
  }else
  {
      p1=random(100)>25?p1:random(100)>25?p2:random(100)>25?p3:p4;
      p1+=12;
      doBass(position,i,p1,mode==9?16:1);
      doBass(position,i+1,p1,mode==9?16:1);
  }

}
