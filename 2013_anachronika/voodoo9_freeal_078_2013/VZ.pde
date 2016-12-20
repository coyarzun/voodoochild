class VZession{
  XMLElement xmlsession;
  XMLElement[] xmlzongs;
  VZong zong = new VZong();

  String name;
  String file;

  int index = 0;//-1;
  boolean sessionloaded = false;

  VZession(String $1){
    file = $1;
    loadSession();
    //loadSong(index);
  }
  void loadSession(){
    try{
      xmlsession = new XMLElement(p, file);
      name = xmlsession.getStringAttribute("name");
      xmlzongs = xmlsession.getChildren();
      sessionloaded = true;
      vplayer.println("Session "+name+" loaded");
    }
    catch(Exception ide){
      vplayer.println("File does not exist");
      sessionloaded = false;
    }
  }
  void loadSong(int $1){
    if($1<0)$1=xmlzongs.length-1;
    if($1>xmlzongs.length-1)$1=0;

    if(sessionloaded && index>=0){
      if(zong.rocking)zong.stop();      
      if($1<xmlzongs.length){
        String tmpfile = xmlzongs[$1].getStringAttribute("file");
        if(tmpfile!=null){
          zong = new XMLZong(tmpfile);
        }
        else{
          String tmpclass = xmlzongs[$1].getStringAttribute("class");
          if(tmpclass!=null){
            if(tmpclass.equals("FreshWidow"))zong = new FreshWidow();
            if(tmpclass.equals("OKeymickey"))zong = new OKeymickey();
            if(tmpclass.equals("Punkrocker"))zong = new Punkrocker();
            if(tmpclass.equals("SheLost"))zong = new SheLost();
          }
        }        
      }
      index = $1;
      if(zong.name.equals("She lost"))donmiguel.sing("this is a Joy Division cover, .... She lost!");  
      if(zong.name.equals("antarctic"))donmiguel.sing("this is ANTARCTIC");  
      if(zong.name.equals("songzero"))donmiguel.sing("this call songzero");  

    }
    else{
      vplayer.println("you must load a session first");
    }
  }
  void draw(){
    try{
      //if(sessionloaded)zong.draw();
    }
    catch(Exception e){
      vplayer.println("you're not ready to draw");
    }    
  }
  void rock(){
    try{
      if(sessionloaded){
        if(!zong.rocking){
          zong.rock();
        }
        else{
          zong.stop();
        }
      }
    }
    catch(Exception e){
      vplayer.println("you're not ready to rock");
    }
  }
  void next(){
    loadSong(index+1);
  }
  void prev(){
    loadSong(index-1);
  }
  void checksong(){
    try{
      if(sessionloaded){
        zong.checksong();
      } 
    }
    catch(Exception e){
    }
  }
}





