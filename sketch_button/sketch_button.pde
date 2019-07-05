button test=new button(500,500,200,100,"test");


void draw(){
  background(225);
  test.drawButton();
}

void mouseClicked(){
  if(test.isClicked())
    print("nice\n");
}

void mouseMoved(){
  if(test.isClicked())
    cursor(HAND);
  else
    cursor(ARROW);
}


void setup(){
  size(1280,720);
  
}
