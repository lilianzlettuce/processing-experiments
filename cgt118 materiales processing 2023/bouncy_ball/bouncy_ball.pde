int x;
int y;
int incrementX;
int incrementY;

boolean inScreen;

void setup(){
size(500,800);
x=100;
y=20;
incrementX=20;
incrementY=10;
inScreen=true;
ellipseMode(CENTER);
}

void draw(){
  
  //background(192,183,255);
  fill(192,183,255,8);
  rect(0,0,width,height);
  noStroke();
  fill(31,96,103);
  
  //increment
  x=x+incrementX;
  y=y+incrementY; // 
   ellipse(x,y,60,60);
   fill(255);
   rect(200,200,150,20);
   
  if(x>=width||x<=0 ){
    incrementX=incrementX*-1;
  }
  
  if(y>=height||y<=0){
    incrementY=incrementY*-1;
  }
  
  if((x>150 && x<380) && (y>180 && y<250)){
  incrementY=incrementY*-1;
  incrementX=incrementX*-1;
  }
  
  if ((keyPressed) && (key=='a')){
    //x=0;
    //y=0;
  incrementY++;
  println("iY" + incrementY);
}

if ((keyPressed) && (key=='s')){
    //x=0;
    //y=0;
  incrementX++;
  println("iX" + incrementX);
}
  
  
  fill(192,183,255,2);
  rect(0,0,width,height);
  
}