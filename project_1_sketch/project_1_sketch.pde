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
      //fill(i * bg_d * 2 / 5, 200, 230, (20-i) * 5);
      //fill(i * bg_d * 2 / 5, 200, 120, (20-i) * 5);
      //fill(i * bg_d * 2 / 5, + (10 * (20-i)), 230, (20-i) * 5);
      //fill(i * bg_d * 2 / 5, + (10 * (20-i)), 120* (20-i) * 5);
      ellipse(bg_x, bg_y, bg_d * i, bg_d * i);
    }
  popMatrix();
  
  // foreground stuff
  translate(300, 300);
  scale(1.2);
  color light_yellow = color(255, 233, 143);
  color yellow_shadow = color(255, 220, 77);
  color pink = color(250, 148, 255);
  
  // small crystal thing
  pushMatrix();
    int crys_y1 = -230;
    int crys_x2 = 20;
    int crys_y2 = crys_y1 + 30;
    int crys_y_mid = crys_y2 + 15;
    int crys_y3 = crys_y1 + 130;
    
    strokeWeight(2);
    stroke(92, 75, 5);
    smooth();
    
    int num_crysts = 3;
    rotate(radians(60));
    scale(0.8);
    
    for(int i = 0; i < num_crysts; i++) {
      rotate(radians(360 / num_crysts));
      fill(yellow_shadow);
      quad(0, crys_y1, crys_x2, crys_y2, 0, crys_y3, -crys_x2, crys_y2);
      fill(light_yellow);
      quad(0, crys_y1, crys_x2, crys_y2, 0, crys_y_mid, -crys_x2, crys_y2);
      line(0, crys_y1, 0, crys_y3);
      //triangle(0, 0, crys_x2, crys_y2, 0, crys_y3);
      //noStroke();
      //triangle(0, 0, -crys_x2, crys_y2, 0, crys_y3);
    }
  popMatrix();
  
  // triangular prism with torus
  pushMatrix();
    int prism_y1 = -230;
    prism_y1 = -200;
    int prism_x2 = 20;
    int prism_y2 = prism_y1 + 110;
    int prism_y3 = prism_y2 + 20;
    
    int num_prisms = 3;
    for(int i = 0; i < num_prisms; i++) {
      // prism
      rotate(radians(360 / num_prisms));
      fill(light_yellow);
      quad(0, prism_y1, prism_x2, prism_y2, 0, prism_y3, -prism_x2, prism_y2);
      line(0, prism_y1, 0, prism_y3);
      //triangle(0, 0, crys_x2, crys_y2, 0, crys_y3);
      //triangle(0, 0, -crys_x2, crys_y2, 0, crys_y3);
      
      // torus
      int t_big_x1 = 5;
      int t_big_y1 = prism_y1 + 25;
      
      int t_big_cpx = t_big_x1 + 25;
      int t_big_cpy1 = t_big_y1 + 2;
      int t_big_cpy2 = t_big_y1 + 20;
      
      int t_small_x1 = t_big_x1 + 1;
      int t_small_y1 = t_big_y1 + 5;
      
      int t_small_cpx = t_small_x1 + 12;
      int t_small_cpy1 = t_small_y1 + 3;
      int t_small_cpy2 = t_small_y1 + 8;
      
      beginShape();
        vertex(t_big_x1, t_big_y1);
        bezierVertex(t_big_cpx, t_big_cpy1, t_big_cpx, t_big_cpy2, 0, t_big_cpy2);
        bezierVertex(-t_big_cpx, t_big_cpy2, -t_big_cpx, t_big_cpy1, -t_big_x1, t_big_y1);
        
        vertex(-t_small_x1, t_small_y1);
        bezierVertex(-t_small_cpx, t_small_cpy1, -t_small_cpx, t_small_cpy2, 0, t_small_cpy2);
        bezierVertex(t_small_cpx, t_small_cpy2, t_small_cpx, t_small_cpy1, t_small_x1, t_small_y1);
        
        vertex(t_big_x1, t_big_y1);
      endShape();
      
      /*int t_x1 = 10;
      int t_y1 = prism_y1 + 25;
      int t_big_cpx = t_x1 + 20;
      int t_big_cpy1 = t_y1 + 5;
      int t_big_cpy2 = t_y1 + 20;
      
      noFill();
      beginShape();
        vertex(t_x1, t_y1);
        bezierVertex(t_big_cpx, t_big_cpy1, t_big_cpx, t_big_cpy2, 0, t_big_cpy2);
        bezierVertex(-t_big_cpx, t_big_cpy2, -t_big_cpx, t_big_cpy1, -t_x1, t_y1);
      endShape();*/
      
      // ball
      int ball_d = 15;
      
      fill(light_yellow);
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
    
    fill(light_yellow);
    beginShape();
      vertex(-eye_x, 0);
      bezierVertex(-eye_cpx, -eye_cpy, eye_cpx, -eye_cpy, eye_x, 0);
      bezierVertex(eye_cpx, eye_cpy, -eye_cpx, eye_cpy, -eye_x, 0);
    endShape();
    
    fill(pink);
    ellipse(0, 0, iris_w, iris_w);
    
    fill(0);
    stroke(light_yellow);
    strokeWeight(4);
    ellipse(0, 0, pupil_w, pupil_w);
  popMatrix();
  
  //exit();
}
