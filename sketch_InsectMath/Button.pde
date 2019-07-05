public class Button{
  
private int x;
private int y;
private int sizeX;
private int sizeY;
private String text;
private int gotoMenu;

public Button(int x,int y,int sizeX,int sizeY,String text,int gotoMenu){
    this.x=x;
    this.y=y;
    this.sizeX=sizeX;
    this.sizeY=sizeY;
    this.text=text;
    this.gotoMenu=gotoMenu;
}

public void display(){
    fill(255);
    rect(x,y,sizeX,sizeY);
    fill(0);
    textSize(20);
    text(text,x+5,y+25);
}



public int clicked(int menu){
    if(mouseX>x&&mouseX<x+sizeX&&mouseY>y&&mouseY<y+sizeY){
      return gotoMenu;
    }
    return menu;
}
}