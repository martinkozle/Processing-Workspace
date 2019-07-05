class expressionArea {
  private int w;
  private int h;
  private PFont font;
  private int randomExpression;
  private int numberOfExpressions=9;
  private expressionFunctions expressions[]=new expressionFunctions[numberOfExpressions];
  public expressionArea(int w, int h, PFont font) {
    this.w=w;
    this.h=h;
    this.font=font;
    expressions[0]=new expressionFunctions(0, 2, 2, font, w, h);   //kreirame 9(numberOfExpressions) objekti, po eden za sekoj izraz 
    expressions[1]=new expressionFunctions(1, 2, 3, font, w, h);   //(broj na izraz,broj na inputSquares,broj na parameters,font,w,h)
    expressions[2]=new expressionFunctions(2, 2, 2, font, w, h);
    expressions[3]=new expressionFunctions(3, 2, 3, font, w, h);
    expressions[4]=new expressionFunctions(4, 2, 3, font, w, h);
    expressions[5]=new expressionFunctions(5, 2, 3, font, w, h);
    expressions[6]=new expressionFunctions(6, 2, 3, font, w, h);
    expressions[7]=new expressionFunctions(7, 2, 3, font, w, h);
    expressions[8]=new expressionFunctions(8, 2, 3, font, w, h);
  }
  public void chooseExpression(int in[][]) {                    //bira random izraz od dadenite
    randomExpression=(int)random(numberOfExpressions);
    expressions[randomExpression].chooseParameters(in);
  }
  public boolean isItCorrect(){
     return expressions[randomExpression].check();
  }
  public int squareReleased(int x, int y, int val) {            //funkcija sto proveruva dali e ostaven zelen kvadrat vo nekoj od inputSquares na momentalniot izraz
    return expressions[randomExpression].squareReleased(x, y, val);
  }
  
  public void drawExpression() {                              //crta portokalov pravoagolnik i ja povikuva metodata za crtanje na momentalniot izraz objekt
    //currentExpression=a;
    fill(0xffFFC800);
    stroke(0xffFF9B00);
    strokeWeight(8);

    rect(4, h/6-displayWidth*39/360, w-8, displayWidth*64/360);
    expressions[randomExpression].drawExp();
  }
}