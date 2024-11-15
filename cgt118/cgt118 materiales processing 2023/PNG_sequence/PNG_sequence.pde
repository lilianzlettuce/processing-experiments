int numFrames = 8;
PImage []images = new PImage [numFrames];



void setup(){
  size(640,480);
  frameRate(10);
  
  for (int i=0; i < images.length; i++){
    String imageName = "swirl_" + nf(i,2)+".png"; //image loaders
    images[i]= loadImage(imageName);
    
  }
   
  
 
}

void draw(){
  
  

background(255, 204, 0);

  
  int frame =frameCount % numFrames; // the modulus operator to create image sequences!
  image(images[frame], mouseX, mouseY);
  println(frameCount);
  



  
 
}
