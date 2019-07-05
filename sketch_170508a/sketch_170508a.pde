import java.util.*;

Queue<Dot> dots=new LinkedList();
//Queue<Integer> dotsY=new LinkedList();
float angle=PI/6;
float size=256;
boolean a=true;
int smt=1;
int counter=0;

void draw(){
     if(a){dots.add(new Dot(256,480,0));}
     print(dots.element().angle);
     print("  ");
     line(dots.element().x,dots.element().y,dots.element().x+(float)((sin(dots.element().angle+angle)*size)*sin(dots.element().angle+angle)),dots.element().y-(float)((cos(dots.element().angle+angle)*size))*sin(dots.element().angle+angle));
     line(dots.element().x,dots.element().y,dots.element().x-(float)((sin(dots.element().angle+angle)*size)*sin(dots.element().angle+angle)),dots.element().y-(float)((cos(dots.element().angle+angle)*size))*sin(dots.element().angle+angle));
     dots.add(new Dot( dots.element().x + (int)((sin(dots.element().angle+angle)*size)*sin(dots.element().angle+angle)) , dots.element().y - (int)((cos(dots.element().angle+angle)*size)*sin(dots.element().angle+angle)) , dots.element().angle+angle ));
     dots.add(new Dot( dots.element().x - (int)((sin(dots.element().angle+angle)*size)*sin(dots.element().angle+angle)) , dots.element().y - (int)((cos(dots.element().angle+angle)*size)*sin(dots.element().angle+angle)) , dots.element().angle+angle ));
     dots.remove();
     counter++;
     if(counter==smt){size/=2;smt*=2;counter=0;}
}


void keyPressed(){}

void setup(){
  size(512,512);
}