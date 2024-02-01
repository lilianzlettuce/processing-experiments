PFont helvetica;
void setup(){

  size (400,400);
  textSize(100);
  helvetica = loadFont("Helvetica.vlw");
}


void draw(){
  frameRate(24);
  background(0);
  textFont(helvetica);
  text(frameCount,150,200);
}