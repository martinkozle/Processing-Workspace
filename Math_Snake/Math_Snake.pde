playArea board;
goalNumber goal;
PImage backgroundImg;
boolean held[][]=new boolean[4][4];
void draw(){
  background(0,255,0);
  image(backgroundImg,0,0,width*3,width*9/4);
  board.drawPlayArea();
  goal.drawGoalNumber();
}

void mousePressed(){
  
}

void setup(){
  size(360,640);                          //720,1280 - 360,640 - 1080,1920
  board=new playArea(width,height);
  goal=new goalNumber(width,height,0,100);
  backgroundImg=loadImage("colour-math-function.jpg");
}