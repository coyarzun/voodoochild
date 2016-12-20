void keyReleased() {
  switch(key){
  case '1':
    //donmiguel.sing("BUENAS NOCHES..... ESTO ES VOOOODOOOOCHILD: ALGORHYTMIC XPERIENCE, OH YEAH!");
    session.loadSong(0);
    break;
  case '2':
    session.loadSong(1);      
    break;
  case '3':
    session.loadSong(2);
    break;
  case '4':
    session.loadSong(3);
    break;
  case '5':
    session.loadSong(4);
    break;
  case '6':
    session.loadSong(5);
    break;
  case '7':
    session.loadSong(6);
    break;
  case '8':
    session.loadSong(7);
    break;
  case '9':
    session.loadSong(8);
    break;
  case '0':
    session.loadSong(9);
    break;
  case 'q':
    session.loadSong(10);
    break;
  case 'w':
    session.loadSong(11);
    break;
  case 'e':
    session.loadSong(12);
    break;
  case 'r':
    session.loadSong(13);
    break;
  case 't':
    session.loadSong(14);
    break;
  case 'a':
    donmiguel.sing("gracias!! thank you!");
    break;
  case 's':
    donmiguel.sing("GRACIAS!!!");
    //donmiguel.sing("this was voodoo child.\nSee u later\n\noh yeah!");
    break;
  case 'd':
    donmiguel.sing("esto fue vooodooochild!! OH YEAH!!!");
    /*
        donmiguel.sing("this is ANTARCTIC");  
    donmiguel.sing("this call songzero");  

    */
    break;
  case 'f':
    fsStatus=!fsStatus;
    if(fsStatus){
      //size(screen1.width+screen2.width, max(screen1.height, screen2.height));
      //fs.setResolution(screen1.width+screen2.width, max(screen1.height, screen2.height));
      fs.enter();
    }else{
      //size(800,400);
      fs.leave();
    }
    break;
  }
  if (keyCode == 32) {
    session.rock();
  }
  if(keyCode == RIGHT)session.next();
  if(keyCode == LEFT)session.prev();
}

void keyPressed(){

}

