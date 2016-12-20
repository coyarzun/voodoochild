import rita.*;
PApplet p = this;
String[] lyrics;
Donmiguel donmiguel;
int kurrent = 0;

void setup(){
  donmiguel = new Donmiguel();
  lyrics = new String[56];
  lyrics[0]= "Cuando fui para la pampa ";
  lyrics[1]= "llevaba mi corazón ";
  lyrics[2]= "contento como un chirigüe, ";
  lyrics[3]= "pero allá se me murió, ";
  lyrics[4]= "primero perdí las plumas ";
  lyrics[5]= "y luego perdí la voz, ";
  lyrics[6]= "y arriba quemando el sol. ";

  lyrics[7]= "Cuando vide los mineros ";
  lyrics[8]= "dentro de su habitación ";
  lyrics[9]= "me dije: mejor habita ";
  lyrics[10]= "en su concha el caracol, ";
  lyrics[11]= "o a la sombra de las leyes ";
  lyrics[12]= "el refinado ladrón, ";
  lyrics[13]= "y arriba quemando el sol. ";

  lyrics[14]= "Las hileras de casuchas, ";
  lyrics[15]= "frente a frente, si, señor, ";
  lyrics[16]= "las hileras de mujeres ";
  lyrics[17]= "frente al único pilón, ";
  lyrics[18]= "cada una con su balde ";
  lyrics[19]= "y su cara de aflicción, ";
  lyrics[20]= "y arriba quemando el sol. ";

/*  lyrics[21]= "Fuimos a la pulpería ";
  lyrics[22]= "para comprar la ración, ";
  lyrics[23]= "veinte artículos no cuentan ";
  lyrics[24]= "LA REbaja de rigor, ";
  lyrics[25]= "con la canasta vacía ";
  lyrics[26]= "volvimos a la pensión, ";
  lyrics[27]= "y arriba quemando el sol. ";  

  lyrics[28]= "Zona seca de la pampa ";
  lyrics[29]= "escrito en un cartelón, ";
  lyrics[30]= "sin embargo, van y vienen ";
  lyrics[31]= "las botellas de licor, ";
  lyrics[32]= "claro que no son del pobre, ";
  lyrics[33]= "contrabando o qué sé yo, ";
  lyrics[34]= "y arriba quemando el sol. ";
*/
  lyrics[21]= "Paso por un pueblo muerto ";
  lyrics[22]= "se me nubla el corazón, ";
  lyrics[23]= "aunque donde habita gente ";
  lyrics[24]= "la muerte es mucho peor, ";
  lyrics[25]= "enterraron la justicia, ";
  lyrics[26]= "enterraron la razón, ";
  lyrics[27]= "y arriba quemando el sol. ";

  lyrics[28]= "Si alguien dice que yo sueño ";
  lyrics[29]= "cuentos de ponderación, ";
  lyrics[30]= "digo que esto pasa en Chuqui ";
  lyrics[31]= "pero en Santa Juana es peor, ";
  lyrics[32]= "el minero ya no sabe ";
  lyrics[33]= "lo que vale su sudor, ";
  lyrics[34]= "y arriba quemando el sol. ";

  lyrics[35]= "Me volví para Santiago ";
  lyrics[36]= "sin comprender el color ";
  lyrics[37]= "con que pintan la noticia ";
  lyrics[38]= "cuando el pobre dice no, ";
  lyrics[39]= "abajo, la noche oscura, ";
  lyrics[40]= "oro, salitre y carbón, ";
  lyrics[41]= "y arriba quemando el sol.";
  
  lyrics[41]= "y arriba quemando el sol.";
  lyrics[42]= "y arriba quemando el sol.";
  lyrics[43]= "y arriba quemando el sol.";
  lyrics[44]= "y arriba quemando el sol.";
  lyrics[45]= "y arriba quemando el sol.";
  lyrics[46]= "y arriba quemando el sol.";
  lyrics[47]= "y arriba quemando el sol.";
  lyrics[48]= "y arriba quemando el sol.";
  lyrics[49]= "y arriba quemando el sol.";
  lyrics[50]= "y arriba quemando el sol.";
  lyrics[51]= "y arriba quemando el sol.";
  lyrics[52]= "y arriba quemando el sol.";
  lyrics[53]= "y arriba quemando el sol.";
  lyrics[54]= "y arriba quemando el sol.";
  lyrics[55]= "y arriba quemando el sol.";

}
void draw(){
}
void keyPressed(){
  if(keyCode==32)donmiguel.sing(lyrics[(kurrent++)%56]);
}
class Donmiguel{
  RiSpeech speech1, speech2;

  Donmiguel(){
    speech1 = new RiSpeech(p); 
    speech1.setVoice("kevin");

    speech2 = new RiSpeech(p); 
    speech2.useMacTTS();
    speech2.setVoice("Kathy");

  }
  void sing(String $1){
    try{
      //if(random(100)>50){
      //  speech1.speak($1);
      //}else{
        speech2.speak($1);
      //}
    }
    catch(Exception e){
    }
  }
}



