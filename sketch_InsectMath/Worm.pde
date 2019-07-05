class Worm{
  private float x;
  private float y;
  private float speedX;
  private float speedY;
  private float angle;
  private int b=0;
  private int radius=50;
  public int number;

  public Worm(int x,int y,int angle,int number){
    this.x=x;
    this.y=y;
    this.angle=angle;
    this.number=number;
  }
  public void updatePos(){
     chooseAngle();
     speedX=1*cos(angle);
     speedY=1*sin(angle);
     x+=speedX;
     y+=speedY;
     b--;
  }
  public void display(){
     fill(255);
     ellipse(x,y,radius,radius);
     fill(0);
     textSize(16);
     textAlign(CENTER);
     text(number,x,y);
  }
  public void chooseAngle(){
     angle+=random(-PI/32,PI/32);
  }

  public boolean ifClicked(){
    if(dist(mouseX,mouseY,x,y)<radius/2)
      return true;
    else
      return false;
  }


}
