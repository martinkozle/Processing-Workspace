int red=1;
int timeToGreen;
int startTime;
int time;
String text;
boolean again=false;

void draw(){
  if(red==1)
    background(255,0,0);
  else if(red==2)
    background (0,255,0);
  else{
    background(100,100,100);
    text(text,width/2,100);
  }
  if(millis()-startTime>=timeToGreen&&again==false&&red==1){red=2;time=millis();}
}

void mousePressed(){
  if(again==true){
    again=false;
    startTime=millis();
    timeToGreen=(int)random(3000,5000);
    red=1;
  }
  else{
  if(millis()-startTime>=timeToGreen){
    red=3;
    text=String.valueOf((float)(millis()-time)/1000)+"s";
    again=true;
  }
  if(millis()-startTime<=timeToGreen){
    red=3;
    text="Fail";
    again=true;
  }
  }
  
}

void setup(){
  size(640,480);
  textAlign(CENTER);
  textSize(128);
  timeToGreen=(int)random(3000,7000);
  startTime=millis();
}