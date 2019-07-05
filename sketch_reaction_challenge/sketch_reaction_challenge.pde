
int score=0;
int best=0;
int posX, posY;
int radius=50;
int timer=0;
boolean circle=false;
boolean start=false;

void draw(){
  background(255);
  textSize(64);
  textAlign(CENTER);
  if(!start)text("Click to start",width/2,height/2);
  if(start&&!circle){radius=height/6;posX=(int)random(radius,width-radius);posY=(int)random(radius,height-radius);circle=true;}
  if(start&&circle)ellipse(posX,posY,radius*2,radius*2);
  if(millis()-timer>=20000&&start==true){best=score;score=0;start=false;}
  textSize(32);
  textAlign(RIGHT);
  text("Best: ",width-80,40);
  text(best,width-40,40);
  textSize(64);
  textAlign(CENTER);
  text(score,width/2,height/3);
  if(start){
  textAlign(RIGHT);
  text((millis()-timer)/1000,width/2-60,height/6);
  text(":",width/2-20,height/6);
  textAlign(CENTER);
  text((millis()-timer)%1000,width/2+60,height/6);
  }
}

void mousePressed(){
  if(!start){start=true;timer=millis();}
  if(circle&&dist(mouseX,mouseY,posX,posY)<=radius){circle=false;score++;}
  
}

void setup(){
  fullScreen();
  textAlign(CENTER);
  fill(0);
  textSize(64);
  noStroke();
}