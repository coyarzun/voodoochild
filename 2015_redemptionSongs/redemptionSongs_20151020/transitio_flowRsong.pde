class FlowRZong extends VZong {
  int[] drumpads = {
    35, 44, 46, 47, 48, 42
  };

  int quantization;
  int basepitch = 60;//2;
  int pitch = 60;
  int position;

  FlowRZong() {//first in oct2009, recoded jun 2010 // now oct2014
    lyrics = new String[1024][16];
    name = "FlowRZong!";
    makeSong();
    //vplayer.println("song "+name+" loaded!");
  }
  void makeSong() {
    beatMap = new BeatMap();
    drumstrack = new promidi.Track("drums", drumsout);
    basstrack = new promidi.Track("bass", bassout);
    basstrack2 = new promidi.Track("bass", bassout);
    guitartrack = new promidi.Track("guitar", guitarout);

    drumstrack.setQuantization(Q._1_16);
    basstrack.setQuantization(Q._1_16);
    basstrack2.setQuantization(Q._1_16);
    guitartrack.setQuantization(Q._1_16);

    //    bassout.sendProgramChange(new ProgramChange(82)); 
    //    guitarout.sendProgramChange(new ProgramChange(69));

    drumsout.sendController(new Controller(0, 1)); 
    drumsout.sendProgramChange(new ProgramChange(3)); 
    guitarout.sendProgramChange(new ProgramChange(106));//62));

    //score.empty();
    quantization = 16;
    position = 0;
    int tempo = 130;

    for (int i=0;i<128;i++) {
      makePattern(i);
      //position+=quantization;
    }

    song = new Song(name, tempo);
    song.addTrack(drumstrack);
    song.addTrack(basstrack);
    song.addTrack(basstrack2);
    song.addTrack(guitartrack);

    sequencer.setSong(song);
    sequencer.setLoopStartPoint(0);
    sequencer.setLoopEndPoint(512*(bars+4));
    sequencer.setLoopCount(-1);
    sequencer.noLoop();
    //score.tempo(130);
    //score.addCallbackListener(p);
  }
  void makePattern(int bar) {
    for (int i=0; i<16; i++) {
      int auxposition = position+i;//)/4;
      if (i%4== 0) {
        addDrum(auxposition, 36, 120);
        addDrum(auxposition+2, 36, 100);
        addHighNote(auxposition+i);
      }
      else if (i%8==6) {//%4==3//%8==6
        addDrum(auxposition, 38, 120);
        addHighNote(auxposition);//+i);
      }
      else if (random(1)<.8) {
        addDrum(auxposition, drumpads[(int)random(drumpads.length)], (int)random(80)+40);
        addHighNote(auxposition);//+i);
      }
      else if (random(1)<.9) {
        addDrum(auxposition, drumpads[(int)random(drumpads.length)]-24, (int)random(80)+40);
      }
    }
    position+=16;
    bars++;
  }
  void addDrum(int i, int pad, int vol) {
    drumstrack.addEvent(new Note(pad, vol, 80), i);
    drumstrack.addEvent(new Note(pad, 0, 0), i+1); 
    dobeat(i, pad);
  }
  void addHighNote(int i) {
    pitch = (int)score.pcRandomWalk(36+12, 12, score.MINOR_PENTATONIC);//INDIAN);

    basstrack.addEvent(new Note(pitch, int(90+random(20)), 1), i);
    basstrack.addEvent(new Note(pitch, 0, 0), i+1);

    basstrack2.addEvent(new Note(pitch, int(90+random(20)), 1), i);
    basstrack2.addEvent(new Note(pitch, 0, 0), i+1);

    basstrack.addEvent(new Note(pitch, int(2*15+40+random(40)), 1), i+2);
    basstrack.addEvent(new Note(pitch, 0, 0), i+2);
    
    basstrack2.addEvent(new Note(pitch, int(2*15+40+random(40)), 1), i+2);
    basstrack2.addEvent(new Note(pitch, 0, 0), i+2);

    guitartrack.addEvent(new Note(pitch+12*2, int(30+random(20)), 2), i);
    guitartrack.addEvent(new Note(pitch+12*2, 0, 0), i+2);
  }
}







