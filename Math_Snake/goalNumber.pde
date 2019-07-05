class goalNumber{
  private int number;
  private int startX;
  private int startY;  //left top corner of the pentagon
  private int wide;
  private int high;
  private int fontSize;
  private PImage img=loadImage("GoalNumberPentagon.png");
  
  public goalNumber(int w,int h,int from,int to){
    number=(int)random((float)from,(float)to+1);
    startX=w/3;
    startY=w/6;
    wide=w/3;
    high=w/3;
    fontSize=w*64/360;
  }
  public void updateNumber(int from,int to){
    number=(int)random((float)from,(float)to+1);
  }
  public void drawGoalNumber(){
    image(img,startX,startY,wide,high);
    textAlign(CENTER);
    fill(#5F4B00);
    textSize(fontSize);
    text(number,startX+wide/2,startY+high/1.3);
  }
  
  
}