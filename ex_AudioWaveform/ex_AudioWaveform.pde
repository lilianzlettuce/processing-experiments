import processing.serial.*;
import processing.sound.*;

Serial port;
int val;

// Declare the sound source and Waveform analyzer variables
SoundFile sample;
SoundFile sample2;
Waveform waveform;

WhiteNoise noise;
BandPass filter;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;

public void setup() {
  size(1000, 600);
  
  // Set background color, noFill and stroke style
  background(0);
  stroke(255, 0, 0);
  strokeWeight(2);
  fill(0);
  
  /*background(255, 0, 0);
  stroke(0);
  noFill();*/

  // Load and play a soundfile and loop it.
  sample = new SoundFile(this, "beat.aiff");
  sample = new SoundFile(this, "heavenly.wav");
  sample2 = new SoundFile(this, "warp_machine.wav");
  sample.loop();
  sample2.loop();
  
  noise = new WhiteNoise(this);
  noise.play(0.2);
  
  filter = new BandPass(this);
  filter.process(sample);
  filter.process(sample2);
  filter.process(noise);

  // Create the Waveform analyzer and connect the playing soundfile to it.
  waveform = new Waveform(this, samples);
  //waveform.input(sample);
  waveform.input(new AudioIn(this, 0));
  
  // Open the port that the board is connected to and use the same speed (9600 bps)
  //port = new Serial(this, 9600);  // Comment this line if it's not the correct port
  
  // List all the available serial ports, preceded by their index number:
  printArray(Serial.list());
  // Instead of 0 input the index number of the port you are using:
  port = new Serial(this, Serial.list()[4], 9600);
}

public void draw() {
  // Reset canvas
  /*background(0);
  stroke(255);
  strokeWeight(2);
  noFill();*/
  
  
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
  sample.rate(speed);
  println(speed);
  
  
  
  // Map the left/right mouse position to a cutoff frequency between 20 and 10000 Hz
  float frequency = map(mouseX, 0, width, 20, 5000);
  // And the vertical mouse position to the width of the band to be passed through
  float bandwidth = map(mouseY, 0, height, 2000, 100);

  filter.freq(frequency);
  filter.bw(bandwidth);
  
  /*if (mouseX > width / 2) {
    stroke(0);
  } else {
    stroke(255, 0, 0);
  }*/

  // Perform the analysis
  waveform.analyze();
  
  /*color c = color(random(0, 256), random(0, 256), random(0, 256));
  stroke(c);
  fill(c);*/
  
  beginShape();
  for(int i = 0; i < samples; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    //stroke(255);
    /*vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -0.7, 0.7, 0, height)
    );*/
    vertex(
      map(waveform.data[i], -0.5, 0.5, 0, width),
      map(i, 0, samples, 0, height)
    );
  }
  endShape();
}
