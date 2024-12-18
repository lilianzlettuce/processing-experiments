import processing.pdf.*;

void setup(){
  size(600,600, PDF, "project-1.pdf");
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
    int crys_y3 = crys_y1 + 160;
    
    strokeWeight(2);
    stroke(92, 75, 5);
    smooth();
    
    int num_crysts = 9;
    rotate(radians(60));
    scale(1);
    
    for(int i = 0; i < num_crysts; i++) {
      rotate(radians(360 / num_crysts));
      
      // wings
      pushMatrix();
        int num_wings = 5;
        float wing_size = 0.1;
        float wing_rotation = radians((float) 90 / num_wings);
        translate(0, -100);
        
        for (int j = 0; j < num_wings; j++) {
          int wing_y1 = -65;
          int wing_x2 = 35;
          int wing_y2 = wing_y1 - 15;
          int wing_y3 = wing_y1 + 65;
          int wing_ymid = wing_y1 + 20;
        
          // right side
          pushMatrix();
            rotate(wing_rotation * (num_wings - 1 - j));
            scale(1 + (wing_size * (num_wings - 1 - j)));
            
            fill(light_yellow);
            beginShape();
              vertex(0, wing_y1);
              vertex(wing_x2, wing_y2);
              vertex(0, wing_y3);
            endShape();
          
            fill(yellow_shadow);
            beginShape();
              vertex(0, wing_y1);
              vertex(wing_x2 - 2, wing_y2 + 1);
              vertex(0, wing_ymid);
            endShape();
          popMatrix();
          
          // left side
          pushMatrix();
            rotate(-wing_rotation * (num_wings - 1 - j));
            scale(1 + (wing_size * (num_wings - 1 - j)));
            
            fill(light_yellow);
            beginShape();
              vertex(0, wing_y1);
              vertex(-wing_x2, wing_y2);
              vertex(0, wing_y3);
            endShape();
            
            fill(yellow_shadow);
            beginShape();
              vertex(0, wing_y1);
              vertex(-(wing_x2 - 2), wing_y2 + 1);
              vertex(0, wing_ymid);
            endShape();
          popMatrix();
        }
      
      popMatrix();
      
      // crystal
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
      rotate(radians(360 / num_prisms));
      
      // wings
      pushMatrix();
        int num_wings = 5;
        float wing_size = 0.1;
        float wing_rotation = radians((float) 90 / num_wings);
        translate(0, -100);
        
        for (int j = 0; j < num_wings; j++) {
          int wing_y1 = -65;
          int wing_x2 = 35;
          int wing_y2 = wing_y1 - 15;
          int wing_y3 = wing_y1 + 65;
          int wing_ymid = wing_y1 + 20;
        
          // right side
          pushMatrix();
            rotate(wing_rotation * (num_wings - 1 - j));
            scale(1 + (wing_size * (num_wings - 1 - j)));
            
            fill(light_yellow);
            beginShape();
              vertex(0, wing_y1);
              vertex(wing_x2, wing_y2);
              vertex(0, wing_y3);
            endShape();
          
            fill(yellow_shadow);
            beginShape();
              vertex(0, wing_y1);
              vertex(wing_x2 - 2, wing_y2 + 1);
              vertex(0, wing_ymid);
            endShape();
          popMatrix();
          
          // left side
          pushMatrix();
            rotate(-wing_rotation * (num_wings - 1 - j));
            scale(1 + (wing_size * (num_wings - 1 - j)));
            
            fill(light_yellow);
            beginShape();
              vertex(0, wing_y1);
              vertex(-wing_x2, wing_y2);
              vertex(0, wing_y3);
            endShape();
            
            fill(yellow_shadow);
            beginShape();
              vertex(0, wing_y1);
              vertex(-(wing_x2 - 2), wing_y2 + 1);
              vertex(0, wing_ymid);
            endShape();
          popMatrix();
        }
      
      popMatrix();
      
      // prism
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
      
      // ball
      int ball_d = 20;
      
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
  
  exit();
}
