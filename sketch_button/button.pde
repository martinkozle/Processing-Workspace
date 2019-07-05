class button{
  private int x;
  private int y;
  private int sizeX;
  private int sizeY;
  private String text;
  public button(int x, int y, int sizeX, int sizeY, String text){
    this.x=x;
    this.y=y;
    this.sizeX=sizeX;
    this.sizeY=sizeY;
    this.text=text;
  }
  public void drawButton(){
    fill(0,155,0);
    stroke(0);
    rect(x,y,sizeX,sizeY);
    fill(0);
    textSize(54);
    textAlign(CENTER,CENTER);
    text(text,x+sizeX/2,y+sizeY/2);
  }
  public boolean isClicked(){
    if(mouseX>=x&&mouseX<=x+sizeX&&mouseY>=y&&mouseY<=y+sizeY)
      return true;
    return false;
  }
}
