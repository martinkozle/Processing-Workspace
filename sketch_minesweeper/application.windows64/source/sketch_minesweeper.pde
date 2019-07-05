int margin=50;
boolean[][] fieldBombs=new boolean[8][8];
int[][] fieldNear=new int[8][8];
boolean[][] fieldOpened=new boolean[8][8];
boolean[][] fieldMarked=new boolean[8][8];
boolean[][] visited=new boolean[8][8];
boolean end=false;
boolean firstClick=true;

void reset(){
  end=false;
  firstClick=true;
  for(int i=0;i<8;i++){
    for(int j=0;j<8;j++){
      fieldBombs[i][j]=false;
      fieldOpened[i][j]=false;
      fieldNear[i][j]=0;
      fieldMarked[i][j]=false;
    }
  }
  for(int i=0;i<10;i++){
    int x,y;
    for(x=Math.round(random(7)),y=Math.round(random(7));fieldBombs[x][y];x=Math.round(random(7)),y=Math.round(random(7)));
    fieldBombs[x][y]=true;
    if(x<7)fieldNear[x+1][y]++; 
    if(x<7&&y<7)fieldNear[x+1][y+1]++; 
    if(x<7&&y>0)fieldNear[x+1][y-1]++; 
    if(y<7)fieldNear[x][y+1]++; 
    if(y>0)fieldNear[x][y-1]++; 
    if(x>0)fieldNear[x-1][y]++; 
    if(x>0&&y<7)fieldNear[x-1][y+1]++; 
    if(x>0&&y>0)fieldNear[x-1][y-1]++; 
  }
}

void display(){
  fill(100);
  textAlign(CENTER);
  textSize(16);
  for(int i=0;i<8;i++){
    for(int j=0;j<8;j++,fill(100)){
      if(fieldMarked[i][j])fill(200,0,0);
      if(fieldOpened[i][j])fill(200);
      rect(margin+5+i*50,margin+5+j*50,40,40);
      if(fieldOpened[i][j]){
        color c=#2E72FF;
        if(fieldNear[i][j]==0)continue;
        switch(fieldNear[i][j]){
          case 1:c=#2E72FF;break;
          case 2:c=#0AA534;break;
          case 3:c=#FF1717;break;
          case 4:c=#1100D8;break;
          case 5:c=#9600CE;break;
          case 6:c=#0087D8;break;
          case 7:c=#0B8E00;break;
          case 8:c=#FFF300;break;
        }
        
        fill(c);
        text(fieldNear[i][j],margin+25+i*50,margin+25+j*50);
      }
      
    }
  }
}

void resetVisited(){
  for(int i=0;i<8;i++)
    for(int j=0;j<8;j++)
      visited[i][j]=false;
}

boolean openNear(int x,int y){
    if(x<0||x>=8||y<0||y>=8)return false;
    if(fieldNear[x][y]!=0)return false;
    visited[x][y]=true;
    
    if(x<7)fieldOpened[x+1][y]=true;
    if(x<7&&y<7)fieldOpened[x+1][y+1]=true; 
    if(y>0&&x<7)fieldOpened[x+1][y-1]=true; 
    if(y<7)fieldOpened[x][y+1]=true; 
    if(y>0)fieldOpened[x][y-1]=true; 
    if(x>0)fieldOpened[x-1][y]=true; 
    if(x>0&&y<7)fieldOpened[x-1][y+1]=true; 
    if(x>0&&y>0)fieldOpened[x-1][y-1]=true;
    
    if(x>0&&y>0&&!visited[x-1][y-1])openNear(x-1,y-1);
    if(y>0&&!visited[x][y-1])openNear(x,y-1);
    if(y>0&&x<7&&!visited[x+1][y-1])openNear(x+1,y-1);
    if(x>0&&!visited[x-1][y])openNear(x-1,y);
    if(x<7&&!visited[x+1][y])openNear(x+1,y);
    if(x>0&&y<7&&!visited[x-1][y+1])openNear(x-1,y+1);
    if(y<7&&!visited[x][y+1])openNear(x,y+1);
    if(x<7&&y<7&&!visited[x+1][y+1])openNear(x+1,y+1);
    
    return true;
}

void mousePressed(){
    int x=(mouseX-margin)/50;
    int y=(mouseY-margin)/50;
  if(mouseButton==LEFT){
    if(x>=0&&x<8&&y>=0&&y<8){
      for(;(fieldBombs[x][y]&&firstClick)||(fieldNear[x][y]>0&&firstClick);reset());
      fieldOpened[x][y]=true;
      if(fieldBombs[x][y]&&!firstClick){end=true;}
      if(fieldNear[x][y]==0){
          resetVisited();
          openNear(x,y);
      }
      firstClick=false;
    }
  }
  if(mouseButton==RIGHT){
    if(x>=0&&x<8&&y>=0&&y<8)
      fieldMarked[x][y]=!fieldMarked[x][y];
  }
}

void draw(){
  background(155);
  
  if(end)reset();
  
  display();
  
  fill(200);
  rect(0,0,margin,height);
  rect(0,0,width,margin);
  rect(width-margin,0,width,height);
  rect(0,height-margin,width,height);
}

void setup(){
  size(500,500); 
  noStroke();
  reset();
}