int p=1;
float dotAX=100;
float dotAY=512-100;
float dotBX=512-100;
float dotBY=512-100;
float dotCX=256;
float dotCY=512-370.8;

ArrayList<Point> points=new ArrayList<Point>();

void draw(){
  background(255); 
  
  for(int i=0;i<points.size();i++){
     points.get(i).display();
  }
  
  noStroke();
  fill(0,255,0);
  ellipse(dotAX,dotAY,5,5);
  ellipse(dotBX,dotBY,5,5);
  ellipse(dotCX,dotCY,5,5);
  
}

void func(){
  delay(1000);
  while(true){
   delay(1);
   int rand;
   rand=(int)random(0,3);
   if(rand==0)points.add( new Point( (points.get(points.size()-1).x+dotAX)/2 , (points.get(points.size()-1).y+dotAY)/2  ) );
   else if(rand==1)points.add( new Point( (points.get(points.size()-1).x+dotBX)/2 , (points.get(points.size()-1).y+dotBY)/2  ) );
   else if(rand==2)points.add( new Point( (points.get(points.size()-1).x+dotCX)/2 , (points.get(points.size()-1).y+dotCY)/2  ) );
  }
}

void setup(){
  size(512,512);
  frameRate(60);
  if(points.isEmpty())points.add( new Point( dotAX , dotAY ) );
  thread("func");
}