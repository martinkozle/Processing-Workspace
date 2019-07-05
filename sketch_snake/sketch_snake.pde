boolean eat=false;
boolean spawnedFood=false;
boolean moved=false;
boolean lose=false;
int best=0;
int foodX;
int foodY;
int len=2;
char dir='w';

//Body[] body=new Body[20];
ArrayList<Body> body=new ArrayList<Body>();

int xm=0;
int ym=-1;




void draw(){
  background(0);
  if(lose){
    lose=false;
    body.clear();
    
    body.add(new Body(7,9,false));
    body.add(new Body(7,8,false));
    body.add(new Body(7,7,true));
    
  }
  if(!spawnedFood){foodX=(int)random(0,15.999);foodY=(int)random(0,15.999);spawnedFood=true;}
  fill(#FEFF00);
  noStroke();
  rect(foodX*32,foodY*32,32,32);
  if(frameCount%10==0){
     moved=true;
     
     body.get(body.size()-1).head=false;
     body.add(new Body(body.get(body.size()-1).x+xm,body.get(body.size()-1).y+ym,true));
     for(int i=0;i<body.size()-1;i++){
       if(body.get(body.size()-1).x==body.get(i).x&&body.get(body.size()-1).y==body.get(i).y){
         lose=true;
         xm=0;
         ym=-1;
         dir='w';
         break;
       }
     }
     if(!eat){body.remove(0);}
     eat=false;
  }
  if(body.get(body.size()-1).x==foodX&&body.get(body.size()-1).y==foodY){spawnedFood=false;eat=true;}
  
  for(int i=0;i<body.size();i++){
    body.get(i).display();
  }
  
  textSize(18);
  stroke(0);
  fill(#FFFFFF);
  best=max(best,body.size());
  text("Score: "+body.size(),16,32);
  text("High score: "+best,512-158,32);
  text("made by martinkozle",156,512-16);
  
  //for(int i=0;i<16;i++){
  //  for(int j=0;j<16;j++){
  //    rect(j*32,i*32,32,32);
  //  }
  //}
}

void keyPressed(){
  if(moved==true)
  switch(key){
    case 'a':if(dir!='d'){xm=-1;ym=0;dir='a';moved=false;}break;
    case 'd':if(dir!='a'){xm=1;ym=0;dir='d';moved=false;}break;
    case 'w':if(dir!='s'){xm=0;ym=-1;dir='w';moved=false;}break;
    case 's':if(dir!='w'){xm=0;ym=1;dir='s';moved=false;}break;
    //case 'f':eat=true;break;
  }
}

void setup(){
  size(512,512);
  body.add(new Body(7,9,false));
  body.add(new Body(7,8,false));
  body.add(new Body(7,7,true));
  
}