void compose(){
  for(part = -1; part<16; part++){
    switch(part){

      case -1:
        part00();
        break;
      case 0:
      case 10:
        part00x();
        break;
      case 2:
        part00xx();
        break;
      case 1:
      default:
        part01();
        break;
      case 3:
      case 4:
      case 5:
        part02();
        break;
      case 6:
        part03();
        break;
      case 7:
      case 8:
      case 9:
        part04();
        break;
    } 
  }
}


void part00(){
  position+=quantization;
  bar=0;
}
void part00x(){
  riff000x();
  riff000x();
  riff000x();
  riff000x();
}
void part00xx(){
  riff000x();
  //riff000x();
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
    if(bar==4)riff001();//mim
    if(bar==5)riff001();//mim
  }
}
void part03(){  
  for(bar=0; bar<9; bar++){
    if(bar==0)riff000();//SOLM
    if(bar==1)riff000();//SOLM
    if(bar==2)riff001();//mim
    if(bar==3)riff001();//mim
    if(bar==4)riff002();//laM
    if(bar==5)riff002();//laM
    if(bar==6)riff000();//solM
    if(bar==7)riff001();//mim
    if(bar==8)riff002();//laM
    if(bar==9)riff002();//laM
  }
  riff000x();
  riff000x();
}
void part04(){  
  for(bar=0; bar<4; bar++){
    if(bar==0)riff000d();//SOLM
    if(bar==1)riff002();//laM
    if(bar==2)riff003();//doM
    if(bar==3)riff004();//Ab-->G
  }
}
void riff000x(){//just drum
  for(int i=0; i<quantization; i++){
    tryDrum(position,i);
  }
  position+=quantization;
}
void riff000(){//SOLM
  for(int i=0; i<quantization; i++){
    //tryGuitar(position,i,7,11,12,14,0);
    tryBass(position,i,7,7,7,7,0);
    tryDrum(position,i);
  }
  position+=quantization;
}
void riff000d(){//SOLM
  for(int i=0; i<quantization; i++){
    //tryGuitar(position,i,7,11,12,14,0);
    tryBass(position,i,7,7,7,7,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff001(){//mim
  for(int i=0; i<quantization; i++){
    //tryGuitar(position,i,9,13,14,16,0);
    //tryBass(position,i,4+12,7+12,9+12,11,0);
    tryBass(position,i,16,16+12,16,16+12,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff002(){//LaM
  for(int i=0; i<quantization; i++){
    //tryGuitar(position,i,9,13,14,16,0);
    //tryGuitar(position,i,7+2,11+2,12+2,14+2,0);
    //tryBass(position,i,9,13,14,16,0);// tryBass(position,i,9,9,9,9,0); //??
  tryBass(position,i,9,9+12,9,9+12,0); //??
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff003(){//DoM
  for(int i=0; i<quantization; i++){
    //tryGuitar(position,i,12,16,17,19,0);
    //tryGuitar(position,i,7+2+3,11+2+3,12+2+3,14+2+3,0);
    tryBass(position,i,12,24,12,24,0);
    danceDrum(position,i);
  }
  position+=quantization;
}
void riff004(){//otra cosa
  for(int i=0; i<quantization; i++){
    int f = (i<8)?0:-1;
    //tryGuitar(position,i,8+f,12+f,13+f,15+f,0);
    //tryGuitar(position,i,8+7+f,12+7+f,13+7+f,15+7+f,0);
    tryBass(position,i,8+7+f,8+12+7+f,8+7+f,8+12+7+f,0);
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
      //doBass(position,i+1,pitch,mode==9?16:1);
  }
  if(i%4==2){
      doBass(position,i,pitch+12,1);
      doBass(position,i+1,pitch+12,1);
  }
}
void tryDrum(int position, int i){
    if(i%8==0 || i==3 || i==5 || i==10 || i==11 || i==1 || i==15){
      doDrums(position, i, 36, 110, 120);
    }
    if(true){//i%2==0){
      doDrums(position, i, 42, 110, 120);   
    }
    if(i%4==2){
      doDrums(position, i, 38, 110, 120);
    }
}
void tryGuitar(int position, int i, int p1, int p2, int p3, int p4, int mode){

}
void tryBass(int position, int i, int p1, int p2, int p3, int p4, int mode){
      //p1-=12;p2-=12;p3-=12;p4-=12;
      int[] p = {p1,p2,p3,p4};
      p1 = p[(2*i)%p.length];
      doBass(position,i,p1,mode==9?16:1);
      doBass(position,i+1,p1,mode==9?16:1);
}
