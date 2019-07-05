int cameraX=640/2,cameraY=640/2;
float tempX,tempY;
float c=1.0/32;
float k=0.1;
float distance=300;
float angle=0;

void draw(){
  tempX=cameraX+cos(angle)*distance;
  tempY=cameraY+sin(angle)*distance;
  distance/=pow(2,c);
  angle+=k;
  line(tempX,tempY,cameraX+cos(angle)*distance,cameraY+sin(angle)*distance);
  
}

void keyPressed(){
  if(key=='w'){
    background(230);
    k+=0.001;
    text(k,50,50);
    distance=300;
    angle=0;
  }
  if(key=='s'){
    background(230);
    k-=0.001;
    text(k,50,50);
    distance=300;
    angle=0;
  }
    
}

void setup(){
  size(640,640);
  fill(0);
  background(230);
}