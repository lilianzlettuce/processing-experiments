PShape whatever;


void setup(){
size(450,700);
whatever=loadShape("whatever.svg");
shapeMode(CENTER);



}


void draw(){
  translate(mouseX,mouseY);
  rotate(frameCount*0.1);

  shape(whatever,0,0,whatever.width*4, whatever.height*4);


}
