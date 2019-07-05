class Animal{
	public float x;
	public float y;
	protected float direction;
	public float radius = 5;
	protected float speed;
	protected float sprintSpeed;
	protected float sprintDuration;
	protected boolean sprinting = false;
	protected boolean alive = true;
	private int leftWall;
	private int rightWall;
	private int topWall;
	private int bottomWall;
	private color animalColor;
	private boolean hitLeftWall = false;
	private boolean hitRightWall = false;
	private boolean hitTopWall = false;
	private boolean hitBottomWall = false;
	Animal(float x, float y, float speed, float sprintSpeed, float sprintDuration, float direction,
	int leftWall, int topWall, int rightWall, int bottomWall, color animalColor){
		this.x = x;
		this.y = y;
		this.speed = speed;
		this.sprintSpeed = sprintSpeed;
		this.sprintDuration = sprintDuration;
		this.direction = direction;
		this.leftWall = leftWall;
		this.topWall = topWall;
		this.rightWall = rightWall;
		this.bottomWall = bottomWall;
		this.animalColor = animalColor;
	}
	public float getDirection(){
		return direction;
	}
	protected void moveX(){	//I hate trigonometry
		x += cos(direction) * speed;
		hitLeftWall = false;
		hitRightWall = false;
		if(x - radius < leftWall){
			hitLeftWall = true;
			x = leftWall + radius;
		}
		else if(x + radius >= rightWall){
			hitRightWall = true;
			x = rightWall - radius;
		}
	}
	protected void moveY(){
		y -= sin(direction) * speed;
		hitTopWall = false;
		hitBottomWall = false;
		if(y - radius < topWall){
			hitTopWall = true;
			y = topWall + radius;
		} 
		if(y + radius >= bottomWall){
			hitBottomWall = true;
			y = bottomWall - radius;
		}
	}
	protected boolean evadeWall(){	//this function is to get the Animal away from the wall as quickly as possible
		if(hitTopWall){
			if(direction >= PI / 2 && direction < PI){
				direction += PI / 30;
			}
			else if(direction >= 0 && direction < PI / 2){
				direction += -1 * PI / 30;
			}
			return true;
		}
		else if(hitBottomWall){
			if(direction >= 3 * PI / 2 && direction < 2 * PI){
				direction += PI / 30;
			}
			else if(direction >= PI && direction < 3 * PI / 2){
				direction += -1 * PI / 30;
			}
			return true;
		}
		else if(hitLeftWall){
			if(direction >= PI && direction < 3 * PI / 2){
				direction += PI / 30;
			}
			else if(direction >= PI / 2 && direction < PI){
				direction += -1 * PI / 30;
			}
			return true;
		}
		else if(hitRightWall){	//special because breaking point is at 0 rad
			if(direction >= 0 && direction < PI / 2){
				direction += PI / 30;
			}
			else if(direction >= 3 * PI / 2 && direction < 2 * PI){
				direction += -1 * PI / 30;
			}
			return true;
		}
		return false;
	}
	protected void turn(){
		if(!evadeWall()){
			direction += random(-1 * PI / 16, PI / 16);
		}
		positiveMod();
	}
	protected void positiveMod(){
		direction = (direction % (2 * PI) + 2 * PI ) % (2 * PI);
	}
	public void roam(){	//Cat and Mouse will roam the same way if there is no enemy around
		if(alive){
			turn();
			moveX();
			moveY();
		}
	}
	public void basicDraw(){	//drawing animals with ellipses, might make a method with cat and mouse .png
		if(alive){
			fill(animalColor);
			stroke(0);
			ellipseMode(CENTER);
			ellipse(x, y, radius * 2, radius * 2);
			ellipse(x + cos(direction) * 3, y - sin(direction) * 3, 2, 2);
		}
	}
}