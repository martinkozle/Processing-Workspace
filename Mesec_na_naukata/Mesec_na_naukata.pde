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

void draw() {                    //funkcija sto se povtoruva 30 pati vo sekunda
  background(0, 255, 0);
  image(backgroundImg, 0, 0, displayWidth*3, displayWidth*9/4);
  if (!gameStarted)mainMenu();
  else playGame();
}

void playGame() {                //funkcija za samata igra sto se povtoruva 60 pati vo sekunda

  expression.drawExpression(); //crta gorniot pravoagolnik i izraz
  board.drawPlayArea();          //crta 16te zeleni kvadratcinja dole
  textAlign(LEFT);
  textFont(expressionFont);
  fill(#C90000);
  text((millis()-timer)/1000+"s",displayWidth*6/10,displayWidth*2/15);
  strokeWeight(8);
  stroke(#C90000);
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
void mainMenu() {                //prv ekran koga se pusta aplikacijata (triagolnikot za play)
  fill(#C9AB00);
  textAlign(CENTER);
  textFont(expressionFont);
  text("How fast can you",displayWidth/2,displayHeight/6);
  text("solve 5 expressions?",displayWidth/2,displayHeight/6+displayWidth*64/360);
  text("Made by Martin Popovski",displayWidth/2,displayHeight*11/12);
  if(previousTime!=-1)text(previousTime+"s",displayWidth/2,displayHeight*5/6);
  fill(#00FF00);
  stroke(#009B00);
  strokeWeight(8);
  triangle(displayWidth/2-displayWidth/6, displayHeight/2-displayWidth/6, displayWidth/2-displayWidth/6, displayHeight/2+displayWidth/6, displayWidth/2+displayWidth/6, displayHeight/2);
  ellipse(displayWidth/2+sin(rotatingBallValue)*displayWidth/3,displayHeight/2+cos(rotatingBallValue)*displayWidth/3,displayWidth/12,displayWidth/12);
  rotatingBallValue+=PI/32;
}

void touchStarted() {
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
void touchMoved() {
  if (gameStarted&&currentHeldNumber!=-1&&!squarePutInOne) {
    int temp;
    temp=expression.squareReleased((int)touches[0].x, (int)touches[0].y, currentHeldNumber);
    if (temp!=-1) {
      board.putIt(temp);
      squarePutInOne=true;
    }
  }
}
void touchEnded() {
  board.released();
  squarePutInOne=false;
}

void setup() {          //prva funkcija pred se
  //size(360,640);                          //720,1280 - 360,640 - 1080,1920
  //fullScreen();
  frameRate(30);
  noSmooth();
  
  
  buttonFont=createFont("Monospaced.plain", displayWidth*64/360);
  expressionFont=createFont("Monospaced.plain", displayWidth*32/360);
  
  board=new playArea(displayWidth, displayHeight, buttonFont);
  expression=new expressionArea(displayWidth, displayHeight, expressionFont);
  backgroundImg=loadImage("colour-math-function.jpg");
}
void settings(){
  fullScreen(P2D);
}