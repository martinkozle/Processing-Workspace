package processing.test.mesec_na_naukata;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Mesec_na_naukata extends PApplet {

PFont buttonFont;
PFont expressionFont;
playArea board;                  //objekt od klasata za crtanje na 16te zeleni kvadratcinja
expressionArea expression;       //objekt od klasata za crtanje pravoagolnikot i izrazite
//goalNumber goal;
PImage backgroundImg;            //pozadinskata zelena slika
int fontSize;
boolean gameStarted=false;       //dali sme vo main menu ili ne
boolean squarePutInOne=false;    //dali kvadratce sto drzevme go ostavivme vekje vo prazno kvadratce
int currentHeldNumber=-1;        //brojot na kvadratceto sto go drzeme, -1 ako nisto ne drzeme
float rotatingBallValue=0;
int expressionOutOf5=0;
float timer;
float previousTime=-1;

public void draw() {                    //funkcija sto se povtoruva 30 pati vo sekunda
  background(0, 255, 0);
  image(backgroundImg, 0, 0, displayWidth*3, displayWidth*9/4);
  if (!gameStarted)mainMenu();
  else playGame();
}

public void playGame() {                //funkcija za samata igra sto se povtoruva 60 pati vo sekunda

  expression.drawExpression(); //crta gorniot pravoagolnik i izraz
  board.drawPlayArea();          //crta 16te zeleni kvadratcinja dole
  textAlign(LEFT);
  textFont(expressionFont);
  fill(0xffC90000);
  text((millis()-timer)/1000+"s",displayWidth*6/10,displayWidth*2/15);
  strokeWeight(8);
  stroke(0xffC90000);
  line(displayWidth/50,displayWidth/50,displayWidth/50+displayWidth/10,displayWidth/50+displayWidth/10);
  line(displayWidth/50,displayWidth/50+displayWidth/10,displayWidth/50+displayWidth/10,displayWidth/50);
  if(expression.isItCorrect()){
    if(expressionOutOf5==5){
      previousTime=(millis()-timer)/1000;
      gameStarted=false;
    }
    board.unPutIt(0);
    board.unPutIt(1);
    board.setNumbers();
    expressionOutOf5++;
    expression.chooseExpression(board.getValues());
  }
}
public void mainMenu() {                //prv ekran koga se pusta aplikacijata (triagolnikot za play)
  fill(0xffC9AB00);
  textAlign(CENTER);
  textFont(expressionFont);
  text("How fast can you",displayWidth/2,displayHeight/6);
  text("solve 5 expressions?",displayWidth/2,displayHeight/6+displayWidth*64/360);
  text("Made by Martin Popovski",displayWidth/2,displayHeight*11/12);
  if(previousTime!=-1)text(previousTime+"s",displayWidth/2,displayHeight*5/6);
  fill(0xff00FF00);
  stroke(0xff009B00);
  strokeWeight(8);
  triangle(displayWidth/2-displayWidth/6, displayHeight/2-displayWidth/6, displayWidth/2-displayWidth/6, displayHeight/2+displayWidth/6, displayWidth/2+displayWidth/6, displayHeight/2);
  ellipse(displayWidth/2+sin(rotatingBallValue)*displayWidth/3,displayHeight/2+cos(rotatingBallValue)*displayWidth/3,displayWidth/12,displayWidth/12);
  rotatingBallValue+=PI/32;
}

public void touchStarted() {
  if (gameStarted)currentHeldNumber=board.pressed((int)touches[0].x, (int)touches[0].y);
  if(gameStarted&&touches.length>0&&touches[0].x<displayWidth/50+displayWidth/10&&touches[0].y<displayWidth/50+displayWidth/10){
    previousTime=-1;
    gameStarted=false;
  }
  if (dist(displayWidth/2, displayHeight/2, touches[0].x, touches[0].y)<displayWidth/3&&!gameStarted) {
    gameStarted=true;
    expressionOutOf5=0;
    expression.chooseExpression(board.getValues());
    timer=millis();
  }
  if (gameStarted&&currentHeldNumber==-1) {
    int temp;
    temp=expression.squareReleased((int)touches[0].x, (int)touches[0].y, currentHeldNumber);
    if (temp!=-1)board.unPutIt(temp);
  }
  if (gameStarted&&currentHeldNumber==-1) {
    int temp;
    temp=expression.squareReleased((int)touches[0].x, (int)touches[0].y, currentHeldNumber);
    if (temp!=-1) {
      board.putIt(temp);
    }
  }
  //if (touches[0].x<100&&touches[0].y<100)tt++;
}
public void touchMoved() {
  if (gameStarted&&currentHeldNumber!=-1&&!squarePutInOne) {
    int temp;
    temp=expression.squareReleased((int)touches[0].x, (int)touches[0].y, currentHeldNumber);
    if (temp!=-1) {
      board.putIt(temp);
      squarePutInOne=true;
    }
  }
}
public void touchEnded() {
  board.released();
  squarePutInOne=false;
}

public void setup() {          //prva funkcija pred se
  //size(360,640);                          //720,1280 - 360,640 - 1080,1920
  //fullScreen();
  frameRate(30);
  
  
  
  buttonFont=createFont("Monospaced.plain", displayWidth*64/360);
  expressionFont=createFont("Monospaced.plain", displayWidth*32/360);
  
  board=new playArea(displayWidth, displayHeight, buttonFont);
  expression=new expressionArea(displayWidth, displayHeight, expressionFont);
  backgroundImg=loadImage("colour-math-function.jpg");
}
public void settings(){
  fullScreen(P2D);
}
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
class expressionFunctions {
  private float parameters[];                          //parametri, broevi sto se oznaceni so $ podolu
  private int expressionNumber;
  private PFont font;
  private int fontSize=displayWidth*32/360;
  private inputSquare squares[];                     //vlezni kvadratcinja(inputSquares) koi sto drzat vrednost na staveniot broj, oznaceni so a,b,c... podolu
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
    while (temp) {
      for (int i=0; i<parameterNum; i++) {
        parameters[i]=(int)random(100);
      }
      for (int i1=0; i1<4&&temp; i1++)for (int j1=0; j1<4&&temp; j1++) {
        squares[0].updateVal(in[i1][j1]);
        for (int i2=0; i2<4; i2++)for (int j2=0; j2<4; j2++) {
          if(i1==i2&&j1==j2)continue;
          squares[1].updateVal(in[i2][j2]);
          if(check()){temp=false;break;}
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
    //textSize(fontSize);
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
      } else if (expressionString[expressionNumber].charAt(i)=='a'||expressionString[expressionNumber].charAt(i)=='b'||expressionString[expressionNumber].charAt(i)=='c') {
        squares[inputAt].drawSquare(8+temp*fontSize/2, h/6);
        inputAt++;
        temp+=2;
      } else if (expressionString[expressionNumber].charAt(i)==')'||expressionString[expressionNumber].charAt(i)=='/'||expressionString[expressionNumber].charAt(i)=='*') {
        text(expressionString[expressionNumber].charAt(i), 8+temp*fontSize/2, h/6);
        temp+=0.5f;
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
    this.sW=1.2f*fontSize;
    this.sH=1.2f*fontSize;
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
    else fill(0xff38D651);
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
class numberSquare {
  private int value;                  //koj broj go ima ovoj numberSquare?
  private int x;                      //koj index e ovoj numberSquare vo 4*4 playArea
  private int y;                      //
  private int startX;                 //goren lev agol na poedinecniot numberSquare
  private int startY;                 //
  private int a;                      //sirocina i visocina na numberSquare
  private PFont font;
  private int squareColor=0xff38D651;  //koja boja si?
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
class playArea {
  public int startX;                  //gorno levo kjose na 4*4 zelenite kvadratcija (numberSqares)
  public int startY;                  //
  private int wide;                   //kolku e siroko toa 4*4
  private int high;                   //kolku e visoko
  private int gap;                    //prostor pomegju 2 numberSquares
  private int sX;                     //square X polozba na gorno levo kjose
  private int sY;                     //square Y
  private int p;
  private int l;
  private int xHeld=-1;               //indeksi na momentalniot numberSquare sto se drzi
  private int yHeld=-1;               //
  private int squareSide;             //shirocina na numberSquare
  private int mat[][]=new int[5][2];  //matrica, od sostojbata na poslednite 5 numberSquares staveni vo inputSquares 
  private PFont font;
  //private boolean held[][]=new boolean[4][4];
  private numberSquare[][] numberSquares=new numberSquare[4][4];    //4*4=16 objekti od numberSquares
  public playArea(int w, int h, PFont font) {    //konstruktor
    this.font=font;
    gap=w/22;
    startX=w/18+(w%18)/2;
    startY=h-w+w/18-(w%18)/2;
    wide=w-w/9-w%18+gap/2;
    high=wide;
    p=(wide)/4;
    l=(wide)/4;
    squareSide=wide/4-gap/2;
    setNumbers();
    for (int i=0; i<5; i++) {
      mat[i][0]=-1;
      mat[i][1]=-1;
    }
  }

  public void drawPlayArea() {      //gi crta tie 16 numberSquares
    boolean tempij[][]=new boolean[4][4];    //tie numberSquares sto se dvizat, na kraj da se iscrtaat uste ednas za da bidat nad site drugi
    for (int i=0; i<4; i++)
      for (int j=0; j<4; j++) {
        boolean temp=true;
        for (int k=0; k<5; k++) {
          if (i==mat[k][0]&&j==mat[k][1])temp=false;    //ako e vo inputSquare toj numberSquare da ne se iscrta uste ednas dole
        }

        if (temp&&numberSquares[i][j].drawSquare(true)) {

          tempij[i][j]=true;
        }
      }
    for (int i=0; i<4; i++)
      for (int j=0; j<4; j++)
        if (tempij[i][j])numberSquares[i][j].drawSquare(false);
  }
  public void setNumbers() {        //namesti gi site numberSquares so random numbers
    int randomNumber;
    for (int i=0; i<4; i++)
      for (int j=0; j<4; j++) {
        float temp=random(10);
        if (temp<1)
          randomNumber=(int)random(100);      //namesteno e taka sto da ima povekje pomali brojki, a pomalku pogolemi
        else if (temp<2)
          randomNumber=(int)random(50);
        else if (temp<4)
          randomNumber=(int)random(30);
        else if (temp<6)
          randomNumber=(int)random(20);
        else
          randomNumber=(int)random(10);
        numberSquares[i][j]=new numberSquare(randomNumber, startX+i*p, startY+j*l, squareSide, font);
      }
  }
  public int getVal(int x, int y) {           //vrati value od daden number square so indexi x y
    return numberSquares[x][y].getVal();
  }
  public void putIt(int which) {              //zapisi deka nekoj numberSquare e vo inputNumber so index which
    numberSquares[xHeld][yHeld].put=true;
    if (mat[which][0]!=-1&&mat[which][1]!=-1)numberSquares[mat[which][0]][mat[which][1]].put=false;
    mat[which][0]=xHeld;
    mat[which][1]=yHeld;
  }
  public void unPutIt(int which) {            //zapisi deka nekoj numberSquare vekje NE E vo nito eden inputNumber, pa moze da se iscrtava
    if (mat[which][0]!=-1&&mat[which][1]!=-1)numberSquares[mat[which][0]][mat[which][1]].put=false;
    mat[which][0]=-1;
    mat[which][1]=-1;
  }
  public int[][] getValues(){
    int temp[][]=new int[4][4];
    for(int i=0;i<4;i++)
      for(int j=0;j<4;j++)
        temp[i][j]=numberSquares[i][j].getVal();
    return temp;
  }
  public int pressed(int mX, int mY) {        //dali e stisnat nekoj numberSquare
    if (mX>=startX&&mX<startX+wide&&mY>=startY&&mY<startY+high) {
      sX=(int)((mX-startX)/(wide/4));
      sY=(int)((mY-startY)/(high/4));
      for (int i=0; i<5; i++) {
        if (sX==mat[i][0]&&sY==mat[i][1])return -1;
      }
      if (!numberSquares[sX][sY].put) {
        numberSquares[sX][sY].held=true;
        xHeld=sX;
        yHeld=sY;
        return numberSquares[sX][sY].value;
      }
    }
    return -1;
  }
  public void released() {
    numberSquares[sX][sY].held=false;
  }
}
}
