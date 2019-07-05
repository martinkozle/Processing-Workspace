class Point{
  public float x;
  public float y;
  
  public Point(float x,float y){
    this.x=x;
    this.y=y;
  }
  public void display(){
    stroke(0);
    point(x,y);
  }
  
}