
double[] arr = new double[1000];
int pluses = 0;
int total = 0;
HScrollbar hs;

void draw(){
	background(255);
	for(int i = 10; i < 970; i++){
		fill(255, 0, 0);
		noStroke();
		ellipse(i, 600 - (int)(arr[i]*500), 2, 2);
	}
	stroke(0, 0, 255);
	line(10, 600, 970, 600);
	line(10, 350, 970, 350);
	line(10, 100, 970, 100);
	v = (hs.getPos() - 10) / 960;
	hs.update();
	hs.display();
}

void mouseDragged(){
	thread("prob");
}
double v = 0.5;
void prob(){
	pluses = 0;
	total = 0;
	for(int i = 10; i < 970; i++){
		if(random(1) > v)
			pluses ++;
		total++;
		arr[i] = (double)pluses / total;
	}
}

void setup(){
	size(960, 640);
	hs = new HScrollbar(0, 50, width, 16, 16);
	thread("prob");
}