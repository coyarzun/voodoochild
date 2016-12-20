import processing.video.*;

Movie mov;
boolean speedSet = false;
boolean once = true;

void setup() {
  size(640, 360);
  background(0);
  mov = new Movie(this, "X-1999 opening.mp4");
  mov.play();
}

void movieEvent(Movie m) {
  m.read();  
  /*if (speedSet == true) {
    speedSet = false;
  }*/
}

void draw() {
  /*
  if (speedSet == false && once == true) {
    // Setting the speed should be done only once,
    // this is the reason for the if statement.
    speedSet = true;
    once = false;
    mov.jump(mov.duration());
    // -1 means backward playback at normal speed.
    mov.speed(-1.0);
    // Setting to play again, since the movie stop
    // playback once it reached the end.
    mov.play();
  }*/
  mov.jump(mov.duration());
  image(mov, 0, 0, width, height);
}   

