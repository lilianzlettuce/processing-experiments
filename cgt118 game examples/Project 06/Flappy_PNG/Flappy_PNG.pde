//From KTByte.com: crappier bird, based off http://tinyurl.com/reddit-crappybird
//Mod for sprite workshop by Esteban Garcia
//License: Creative Commons Attribution-Share Alike 3.0 and GNU GPL license

PImage b;
PImage c;
PImage w;
PImage m;
boolean value;

void setup() { 
  size(600, 800); 
  frameRate(40);
  b=loadImage("rise.png");
  c=loadImage("bg.png");//this is the background 1800 x 800 Px
  w=loadImage("pillar.png");//boundary
  m=loadImage("title.png");
} 



int r,s=0,d=1,x,y=400,vy,wx[]={0,0},wy[]={0,0},e=1800,l=600,hs=0,v=800;


void draw() { //RULES: Max 100 characters per line. 1 semicolon per line, not including for loops
  for(int t=0,q=1;t<=e;t+=e,q=1) for(imageMode(1);q>0;q--,imageMode(3)) image(c,x+t,0);
  for(int i=0,z=y+=vy+=1,q=(x=x-6==-1800?0:x-6);i<2;i++,fill(0),textSize(40),image(b,l/2,y)){
    for(int j=-1;j<2;j+=2,text(""+s,l/2-15,700)) image(w, wx[i], wy[i]+j*(w.height/2+100));
    if((wx[i]=wx[i]<0?(wy[i]=(int)random(200,v-200))/wy[i]*l:wx[i]-6)==l/2&&d==0) hs=max(++s,hs);
    d = (abs(width/2-wx[i])<25 && abs(y-wy[i])>100) || y > height || y < 0 ? 1 : d;
  } //MORE RULES: close curly brackets on their own line. Must run in Processing Java + JS
  if (d==(r=1)) for(imageMode(1);r>0;r--,rectMode(3),text("HighScore: "+hs,9,780)) image(m, 0, 0);
  
  
  if (mousePressed == true) {
    b=loadImage("rise.png");}
    else{ 
      b=loadImage("fall.png");
  
  }
  
  
} 

void mousePressed() { 
  
  if (d==(vy=-17)/-17){ 
    y=(wx[1]=900) + 100 - ((wy[0]=(wy[1]=wx[0]=600)-200)+200 + (x = s = d = 0));
    //value=true;
  }
}

