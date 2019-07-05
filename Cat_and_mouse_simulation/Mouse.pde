class Mouse extends Animal{
	Mouse(float x, float y, float speed, float sprintSpeed, float sprintDuration, float direction, int leftWall, int topWall, int righWall, int bottomWall){
		super(x, y, speed, sprintSpeed, sprintDuration, direction, leftWall, topWall, righWall, bottomWall, #999999);
	}
	public boolean checkIfCought(Cat c){
		if(alive && sqrt(sq(c.x - x) + sq(c.y - y)) <= c.radius + radius){
			alive = false;
			return true;
		}
		return false;
	}
}