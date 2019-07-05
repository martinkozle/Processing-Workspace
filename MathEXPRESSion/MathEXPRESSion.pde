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
int score=0;
int plus10Alpha=0;
int previousScore=-1;

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
  text("Score: "+score,displayWidth*2/10,displayWidth*2/15);
  text((int)(60-(millis()-timer)/1000)+"s",displayWidth*6/10,displayWidth*2/15);
  fill(#C90000,plus10Alpha);
  if(plus10Alpha!=0)text("+10s",displayWidth*8/10,displayWidth*2/15);
  if(plus10Alpha>0)plus10Alpha-=3;
  fill(#C90000);
  strokeWeight(8);
  stroke(#C90000);
  line(displayWidth/50,displayWidth/50,displayWidth/50+displayWidth/10,displayWidth/50+displayWidth/10);
  line(displayWidth/50,displayWidth/50+displayWidth/10,displayWidth/50+displayWidth/10,displayWidth/50);
  if((60-(millis()-timer)/1000)<=0){
      previousScore=score;
      score=0;
      gameStarted=false;
      board.unPutIt(0);
      board.unPutIt(1);
  }
  if(expression.isItCorrect()){
    score++;
    timer+=10000;
    plus10Alpha=255;
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
  text("How many expressions",displayWidth/2,displayHeight/6);
  text("can you solve in 60s?",displayWidth/2,displayHeight/6+displayWidth*64/360);
  text("correct expression +10s",displayWidth/2,displayHeight/6+displayWidth*128/360);
  text("Made by Martin Popovski",displayWidth/2,displayHeight*11/12);
  if(previousScore!=-1)text("Score: "+previousScore,displayWidth/2,displayHeight*5/6);
  fill(#00FF00);
  stroke(#009B00);
  strokeWeight(8);
  triangle(displayWidth/2-displayWidth/6, displayHeight/2-displayWidth/6, displayWidth/2-displayWidth/6, displayHeight/2+displayWidth/6, displayWidth/2+displayWidth/6, displayHeight/2);
  ellipse(displayWidth/2+sin(rotatingBallValue)*displayWidth/3,displayHeight/2+cos(rotatingBallValue)*displayWidth/3,displayWidth/12,displayWidth/12);
  fill(#009B00);
  text("PLAY",displayWidth/2-displayWidth/24,displayHeight/2+displayWidth*10/360);
  rotatingBallValue+=PI/32;
}

void touchStarted() {
  if (gameStarted)currentHeldNumber=board.pressed((int)touches[0].x, (int)touches[0].y);
  if(gameStarted&&touches.length>0&&touches[0].x<displayWidth/50+displayWidth/10&&touches[0].y<displayWidth/50+displayWidth/10){
    gameStarted=false;
    plus10Alpha=0;
    board.unPutIt(0);
    board.unPutIt(1);
  }
  if (dist(displayWidth/2, displayHeight/2, touches[0].x, touches[0].y)<displayWidth/3&&!gameStarted) {
    gameStarted=true;
    expressionOutOf5=0;
    board.setNumbers();
    expression.chooseExpression(board.getValues());
    timer=millis();
    plus10Alpha=0;
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