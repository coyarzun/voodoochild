class Band{
  Drummer drummer;
  Bassplayer bassplayer;
  Guitarplayer guitarplayer;
  Donmiguel donmiguel;
  Skreener skreener;
  
  float mintempo = 100;
  float maxtempo = 180;
  float tempo = maxtempo;
  int volume = 127;
  
  boolean zongloaded = false;
  boolean rocking = false;
  
  int bar, frame, oldbar, oldframe;
  
  Zong kurrent;
  
  Band(){
    drummer = new Drummer("drumpatterns.txt");
    bassplayer = new Bassplayer("basspatterns.txt");
    guitarplayer = new Guitarplayer("guitarpatterns.txt");
    donmiguel = new Donmiguel();
    skreener = new Skreener();
  }
  void rawTempo(int v){
    setTempo(mintempo+(maxtempo-mintempo)*v/127);
  }
  void setTempo(float t){
    drummer.setTempo(t);
    bassplayer.setTempo(t);
    guitarplayer.setTempo(t);
    tempo = t;
  }
  void setVolume(int v){
    drummer.setMasterVolume(v);
    bassplayer.setMasterVolume(v);
    guitarplayer.setMasterVolume(v);
    volume = v;
  }
  void loadZong(Zong $1){
    bassplayer.tab = $1.basstab;
    bassplayer.kurrent = $1.basspattern;
    bassplayer.setVolume($1.basslevel);
    bassplayer.setInstrument($1.bassinstrument);
    bassplayer.parsePatterns();
    
    guitarplayer.tab = $1.guitartab;
    guitarplayer.kurrent = $1.guitarpattern;
    guitarplayer.setVolume($1.guitarlevel);
    guitarplayer.setInstrument($1.guitarinstrument);
    guitarplayer.parsePatterns();
    
    drummer.kurrent = $1.drumpattern;
    drummer.setVolume($1.drumlevel);
    drummer.parsePatterns();
    
    donmiguel.loadLyrics($1.lyricurl);
    donmiguel.tab = $1.voicetab;
    
    setTempo($1.tempo);
    setVolume($1.mainlevel);
    
    zongloaded = true;
    skreener.txtoutput.display = ($1.name+" loaded!");
    kurrent = $1;
  }
  void rock(){
    if(zongloaded){
      drummer.sequencer.start();
      bassplayer.sequencer.start();
      guitarplayer.sequencer.start();
      rocking = true;  
      skreener.txtoutput.display = (kurrent.name+" rocking!!!");
      skreener.songon(kurrent.id);
    }else{
      stop();
    }
  }
  void stop(){
    if(zongloaded){
      skreener.txtoutput.display = (kurrent.name+" finished.");
      skreener.txtoutput.bars = "";
      skreener.txtoutput.tempo = "";
      skreener.txtoutput.frame = "";
      zongloaded = false;
      drummer.sequencer.stop();
      bassplayer.sequencer.stop();
      guitarplayer.sequencer.stop();
      rocking = false;
      skreener.songoff();
    }
  }

  void checksong(){
    if(rocking){
      bar = int(drummer.sequencer.getTickPosition()/512);
      frame = int((drummer.sequencer.getTickPosition()%512)/32);
      
      skreener.txtoutput.bars = "BAR: "+bar+"/"+(kurrent.drumpattern.length-1);
      skreener.txtoutput.tempo = kurrent.tempo+" bpm";
      skreener.txtoutput.frame = "f "+frame;
      
      //if(oldbar!=bar || oldframe!=frame){
        int index = donmiguel.tab[bar][frame];
    
        donmiguel.sing(index);
      //};
      if(!kurrent.loopeable && bar<oldbar){
        stop();
      }      
      oldbar=bar;
      oldframe=frame;
    }
    skreener.draw();
  }
 } 
 
 
