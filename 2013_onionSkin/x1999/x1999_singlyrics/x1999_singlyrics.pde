import rita.*;
PApplet p = this;
String[] lyrics;
Donmiguel donmiguel;
int kurrent = 0;

void setup() {
  donmiguel = new Donmiguel();
  lyrics = new String[54];

  lyrics[0]="Samekitta machi ni wakare o tsuge";
  lyrics[1]="Arekuruu shigeki ni mi o sarase";
  lyrics[2]="Aitsu no hitomi wa hikari-useta";
  lyrics[3]="Moekuruu kokoro wa ayatsurenai";

  lyrics[4]="Midareta ai ni nagasare";
  lyrics[5]="omae wa subete o ushinatta";
  lyrics[6]="Karada tsuranuku sakebi de";
  lyrics[7]="omae no kokoro kowashite yaru";

//bridge

  lyrics[8]="Sabi-tsuita kotoba nage-sutete";
  lyrics[9]="Harisakeru kokoro o toki-hanate";
  lyrics[10]="Furishikiru ame ni se wo mukete";
  lyrics[11]="Ikizuku yatsura ni kotoba wa nai";

  lyrics[12]="Umoreta toki tomado";
  lyrics[13]="omae wa akumu o samayo";
  lyrics[14]="Chi no kifuruwasu Noise de"; 
  lyrics[15]="omae no kokoro kowashite yaru";

  lyrics[16]="X! kanjite miro!";
  lyrics[17]="X! sakende miro!";
  lyrics[18]="X! subete nugisutero!";
  lyrics[19]="X! kanjite miro!";
  lyrics[20]="X! sakende miro!";
  lyrics[21]="X! kokoro moyase!";


//solo


  lyrics[22]="X! You don't have to hesitate!";
  lyrics[23]="Get yourself out!";
  lyrics[24]="You know You are the best!";
  lyrics[25]="Let's get Crazy!";

  lyrics[26]="X! kanjite miro!";
  lyrics[27]="X! sakende miro!";
  lyrics[28]="X! subete nugisutero!";
  lyrics[29]="X! kanjite miro!";
  lyrics[30]="X! sakende miro!";
  lyrics[31]="X! kokoro moyase!";

  lyrics[32]="Midareta ai ni nagasare";
  lyrics[33]="omae wa subete o ushinatta";
  lyrics[34]="Karada tsuranuku sakebi de";
  lyrics[35]="omae no kokoro kowashite yaru";

  lyrics[36]="X! kanjite miro!";
  lyrics[37]="X! sakende miro!";
  lyrics[38]="X! subete nugisutero!";
  lyrics[39]="X! kanjite miro!";
  lyrics[40]="X! sakende miro!";
  lyrics[41]="X! kokoro moyase!";

  lyrics[42]="X! kanjite miro!";
  lyrics[43]="X! sakende miro!";
  lyrics[44]="X! subete nugisutero!";
  lyrics[45]="X! kanjite miro!";
  lyrics[46]="X! sakende miro!";
  lyrics[47]="X! kokoro moyase!";
  
  lyrics[48]="X! kanjite miro!";
  lyrics[49]="X! sakende miro!";
  lyrics[50]="X! subete nugisutero!";
  lyrics[51]="X! kanjite miro!";
  lyrics[52]="X! sakende miro!";
  lyrics[53]="X! kokoro moyase!";
}
void draw() {
}
void keyPressed() {
  if (keyCode==32)donmiguel.sing(lyrics[(kurrent++)%54]);
}
class Donmiguel {
  RiSpeech speech1, speech2;

  Donmiguel() {
    speech1 = new RiSpeech(p); 
    speech1.setVoice("kevin");

    speech2 = new RiSpeech(p); 
    speech2.useMacTTS();
    speech2.setVoice("Kathy");
  }
  void sing(String $1) {
    try {
      //if(random(100)>50){
      //speech1.speak($1);
      //}else{
      speech2.speak($1);
      //}
    }
    catch(Exception e) {
    }
  }
}


