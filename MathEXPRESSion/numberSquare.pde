class numberSquare {
  private int value;                  //koj broj go ima ovoj numberSquare?
  private int x;                      //koj index e ovoj numberSquare vo 4*4 playArea
  private int y;                      //
  private int startX;                 //goren lev agol na poedinecniot numberSquare
  private int startY;                 //
  private int a;                      //sirocina i visocina na numberSquare
  private PFont font;
  private color squareColor=#38D651;  //koja boja si?
  public boolean held=false;          //dali te drzi korisnikot?
  public boolean put=false;           //dali si staven vo inputSquare?

  public numberSquare(int value, int startX, int startY, int a, PFont font) {  //konstruktor
    this.value=value;
    this.startX=x=startX;
    this.startY=y=startY;
    this.a=a;
    this.font=font;
    //this.x=startX;
    //this.y=startY;
  }
  public boolean drawSquare(boolean moved) {    //nacrtaj me i pomesti me
    fill(squareColor);
    noStroke();
    if (!held) {
      if (!(x==startX&&y==startY)&&moved) {
        x+=(startX-x)/4;
        if (startX-x>0)x++;
        else x--;
        if (abs(startX-x)<2)x=startX;
        y+=(startY-y)/4;
        if (startY-y>0)y++;
        else y--;
        if (abs(startY-y)<2)y=startY;
      }
    } else {
      if (touchIsStarted&&moved) {
        x=(int)touches[0].x-a/2;
        y=(int)touches[0].y-a/2;
      }
    }
    rectMode(CORNER);
    rect(x, y, a, a, 5, 5, 5, 5);
    fill(0);
    //textSize(fontSize);
    textAlign(CENTER);
    textFont(font);
    text(value, x+a/2, y+4*a/5);
    if (!(x==startX&&y==startY))return true;
    else return false;
  }
  public int getVal() {
    return value;
  }
}