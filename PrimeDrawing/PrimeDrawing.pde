static final int Width = 1000;
static final int Height = 1000;
int zoom = 5;

boolean[] nums = new boolean[Width * 20 * Height * 20];
int startX = Width / 2 - 1;
int startY = Height / 2;

void draw(){
	background(255);
	int x = startX;
	int y = startY;
	fill(255, 0, 0);
	line(0, startY, Width, startY);
	line(startX, 0, startX, Height);
	for(int i = 0, dist = 1, dir = 0, flag = 1; i < Width * 20 * Height * 20;){
		for(int j = 0; j < dist && i < Width * 20 * Height * 20; j++, i++){
			//if(!(x >= 0 && x < Width && y >= 0 && y< Height)){
			//	i = Width * 20 * Height * 20;
			//	break;
			//}
			if(nums[i]){
				fill(0);
				ellipse(x, y, zoom, zoom);
			}
			
			switch(dir){
				case 0:
					x += zoom;
					break;
				case 1:
					y -= zoom;
					break;
				case 2:
					x -= zoom;
					break;
				case 3:
					y += zoom;
					break;
			}
		}
		dir = (dir + 1) % 4;
		if(flag == -1){
			dist += 1;
		}
		flag *= -1;
	}
}

void keyPressed(){
	switch(key){
		case 'w': startY += 100; break;
		case 'a': startX += 100; break;
		case 's': startY -= 100; break;
		case 'd': startX -= 100; break;
		case 'r': zoom++; break;
		case 'f': zoom--; break;
	}
}

void findPrimes(){
	nums[0] = false;
	nums[1] = true;
	for(int i = 3; i < Height * Width; i++){
		boolean flag = true;
		for(int j = 2; j <= sqrt(i); j++){
			if(nums[j - 1] && i % j == 0){
				flag = false;
			}
		}
		if(flag){
			print(i + " is prime\n");
			nums[i - 1] = true;
		}
		else{
			nums[i - 1] = false;
		}
	}
}

void settings(){
	size(Height, Width);
}

void setup(){
	thread("findPrimes");
}