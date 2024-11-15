import processing.sound.*;
SoundFile file;

void setup() {
  size(640, 360);
  background(255);
    
  // Load a soundfile from the data folder of the sketch and play it back in a loop
  file = new SoundFile(this, "BM208.mp3");
  file.loop();
}      

void draw() {
  background(255);
  // draw a rectangle that shows the elapsed time of the loop:
  noStroke(); // no outline
  fill(127); // fill color in grayscale value
  rect(0, 170, (width * file.percent()) / 100, 20);
  println(file.percent());
}
