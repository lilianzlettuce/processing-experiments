
void setup(){
  size(800,600,OPENGL);

}

void draw(){
  lights();
  //noStroke();
  background(#9AFAA9);
  
  pushMatrix();
    translate(width/2,height/2,-100);
    fill(230,200,80);
    rotateX(mouseX*0.1);
    //sphere(100);
    beginShape();
      vertex(115,15,0);
      vertex(206,236,-100);
      vertex(3,178,0);
    endShape(CLOSE);
    
  popMatrix();
  
 pushMatrix();
  translate(100,100,-200);
  rotateY(mouseX*0.1);
  box(200);
 popMatrix();
 
 
 
}
