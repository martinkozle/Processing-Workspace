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

public class sketch_Dragon_curve extends PApplet {

//1-left 2-down 3-up 4-right
int zoom=2;
int posX=0,posY=0;
int step=1;
int cameraX=640/2,cameraY=640/2;
int state[]=new int[65536];

public void draw(){}

public void mouseClicked(){
  for(int i=step-1,j=0;i>=0;i--,j++)
  switch(state[i]){
    case 1:state[step+j]=3;break;
    case 2:state[step+j]=1;break;
    case 3:state[step+j]=4;break;
    case 4:state[step+j]=2;break;
  }
  step*=2;
  displayState();
}

public void keyPressed(){
  switch(key){
    case 'a':cameraX+=10;break;
    case 'd':cameraX-=10;break;
    case 'w':cameraY+=10;break;
    case 's':cameraY-=10;break;
    case 'r':zoom++;break;
    case 'f':zoom--;break;
  }
  displayState();
}

public void displayState(){
  posX=0;
  posY=0;
  background(255,200,0);
  for(int i=0;i<step;i++){
    if(state[i]==0)break;
    switch(state[i]){
      case 1:
        line(posX+cameraX,posY+cameraY,posX-zoom+cameraX,posY+cameraY);
        posX-=zoom;
      break;
      case 2:
        line(posX+cameraX,posY+cameraY,posX+cameraX,posY+zoom+cameraY);
        posY+=zoom;
      break;
      case 3:
        line(posX+cameraX,posY+cameraY,posX+cameraX,posY-zoom+cameraY);
        posY-=zoom;
      break;
      case 4:
        line(posX+cameraX,posY+cameraY,posX+zoom+cameraX,posY+cameraY);
        posX+=zoom;
      break;
    }
  }
}

public void setup(){
  
  state[0]=4;
  background(255,200,0);
}
  public void settings() {  size(640,640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_Dragon_curve" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
