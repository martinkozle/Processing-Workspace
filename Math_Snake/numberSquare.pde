class numberSquare{
  private int value;
  private int x,y;
  public numberSquare(int value,int x,int y){
    this.value=value;
    this.x=x;
    this.y=y;
  }
  public void drawSquare(int startX,int startY,int a){
    fill(#38D651);
    noStroke();
    rect(startX,startY,a,a,5,5,5,5);
  }
  public int getVal(){
    return value;
  }
}