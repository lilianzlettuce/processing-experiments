import processing.pdf.*;

void setup(){
  // size(600,600, PDF, "test.pdf");
  size(600,600);
}

void draw(){
  background(255, 255, 255);
  
  // background
  pushMatrix();
    int bg_x = 300;
    int bg_y = 300;
    int bg_d = 50;
    
    strokeWeight(5);
    noStroke();
    //stroke(255, 110, 245);
    //stroke(0);
  
    for (int i = 20; i >= 0; i--){
      fill(i * bg_d * 2 / 5, 100, 230, (20-i) * 5);
      fill(i * bg_d * 2 / 5, 200, 230, (20-i) * 5);
      fill(i * bg_d * 2 / 5, 200, 120, (20-i) * 5);
      fill(i * bg_d * 2 / 5, + (10 * (20-i)), 230, (20-i) * 5);
      fill(i * bg_d * 2 / 5, + (10 * (20-i)), 120* (20-i) * 5);
      ellipse(bg_x, bg_y, bg_d * i, bg_d * i);
    }
  popMatrix();
  
  translate(300, 300);
  
  // small crystal thing
  pushMatrix();
    int crys_y1 = -230;
    int crys_x2 = 20;
    int crys_y2 = -200;
    int crys_y3 = -100;
    
    strokeWeight(2);
    stroke(92, 75, 5);
    smooth();
    
    int num_crysts = 3;
    rotate(radians(60));
    for(int i = 0; i < num_crysts; i++) {
      rotate(radians(360 / num_crysts));
      fill(255, 220, 77);
      quad(0, crys_y1, crys_x2, crys_y2, 0, crys_y3, -crys_x2, crys_y2);
      fill(255, 233, 143);
      quad(0, crys_y1, crys_x2, crys_y2, 0, crys_y2 + 15, -crys_x2, crys_y2);
      line(0, crys_y1, 0, crys_y3);
      //triangle(0, 0, crys_x2, crys_y2, 0, crys_y3);
      //noStroke();
      //triangle(0, 0, -crys_x2, crys_y2, 0, crys_y3);
    }
  popMatrix();
  
  // triangular prism with torus
  pushMatrix();
    int prism_y1 = -230;
    int prism_x2 = 20;
    int prism_y2 = -120;
    int prism_y3 = -100;
    
    int num_prisms = 3;
    for(int i = 0; i < num_prisms; i++) {
      // prism
      rotate(radians(360 / num_prisms));
      fill(255, 233, 143);
      quad(0, prism_y1, prism_x2, prism_y2, 0, prism_y3, -prism_x2, prism_y2);
      line(0, prism_y1, 0, prism_y3);
      //triangle(0, 0, crys_x2, crys_y2, 0, crys_y3);
      //triangle(0, 0, -crys_x2, crys_y2, 0, crys_y3);
      
      // torus
      
      // ball
      int ball_d = 20;
      ellipse(0, prism_y1 - 25, ball_d, ball_d);
    }
  popMatrix();


  // eye
  pushMatrix();
    int eye_x = 40;
    int eye_cpx = 10;
    int eye_cpy = eye_x / 4 * 3;
    
    int iris_w = eye_x;
    int pupil_w = iris_w / 2;
    
    beginShape();
      vertex(-eye_x, 0);
      bezierVertex(-eye_cpx, -eye_cpy, eye_cpx, -eye_cpy, eye_x, 0);
      bezierVertex(eye_cpx, eye_cpy, -eye_cpx, eye_cpy, -eye_x, 0);
    endShape();
    
    fill(250, 148, 255);
    ellipse(0, 0, iris_w, iris_w);
    
    fill(0);
    ellipse(0, 0, pupil_w, pupil_w);
  popMatrix();
  
  //exit();
}
