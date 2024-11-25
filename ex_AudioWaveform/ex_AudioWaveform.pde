import processing.serial.*;
import processing.sound.*;

Serial port;
int val;
float rotationFactor;
int numLines = 100;

// Declare the sound source and Waveform analyzer variables
SoundFile sample;
SoundFile sample2;
Waveform waveform;

WhiteNoise noise;
BandPass filter;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;

public void setup() {
  fullScreen();
  //size(1000, 600);
  
  // Set background color, noFill and stroke style
  background(0);
  stroke(255, 0, 0);
  strokeWeight(2);
  fill(0);

  // Load and play a soundfile and loop it.
  sample = new SoundFile(this, "beat.aiff");
  sample = new SoundFile(this, "heavenly.wav");
  sample2 = new SoundFile(this, "warp_machine.wav");
  //sample.loop();
  //sample2.loop();
  //sample2.amp(0.7);
  
  noise = new WhiteNoise(this);
  //noise.play(0.2);
  
  filter = new BandPass(this);
  filter.process(sample);
  filter.process(sample2);
  filter.process(noise);

  // Create the Waveform analyzer and connect audio in
  waveform = new Waveform(this, samples);
  waveform.input(new AudioIn(this, 0));
  
  // Keeping some cool rotations
  rotationFactor = 0.5058824;
  rotationFactor = 0.98039216;
  rotationFactor = 0.098;
  
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
  
  // Hide cursor
  noCursor();
  
  // Check if data is available
  if (port.available()> 0) {
    // Read a line of text and check if valid
    String lineRead = port.readStringUntil('\n');
    if (lineRead != null) {
      lineRead = trim(lineRead); // remove whitespace
      
      // Check to see what this value should be used for
      if (lineRead.length() > 4 && lineRead.substring(0, 4).equals("RATE")) {
        // Convert value to integer
        val = int(lineRead.substring(4));
      
        // Update speed of sample sound
        float speed = map(val, 0, 255, 0.1, 3);
        sample.rate(speed);
        //println(speed);
      } else if (lineRead.length() > 3 && lineRead.substring(0, 3).equals("ROT")) {
        // Convert value to integer
        val = int(lineRead.substring(3));
        
        //numLines = int(map(val, 0, 255, 1, 100));
        rotationFactor = map(val, 0, 255, 0, 1); // potentiometer
        //rotationFactor = map(val, 0, 20, 0, 1); // light sensor (hacky for now)
        println(rotationFactor);
      }
    }
    
    /*float speed = map(val, 0, 255, 0.1, 3);
    sample.rate(speed);
    println(speed);
    
    numLines = int(map(val, 0, 255, 1, 100));*/
  }
  //println(val);
  
  
  // Map the left/right mouse position to a cutoff frequency between 20 and 10000 Hz
  float frequency = map(mouseX, 0, width, 20, 5000);
  // And the vertical mouse position to the width of the band to be passed through
  float bandwidth = map(mouseY, 0, height, 2000, 100);

  filter.freq(frequency);
  filter.bw(bandwidth);
  
  // Change stroke color depending on mouse position
  /*if (mouseX > width / 2) {
    stroke(255, 255, 255);
  } else {
    stroke(255, 0, 0);
  }*/

  // Perform the analysis
  waveform.analyze();
  
  color c = color(random(0, 256), random(0, 256), random(0, 256));
  /*
  stroke(c);
  fill(c);*/
  
  /*beginShape();
  for(int i = 0; i < samples; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    //stroke(255);
    /*vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -0.7, 0.7, 0, height)
    );
    vertex(
      map(waveform.data[i], -0.5, 0.5, 0, width),
      map(i, 0, samples, 0, height)
    );
  }
  endShape();*/
  
  translate(width/2, 0);
  
  for (int i = 0; i < numLines; i++) {
    //stroke(c);
    strokeWeight(2);
    beginShape();
    for(int j = 0; j < samples; j++){
      /*vertex(
        map(j, 0, samples, 0, width),
        map(waveform.data[j], -0.5, 0.5, 0, height) - height / 2 + map(i, 0, numLines, 0, height)
      );*/
      vertex(
        map(waveform.data[j], -0.5, 0.5, 0, width) - width + map(i, 0, numLines, 0, width) + j,// + random(0, 1),
        map(j, 0, samples, 0, height) //+ random(0, 50)
      );
    }
    
    // Rotate around origin
    //rotate(PI * map(mouseY, 0, height, 0, 1));// / mouseY);
    rotate(PI * rotationFactor);
    endShape();
    
    // Add perpendicular set of lines
    /*beginShape();
    for(int j = 0; j < samples; j++){
      vertex(
        map(j, 0, samples, 0, width),
        map(waveform.data[j], -0.5, 0.5, 0, height) - height / 2 + map(i, 0, numLines, 0, height)
      );
    }
    endShape();*/
  }
}
