class walker{
  int x;
  int y;
  int incr;
  
  walker(int tempInc){ //constructor
    x=width/2;  
    y=height/2;
    incr=tempInc;
    }

  void display(){
    strokeWeight(3);
    stroke(0);
    point(x,y);
    
  }
    void step() {
      float stepx = random(-2, 2);
      float stepy = random(-2, 2);
      x += stepx;
      y += stepy;
      
      
  }

}
