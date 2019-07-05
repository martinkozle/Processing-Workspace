class playArea{
  private int startX;
  private int startY;
  private int wide;
  private int high;
  private int gap;
  private numberSquare[][] numberSquares=new numberSquare[4][4];
  public playArea(int w,int h){
    gap=w/22;
    startX=w/18+(w%18)/2;
    startY=h-w+w/18-(w%18)/2;
    wide=w-w/9-w%18;
    high=wide;
    setNumbers();
  }
  public void drawPlayArea(boolean held[][]){
    int p=(wide/4)+gap/2+startX;
    int l=(high/4)+gap/2+startY;
    int a=wide/4-gap/2;
     for(int i=0;i<4;i++)
      for(int j=0;j<4;j++)
        if(!held[i][j])numberSquares[i][j].drawSquare(i*p,j*l,a);
          else numberSquares[i][j].drawSquare(mouseX,mouseY,a);
  }
  public void setNumbers(){
    for(int i=0;i<4;i++)
      for(int j=0;j<4;j++)
        numberSquares[i][j]=new numberSquare((int)random(100),i,j);
  }
  public int getVal(int x,int y){
    return numberSquares[x][y].getVal();
  }
  public boolean isPressed(){
    if(mouseX>=startX&&mouseX<=startX+wide&&mouseY>=startY&&mouseY<=startY+high)return true;
    else return false;
  }
  
}