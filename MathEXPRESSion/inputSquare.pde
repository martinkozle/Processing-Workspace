class inputSquare {
  private float sW;                //square width
  private float sH;                //square heigth
  private boolean hasNum=false;    //dali ima broj kvadratceto
  private float value=-1;            //koj e toj broj sto go ima, -1 ako nema
  private PFont font;
  private int fontSize;
  private int pX;                  //position X
  private int pY;                  //position Y
  public inputSquare(int w, int h, PFont font, int fontSize) {    //konstruktor za inputSquares
    //this.value=val;
    this.font=font;
    this.fontSize=fontSize;
    this.sW=1.2*fontSize;
    this.sH=1.2*fontSize;
  }
  public void updateVal(int value) {    //promeni go brojot vo kvadratceto
    this.value=value;
    if (value==-1)hasNum=false;
    else hasNum=true;
  }
  public float getVal() {                  //vrati go brojot od kvadratceto
    return value;
  }
  public boolean squareReleased(int x, int y, int val) { //dali tuka ima dojdeno zeleno kvadratce, 30 pati vo sekunda
    if (x<pX+sW/2&&x>pX-sW&&y<pY+sH&&y>pY-sH) { //ako ima
        if((hasNum&&val==-1)||(!hasNum&&val!=-1)){
          updateVal(val);   //staj ja vrednosta na toa zeleno kvadratce da bide novata vrednost
          return true;
        }
        else{ return false;}
    }
    return false;
  }
  public void drawSquare(float posX, float posY) {       //metoda za crtanje na inputSquares
    pX=(int)posX+fontSize/2;
    pY=(int)posY-fontSize/4;
    if (!hasNum)
      fill(255);
    else fill(#38D651);
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    rect(posX+fontSize/2, posY-fontSize/4, sW, sH);
    if (hasNum) {
      textMode(CENTER);
      fill(0);
      textFont(font);
      text((int)value, posX+fontSize/2, posY);
    }
  }
}