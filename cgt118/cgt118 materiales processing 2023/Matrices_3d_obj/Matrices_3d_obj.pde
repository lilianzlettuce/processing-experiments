float rotX, rotY;
PShape blenderthing;
//drag .obj file into processing


void setup(){
  
  size(720,480,OPENGL);
  blenderthing=loadShape("cityscape.obj");
  
}

void draw(){
  
  background(158,144,206);
  lights();
       pushMatrix();
       translate(width/2,height/2,mouseX*-1);
       noStroke();
       fill(68,44,147);
       sphere(200);//sphere must be translated before, not in here
     popMatrix();

  
  
  
    pushMatrix();
     
      translate(width/2,height/2,0);
       rotateY(rotY);
      rotateX(rotX);
      shape(blenderthing,200,200,500,500);
     popMatrix();
     

}

void mouseDragged(){
  rotX += (mouseX-pmouseX) * 0.01;
  rotY -= (mouseY-pmouseY) * 0.01;

}