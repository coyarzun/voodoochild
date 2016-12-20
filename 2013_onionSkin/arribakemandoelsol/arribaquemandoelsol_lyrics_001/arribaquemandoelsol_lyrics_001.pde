import rita.*;
PApplet p = this;
String lyrics;
Donmiguel donmiguel;

void setup(){
  donmiguel = new Donmiguel();
  lyrics = "Cuando fui para la pampa ";
  lyrics+= "llevaba mi corazón ";
  lyrics+= "contento como un chirigüe, ";
  lyrics+= "pero allá se me murió, ";
  lyrics+= "primero perdí las plumas ";
  lyrics+= "y luego perdí la voz, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Cuando vide los mineros ";
  lyrics+= "dentro de su habitación ";
  lyrics+= "me dije: mejor habita ";
  lyrics+= "en su concha el caracol, ";
  lyrics+= "o a la sombra de las leyes ";
  lyrics+= "el refinado ladrón, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Las hileras de casuchas, ";
  lyrics+= "frente a frente, si, señor, ";
  lyrics+= "las hileras de mujeres ";
  lyrics+= "frente al único pilón, ";
  lyrics+= "cada una con su balde ";
  lyrics+= "y su cara de aflicción, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Fuimos a la pulpería ";
  lyrics+= "para comprar la ración, ";
  lyrics+= "veinte artículos no cuentan ";
  lyrics+= "LA REbaja de rigor, ";
  lyrics+= "con la canasta vacía ";
  lyrics+= "volvimos a la pensión, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Zona seca de la pampa ";
  lyrics+= "escrito en un cartelón, ";
  lyrics+= "sin embargo, van y vienen ";
  lyrics+= "las botellas de licor, ";
  lyrics+= "claro que no son del pobre, ";
  lyrics+= "contrabando o qué sé yo, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Paso por un pueblo muerto ";
  lyrics+= "se me nubla el corazón, ";
  lyrics+= "aunque donde habita gente ";
  lyrics+= "la muerte es mucho peor, ";
  lyrics+= "enterraron la justicia, ";
  lyrics+= "enterraron la razón, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Si alguien dice que yo sueño ";
  lyrics+= "cuentos de ponderación, ";
  lyrics+= "digo que esto pasa en Chuqui ";
  lyrics+= "pero en Santa Juana es peor, ";
  lyrics+= "el minero ya no sabe ";
  lyrics+= "lo que vale su sudor, ";
  lyrics+= "y arriba quemando el sol. ";

  lyrics+= "Me volví para Santiago ";
  lyrics+= "sin comprender el color ";
  lyrics+= "con que pintan la noticia ";
  lyrics+= "cuando el pobre dice no, ";
  lyrics+= "abajo, la noche oscura, ";
  lyrics+= "oro, salitre y carbón, ";
  lyrics+= "y arriba quemando el sol.";
}
void draw(){
}
void keyPressed(){
  if(keyCode==32)donmiguel.sing(lyrics);
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



