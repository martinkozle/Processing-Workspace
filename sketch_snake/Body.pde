class Body{
 int x;
 int y;
 int age;
 boolean head;
 Body(int x,int y,boolean head){
   this.x=x;
   this.y=y;
   this.head=head;
   if(this.x>15)this.x=0;
   if(this.y>15)this.y=0;
   if(this.x<0)this.x=15;
   if(this.y<0)this.y=15;
 }
 void display(){
   noStroke();
   fill(#00FF01);
   rect(x*32,y*32,32,32);
   if(head){fill(#FF0000);ellipse(x*32+16,y*32+16,20,20);fill(#FFFFFF);ellipse(x*32+16,y*32+16,10,10);}
 }
}