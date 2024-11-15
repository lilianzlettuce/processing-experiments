import processing.serial.*;
import processing.sound.*;

int val; 

SoundFile file;
SoundFile file1;
SoundFile file2;
Serial port;                      // Create object from Serial class

void setup() {
  size(640, 360);
  background(255);
    
  // Load a soundfile from the data folder of the sketch and play it back in a loop
  file1 = new SoundFile(this, "BM208.mp3");
  file2 = new SoundFile(this, "heavenly.wav");
  file = new SoundFile(this, "warp_machine.wav");
  file = file2;
  file.loop();
  
  // Open the port that the board is connected to and use the same speed (9600 bps)
  //port = new Serial(this, 9600);  // Comment this line if it's not the correct port
  
  // List all the available serial ports, preceded by their index number:
  printArray(Serial.list());
  // Instead of 0 input the index number of the port you are using:
  port = new Serial(this, Serial.list()[4], 9600);
  
}      

void draw() {
  background(255);
  
  if (0 < port.available()) {  // If data is available to read,
    val = port.read();            // read it and store it in val
    /*String valString = port.readStringUntil('\n');  // Read a line of text
    if (valString != null) {               // Check if a valid line was read
      valString = trim(valString);         // Remove any extraneous whitespace
      val = int(valString);                // Convert string to integer
    }*/
  }
  //println(val);
  
  float speed = map(val, 0, 255, 0.1, 3);
  file.rate(speed);
  println(speed);
  
  // draw a rectangle to visualize rotational angle of
  // the potentiometer:
  float rectWidth = map(val, 0, 255, 0, width);
  noStroke();
  fill(127);
  rect(0, 170, rectWidth, 20); 
  
  // draw a rectangle that shows the elapsed time of the loop:
  rect(0, 70, (width * file.percent()) / 100, 20);
  println(file.percent());
}
