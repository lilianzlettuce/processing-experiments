PFont f;

void setup(){
  size(900,700);  
  f = loadFont("ArialMT-48.vlw");
  textFont(f,48);
}

void draw() {
  background(#13334B);
  fill(#22DDF0);
  text("timer",100,100); 
  text(frameCount,100,150);
  text(hour() + ":" + minute() + ":" + second(),100,200);
}