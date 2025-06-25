import processing.serial.*;
import processing.sound.*;

Serial port;
int val; // serial reading

// Sound source and Waveform analyzer variables
SoundFile sample;
SoundFile sample2;
SoundFile sample3;
SoundFile heartbeat;
Waveform waveform;

WhiteNoise noise;
BandPass filter;

boolean soundOn = false;

// Number of samples read from the Waveform 
int samples = 320; // 80
int step = 5; // for downsampling

// Animation variables
int numLines = 80; //80;
int linePattern = 0; // 6 line patterns as created for Rotary Switch 2
float rotationFactor = 0;
float rotationFactor2 = 0;
float rotationStart = 0;
int translateY = height * 4; //0;

boolean layerOn = true; // determine if background is refilled between draws
color fillColor = color(0, 0, 0); 
color strokeColor = color(255, 0, 0);

public void setup() {
  fullScreen();
  //size(1000, 600, P2D);
  
  // Set background color, fill and stroke style
  background(0);
  strokeWeight(2);
  stroke(strokeColor);
  fill(fillColor);

  // Load and play a soundfile and loop it.
  /*sample = new SoundFile(this, "beat.aiff");
  sample = new SoundFile(this, "heavenly.wav");
  sample2 = new SoundFile(this, "warp_machine.wav");
  sample2 = new SoundFile(this, "spin.wav");*/
  
  sample = new SoundFile(this, "SNF.wav");
  //sample2 = new SoundFile(this, "rope.mp3");
  sample2 = new SoundFile(this, "vinyl.wav");
  sample3 = new SoundFile(this, "slowmo.wav");
  heartbeat = new SoundFile(this, "heartbeat.mp3");
  
  sample.loop();
  sample.amp(0);
  sample2.loop();
  sample2.amp(0); // 0.3
  heartbeat.loop();
  heartbeat.amp(0); // 1.5
  sample3.loop();
  sample3.amp(1);
  
  noise = new WhiteNoise(this);
  noise.play(0.01);
  
  filter = new BandPass(this);
  filter.process(sample);
  filter.process(sample2);
  filter.process(sample3);
  filter.process(heartbeat);
  filter.process(noise);

  // Create the Waveform analyzer and connect audio in
  waveform = new Waveform(this, samples);
  waveform.input(sample);
  waveform.input(sample2);
  waveform.input(sample3);
  waveform.input(heartbeat);
  waveform.input(noise);
  //waveform.input(new AudioIn(this, 0));
  
  // Keeping some cool rotations
  rotationFactor = 0.5058824;
  rotationFactor = 0.98039216;
  rotationFactor = 0.098;
  
  // List all the available serial ports, preceded by their index number:
  printArray(Serial.list());
  // Open port and use the same speed (9600 bps)
  port = new Serial(this, Serial.list()[5], 9600);
}

