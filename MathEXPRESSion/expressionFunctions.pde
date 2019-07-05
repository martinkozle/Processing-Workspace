class expressionFunctions {
  private float parameters[];                          //parametri, broevi sto se oznaceni so $ podolu
  private int expressionNumber;
  private PFont font;
  private int fontSize=displayWidth*32/360;
  private inputSquare squares[];       //vlezni kvadratcinja(inputSquares) koi sto drzat vrednost na staveniot broj, oznaceni so a,b,c... podolu
  private int w;
  private int h;
  private int parameterNum;
  private String expressionString[]=new String[9];
  private void setExpressionStrings() {      //Stringovi na izrazite, koi sto se prikazuvaat vo portokaloviot triagolnik
    expressionString[0]= "(a+$)*b=$";
    expressionString[1]= "($-a)(b-$)=$";
    expressionString[2]= "a*b-$=$";
    expressionString[3]= "$*a+$=$*c";
    expressionString[4]= "$*a-$*b=$";
    expressionString[5]= "($+a)/($-b)=$";
    expressionString[6]= "($-a)/($-b)=$";
    expressionString[7]= "($+a)/($+b)=$";
    expressionString[8]= "($-a)/($+b)=$";
  }

  public expressionFunctions(int expressionNumber, int inputNum, int parameterNum, PFont font, int w, int h) {    //konstruktor na sekoj od izrazite
    this.expressionNumber=expressionNumber;
    this.font=font;
    this.w=w;
    this.h=h;
    this.parameterNum=parameterNum;
    parameters=new float[parameterNum];
    squares=new inputSquare[inputNum];
    for (int i=0; i<inputNum; i++) {
      squares[i]=new inputSquare(w, h, font, fontSize);
    }
    setExpressionStrings();
    fontSize=displayWidth*48/360;
  }

  public void chooseParameters(int in[][]) {
    boolean temp=true;
    int countTo3=0;
    int randomNumber;
    while (temp) {
      for (int i=0; i<parameterNum; i++) {
        float temp1=random(10);
        if (temp1<1)
          randomNumber=(int)random(100);      //namesteno e taka sto da ima povekje pomali brojki, a pomalku pogolemi
        else if (temp1<2)
          randomNumber=(int)random(50);
        else if (temp1<4)
          randomNumber=(int)random(30);
        else if (temp1<6)
          randomNumber=(int)random(20);
        else
          randomNumber=(int)random(10);
        parameters[i]=randomNumber;
        
      }
      for (int i1=0; i1<4&&temp; i1++)for (int j1=0; j1<4&&temp; j1++) {
        squares[0].updateVal(in[i1][j1]);
        for (int i2=0; i2<4; i2++)for (int j2=0; j2<4; j2++) {
          if(i1==i2&&j1==j2)continue;
          squares[1].updateVal(in[i2][j2]);
          if(check()){countTo3++;if(countTo3==3){temp=false;break;}}
        }
      }
      squares[0].updateVal(-1);
      squares[1].updateVal(-1);
    }
  }

  public boolean check() {                          //proveruva dali izrazot e tocen so momentalnite parametri i inputSquares
    for (int i=0; i<squares.length; i++)
      if (squares[i].getVal()==-1)return false;     //ako nekoj od inputSquares ima vrednost -1 (e prazen/nema zeleno kvadratce vo nego), ne racunaj
    switch(expressionNumber) {
    case 0:
      return expression0();
    case 1:
      return expression1();
    case 2:
      return expression2();
    case 3:
      return expression3();
    case 4:
      return expression4();
    case 5:
      return expression5();
    case 6:
      return expression6();
    case 7:
      return expression7();
    case 8:
      return expression8();
    }
    return false;
  }
  public void drawExp() {    //call this to draw the expression on screen
    textAlign(CENTER);
    textFont(font);
    fill(0);
    float temp=1;
    for (int i=0, parameterAt=0, inputAt=0; i<expressionString[expressionNumber].length(); i++) {
      fill(0);
      if (expressionString[expressionNumber].charAt(i)=='$') {
        text((int)parameters[parameterAt], 8+temp*fontSize/2, h/6);
        parameterAt++;
        temp+=1;
        
      } else if (expressionString[expressionNumber].charAt(i)=='a'
        ||expressionString[expressionNumber].charAt(i)=='b'||expressionString[expressionNumber].charAt(i)=='c') {
          
        squares[inputAt].drawSquare(8+temp*fontSize/2, h/6);
        inputAt++;
        temp+=2;
        
      } else if (expressionString[expressionNumber].charAt(i)==')'||expressionString[expressionNumber].charAt(i)=='/'
      ||expressionString[expressionNumber].charAt(i)=='*') {
        
        text(expressionString[expressionNumber].charAt(i), 8+temp*fontSize/2, h/6);
        temp+=0.5;
        
      } else {
        text(expressionString[expressionNumber].charAt(i), 8+temp*fontSize/2, h/6);
        temp++;
      }
    }
  }

  public int squareReleased(int x, int y, int val) {
    for (int i=0; i<squares.length; i++) {
      if (squares[i].squareReleased(x, y, val)) {
        return i;
      }
    }
    return -1;
  }

  private boolean expression0() {    //(a+$)b=$
    return (squares[0].getVal()+parameters[0])*squares[1].getVal()==parameters[1];
  }
  private boolean expression1() {    //($-a)(b-$)=$
    return (parameters[0]-squares[0].getVal())*(squares[1].getVal()-parameters[1])==parameters[2];
  }
  private boolean expression2() {    //a*b-$=$
    return squares[0].getVal()*squares[1].getVal()-parameters[0]==parameters[1];
  }
  private boolean expression3() {    //$*a+$=$*c
    return parameters[0]*squares[0].getVal()+parameters[1]==parameters[2]*squares[1].getVal();
  }
  private boolean expression4() {    //a*$-b*$=$
    return (parameters[0]*squares[0].getVal())-(parameters[1]*squares[1].getVal())==parameters[2];
  }
  private boolean expression5() {    //($+a)/($-b)=$
    if (parameters[1]-squares[1].getVal()==0)return false;
    return (parameters[0]+squares[0].getVal())/(parameters[1]-squares[1].getVal())==parameters[2];
  }
  private boolean expression6() {    //($-a)/($-b)=$
  if (parameters[1]-squares[1].getVal()==0)return false;    //ke padne prograta ako delime so 0 dole, pa ne i davame ako znaeme deka toa ke se desi
    return (parameters[0]-squares[0].getVal())/(parameters[1]-squares[1].getVal())==parameters[2];
  }
  private boolean expression7() {    //($+a)/($+b)=$
    return (parameters[0]+squares[0].getVal())/(parameters[1]+squares[1].getVal())==parameters[2];
  }
  private boolean expression8() {    //($-a)/($+b)=$
    return (parameters[0]-squares[0].getVal())/(parameters[1]+squares[1].getVal())==parameters[2];
  }
}
