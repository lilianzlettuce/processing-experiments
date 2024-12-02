import processing.serial.*;
import processing.sound.*;

Serial port;
int val;
float rotationFactor;
float rotationFactor2 = 0;
int translateY = 0;
int numLines = 80; //80

// Declare the sound source and Waveform analyzer variables
SoundFile sample;
SoundFile sample2;
Waveform waveform;

WhiteNoise noise;
BandPass filter;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 80; // 80
int step = 1; // for downsampling

public void setup() {
  fullScreen();
  //size(1000, 600, P2D);
  
  // Set background color, noFill and stroke style
  background(0);
  stroke(255, 0, 0);
  strokeWeight(2);
  fill(0);

  // Load and play a soundfile and loop it.
  sample = new SoundFile(this, "beat.aiff");
  sample = new SoundFile(this, "heavenly.wav");
  sample2 = new SoundFile(this, "warp_machine.wav");
  sample2 = new SoundFile(this, "spin.wav");
  sample2 = new SoundFile(this, "heartbeat.mp3");
  //sample2 = new SoundFile(this, "rope.mp3");
  //sample2 = new SoundFile(this, "slowmo.wav");
  //sample2 = new SoundFile(this, "vinyl.wav");
  //sample.loop();
  sample2.loop();
  sample2.amp(10);
  //sample2.amp(0.7);
  
  noise = new WhiteNoise(this);
  noise.play(0.2);
  
  filter = new BandPass(this);
  filter.process(sample);
  filter.process(sample2);
  filter.process(noise);

  // Create the Waveform analyzer and connect audio in
  waveform = new Waveform(this, samples);
  waveform.input(sample2);
  //waveform.input(new AudioIn(this, 0));
  
  // Keeping some cool rotations
  rotationFactor = 0.5058824;
  rotationFactor = 0.98039216;
  rotationFactor = 0.098;
  
  // List all the available serial ports, preceded by their index number:
  printArray(Serial.list());
  // Open port and use the same speed (9600 bps)
  port = new Serial(this, Serial.list()[4], 9600);
}

public void draw() {
  long start = millis();
  
  // Hide cursor
  noCursor();
  
  // Check if data is available
  if (port.available() > 0) {
    // Read a line of text and check if valid
    String lineRead = port.readStringUntil('\n');
    if (lineRead != null) {
      lineRead = trim(lineRead); // remove whitespace
      
      if (lineRead.length() > 6) {
      
        // Convert value to integer
        val = int(lineRead.substring(6));
        
        // Check value ID
        String id = lineRead.substring(0, 5);
        switch(id) {
          case "AVAL0": {
            // Adjust fill mode
            if (val < 80) {
              // Reset canvas
              background(0);
              strokeWeight(2);
              noFill();
            } else {
              // Allow layering
              fill(0);
            }
            break;
          }
          case "AVAL1" : {
            // Update number of samples used from waveform
            step = (255 - val) / 8 + 1;
            break;
          }
          case "AVAL2" : {
            // Adjust vertical position
            if (val > 85) {
              translateY = height / 2;
            } else {
              translateY = 0;
            }
            
            //rotationFactor2 = map(val, 0, 255, 0.05, 1); // potentiometer
            break;
          }
          case "AVAL3" : {
            // ROT
            rotationFactor = map(val, 0, 255, 0.05, 1); // potentiometer
            //rotationFactor = map(val, 0, 20, 0, 1); // light sensor (hacky for now)
            //println("ROT" + rotationFactor);
            
            // RATE
            // Update speed of sample sound
            float speed = map(val, 0, 255, 0.1, 3);
            sample.rate(speed);
            sample2.rate(speed);
            //println(speed);
            break;
          }
          case "SVAL0" : {
            // Color inversion
            if (val == 0) {
              fill(255, 0, 0);
              stroke(0);
            } else {
              fill(0);
              stroke(255, 0, 0);
            }
            /*if (val == 0) {
              // Reset canvas
              background(0);
              strokeWeight(2);
              noFill();
            } else {
              fill(0);
            }*/
            break;
          }
          default : {
            break;
          }
        }
      }
    }
  }
  
  println("Serial reading took: " + (millis() - start) + "ms");
  
  // Map the left/right mouse position to a cutoff frequency between 20 and 10000 Hz
  /*float frequency = map(mouseX, 0, width, 20, 5000);
  // And the vertical mouse position to the width of the band to be passed through
  float bandwidth = map(mouseY, 0, height, 2000, 100);

  filter.freq(frequency);
  filter.bw(bandwidth);*/

  // Perform the analysis
  waveform.analyze();
  
  // Translate entire drawing
  translate(width/2, translateY);
  //rotate(PI * rotationFactor2);
  
  long drawingStart = millis();
  
  //float lineGap = width / (float)numLines; // gap between each line
  //float sampleGap = height / (float)samples; // gap between each sample point on a line
  
  // Draw lines
  for (int i = 0; i < numLines; i++) {
    // Calculate line offset
    float lineOffset = map(i, 0, numLines, 0, width);
    //float lineOffset = i * lineGap;
     
    // Draw this line
    beginShape();
    for(int j = 0; j < samples; j += step){
      vertex(
        map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j,// + random(0, 1),
        map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
        //i
      );
    }
    
    // Rotate around origin
    //rotateX(PI * rotationFactor);
    //rotateY(PI * rotationFactor);
    rotate(PI * rotationFactor);
    endShape();
  }
  
  println("drawing lines took: " + (millis() - drawingStart) + "ms");
}