public void draw() {
  long start = millis();
  
  // Hide cursor
  noCursor();
  
  // Check if data is available
  if (port.available() > 0) {
    println("port available");
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
          case "LVAL0" : {
            if (val < 0) {
              // Sound off
              soundOn = false;
              
              // Mute
              sample.amp(0);
              sample2.amp(0);
            } else {
              // Sound on
              soundOn = true;
            }
            
            // Update slomo sound volume
            sample3.amp(map(val, 0, 255, 1, 0));
            /*int peak = 100;
            if (val < peak) {
              // Direct increase
              sample3.amp(map(val, 0, peak, 0, 1));
            } else {
              // Inverted increase
              sample3.amp(map(val, peak, 255, 1, 0));
            }*/
              
            break;
          }
          case "AVAL0" : {
            // Adjust fill mode
            if (val > 125) {
              // Turn off layering
              layerOn = false;
              
              // Adjust heartbeat sound volume
              //heartbeat.amp(map(val, 0, 80, 0, 3));
            } else {
              // Turn on layering
              layerOn = true;
              
              // Adjust heartbeatsound volume
              //heartbeat.amp(map(val, 80, 255, 3, 0));
            }
            
            break;
          }
          case "AVAL1" : {
            // Update number of samples used from waveform
            // Set denominator (4) based on speaker volume and sensitivity (test it)
            //step = (255 - val) / 4 + 1;
            
            // Vary step in repeating cycles
            int numCycles = 5;
            int cycleSize = 255 / numCycles; // 51
            int cycleVal = val % cycleSize;
            //step = cycleSize - cycleVal;
            
            // Convert to oscillating step (increase then decrease)
            int peak = cycleSize / 2; // 25
            if (cycleVal < peak) {
              cycleVal *= 2;
            } else {
              cycleVal = (int) map(cycleVal, 25, 50, 50, 0);
            }
            step = cycleSize - cycleVal;
            
            // RATE
            // Update speed of sound
            float speed = map(val, 0, 255, 0.1, 3);
            sample.rate(speed);
            sample2.rate(speed);
            sample3.rate(speed);
            
            break;
          }
          case "AVAL2" : {
            // Update line pattern from rotary position
            linePattern = val / 2;
            
            // Update fill mode
            if (val % 2 == 0) {
              // Rotation start point
              rotationStart = 0;
              
              // Black on red
              /*fillColor = color(255, 0, 0);
              strokeColor = color(0, 0, 0);*/
            } else {
              // Rotation start point
              rotationStart = 0.5;
              
              // Red on black
              /*fillColor = color(0, 0, 0); 
              strokeColor = color(255, 0, 0);*/
            }
            
            // Adjust vertical position
            if (val >= 2) {
              translateY = height / 2;
            } else {
              translateY = 0;
            }
            
            break;
          }
          case "AVAL3" : {
            // ROT
            rotationFactor = map(val, 0, 255, 0.05, 1); // potentiometer
            
            // Update machine sounds volume
            if (soundOn) {
              int peak = 125;
              if (val < peak) {
                // Direct increase
                sample2.amp(map(val, 0, peak, 0, 1));
                sample.amp(map(val, 0, peak, 1, 0.5));
              } else {
                // Inverted increase
                sample.amp(map(val, peak, 255, 0.5, 1));
                sample2.amp(map(val, peak, 255, 1, 0));
              }
            }
            
            // RATE
            // Update speed of sound
            /*float speed = map(val, 0, 255, 0.1, 3);
            sample.rate(speed);
            sample2.rate(speed);
            sample3.rate(speed);*/
            //heartbeat.rate(speed);
            break;
          }
          case "SVAL0" : {
            // Color inversion
            if (val == 0) {
              // Black on red
              fillColor = color(255, 0, 0);
              strokeColor = color(0, 0, 0);
            } else {
              // Red on black
              fillColor = color(0, 0, 0); 
              strokeColor = color(255, 0, 0);
            }
            break;
          }
          case "DVAL0" : {
            // Adjust heartbeat speed based on detected distance
            
            // Increase heartrate when closer
            // RATE
            // Update speed of heartbeat
            float speed = map(val, 0, 255, 2, 0.01);
            heartbeat.rate(speed);
            
            // Adjust volume of heartbeat
            heartbeat.amp(map(val, 0, 255, 1, 15));
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

  // Perform input audio waveform analysis
  waveform.analyze();
  
  /* Animation */
  
  // Prepare canvas
  stroke(strokeColor);
  fill(fillColor);
  if (!layerOn) {
    // Reset canvas
    background(0);
    strokeWeight(2);
  }
  
  // Translate entire drawing to screen center
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
      // Plot vertex from waveform data
      switch(linePattern) {
        case 0: {
          // Original  
          vertex(
            map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j,// + random(0, 1),
            map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
            //i
          );
          break;
        }
        case 1: {
          // Circular function
          float angle = map(waveform.data[j], -0.5, 0.5, 0, TWO_PI) + map(j, 0, samples, 0, 1);
          float radius = height * 0.4 + 0.4 * width * (rotationFactor - rotationStart);
          //float radius = height * 0.4 + 0.5 * mouseX; // + (width - mouseX);
          //float radius = height * 0.8 + mouseX;
          float centerX = width / 2;
          float centerY = height / 2;
          vertex(
              (radius + j) * cos(angle) + centerX,// + random(0, 1),
              (radius + j) * sin(angle) + centerY // j * sampleGap //+ random(0, 50)
          );
          rotate(0.01 * waveform.data[j]);
          break;
        }
        case 2: {
          // Circular function
          float angle = map(waveform.data[j], -0.5, 0.5, 0, TWO_PI) + map(j, 0, samples, 0, 1);
          float radius = 0.4 * width * (rotationFactor - rotationStart);
          float centerX = width / 2;
          float centerY = height / 2;
          vertex(
              (radius + j) * cos(angle) + centerX,// + random(0, 1),
              (radius + j) * sin(angle) + centerY // j * sampleGap //+ random(0, 50)
          );
          rotate(0.01 * waveform.data[j]);
          break;
        }
        case 3: {
          // Hourglass function
          float angle = map(j, 0, samples, 0, TWO_PI);
          //float angle = map(waveform.data[j], -0.5, 0.5, 0, TWO_PI) + map(j, 0, samples, 0, 1);
          float radius = height / 10 - (i * i / 15) + waveform.data[j] * 1000 + 0.2 * width * (rotationFactor - rotationStart);
          vertex(
              (radius + j) * cos((3 + rotationFactor * 6) * (angle)),
              (radius + j) * sin(2 * (angle + 0.4 * width * (rotationFactor - rotationStart)))
          );
          break;
        }
        case 4: {
          // Original (except shifted down)
          vertex(
            map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j,// + random(0, 1),
            map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
            //i
          );
          break;
          
          // Concentric circles
          /*float angle = map(j, 0, samples / step, 0, TWO_PI);
          float radius = height / 2 - (i * i / 15) + waveform.data[j] * 1000;//map(waveform.data[j], -0.5, 0.5, 0, 10);
          float centerX = width / 2;
          float centerY = height / 2;
          vertex(
              (radius + j) * cos(angle) + centerX,// + random(0, 1),
              (radius + j) * sin(angle) + centerY // j * sampleGap //+ random(0, 50)
          );
          break;*/
        }
        case 5: {
          // Spiky line
          if (j % 2 == 1) {
            // Normal plot
            vertex(
              map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j,// + random(0, 1),
              map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
              //i
            );
          } else {
            // Random/set spike
            vertex(
              width/2 - width + lineOffset + j, // + random(0, 1),
              map(j, 0, samples / step, 0, height)
             );
          }
          break;
        }
        default: {
          // Original  
          vertex(
            map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j,// + random(0, 1),
            map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
            //i
          );
          break;
        }
        
        // Another line
        /*if (j % 2 == 1) {
          vertex(
            map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j,// + random(0, 1),
            map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
            //i
          );
        } else {
          vertex(0, map(j, 0, samples / step, 0, height));
          vertex(
            width/2 - width + lineOffset + j,
            map(j, 0, samples / step, 0, height)
           );
        }*/
        
        // TODO: sine wave
        /*vertex(
            (map(waveform.data[j], -0.5, 0.5, 0, width) - width + lineOffset + j),// + random(0, 1),
            map(j, 0, samples / step, 0, height) // j * sampleGap //+ random(0, 50)
            //i
         );*/
      }
    }
    
    // Rotate around origin
    //rotateX(PI * rotationFactor);
    //rotateY(PI * rotationFactor);
    //rotate(PI * map(mouseX, 0, width, 0, 1));
    if (linePattern != 3) rotate(PI * (rotationStart + rotationFactor));
    endShape();
  }
  
  println("drawing lines took: " + (millis() - drawingStart) + "ms");
}
