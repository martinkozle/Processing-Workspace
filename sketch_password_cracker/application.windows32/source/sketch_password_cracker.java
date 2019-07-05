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

public class sketch_password_cracker extends PApplet {


String password="martin";

String i="";
long counter=0;
int time=0;
long currCount=0;
int speed=0;

public void draw(){
  background(255);
  textAlign(LEFT);
  text(i,width/2,height/2);
  if(millis()-time>=1000){speed=(int)(counter-currCount);time=millis();currCount=counter;}
  text(speed,width/2,height/2+50);
  textAlign(RIGHT);
  text((int)counter,width/2,height/2);
  text(":",width/2,height/2);
  text("Speed :",width/2,height/2+50);
}

public void setup(){
    
  fill(0);
  time=millis();
  thread("countUp");
}

public boolean countUp(){
  for(;;addUp(i.length()))
    for(;checkNumOfChar();i=next(i),counter++)if(i.equals(password))return false;
}

public void addUp(int l){
   i="";
   for(int c=0;c<=l;c++)
     i+="a";
}

public boolean checkNumOfChar(){
  boolean p=false;
  for(int z=0;z<i.length();z++)if(i.charAt(z)!='z')p=true;
    return p;
}

 public static String next(String s) {
   int length = s.length();
   char c = s.charAt(length - 1);

   if(c == 'z')
     return length > 1 ? next(s.substring(0, length - 1)) + 'a' : "aa";

   return s.substring(0, length - 1) + ++c;
 }
  public void settings() {  size(640,480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_password_cracker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
