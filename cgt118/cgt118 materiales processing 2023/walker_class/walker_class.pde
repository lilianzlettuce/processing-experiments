walker w;

void setup(){
  size(800,600);
  w=new walker(100);
  background(#5ABFC1);
}

void draw(){
  
  w.step();
  w.display();
}
