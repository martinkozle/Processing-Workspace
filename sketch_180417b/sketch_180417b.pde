color crvena=color(255,0,0);
color sina=color(0,0,255);
color zelena=color(0,255,0);

PImage slika;

void setup(){
  size(640,480); 
  slika=loadImage("Math EXPRESSion logo.png");
}

void draw(){
  background(crvena);
  fill(sina);
  triangle(50,50, 400,100, 100,300);
  fill(zelena);
  ellipse(450,300, 200,200);
  image(slika,220,140);
}
