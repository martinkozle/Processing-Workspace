class PlayGround{
	private final int leftWall = 100;
	private final int topWall = 100;
	private final int rightWall = 500;
	private final int bottomWall = 500;
	public int numAnimals;
	public int numAliveMice;
	Cat[] cats = new Cat[500];
	Mouse[] mice = new Mouse[500];
	PlayGround(int numAnimals, float catSpeed, float catSprintSpeed, float catSprintDuration,
	float mouseSpeed, float mouseSprintSpeed, float mouseSprintDuration){
		this.numAnimals = numAnimals;
		numAliveMice = numAnimals;
		if(numAnimals > 1){
			for(int i = 0; i < numAnimals; i++){
				cats[i] = new Cat(leftWall + 50,  topWall + 50 + i * (bottomWall - topWall - 100) / (numAnimals - 1),
					catSpeed, catSprintSpeed, catSprintDuration, 0, leftWall, topWall, rightWall, bottomWall);
				mice[i] = new Mouse(rightWall - 50,  topWall + 50 + i * (bottomWall - topWall - 100) / (numAnimals - 1),
					mouseSpeed, mouseSprintSpeed, mouseSprintDuration, PI, leftWall, topWall, rightWall, bottomWall);
			}
		}
		else if(numAnimals == 1){
			cats[0] = new Cat(leftWall + 50, topWall + (bottomWall - topWall) / 2,
					catSpeed, catSprintSpeed, catSprintDuration, 0, leftWall, topWall, rightWall, bottomWall);
			mice[0] = new Mouse(rightWall - 50, topWall + (bottomWall - topWall) / 2,
					mouseSpeed, mouseSprintSpeed, mouseSprintDuration, PI, leftWall, topWall, rightWall, bottomWall);
		}
	}
	public void tick(int fastForward, boolean simulate){
		if(simulate){
			for(int i = 0; i < fastForward; i++){
				simulate();
			}
		}
		draw();
	}
	public void simulate(){
		for(int i = 0; i < numAnimals; i++){
			mice[i].roam();
			cats[i].roam();
			for(int j = 0; j < numAnimals; j++){
				if(mice[i].checkIfCought(cats[j])){
					numAliveMice--;
					break;
				}
			}
		}
	}
	private void draw(){
		fill(0, 0, 255, 100);
		stroke(0);
		rect(leftWall, topWall, rightWall - leftWall, bottomWall - topWall);
		for(int i = 0; i < numAnimals; i++){
			mice[i].basicDraw();
		}
		for(int i = 0; i < numAnimals; i++){
			cats[i].basicDraw();
		}
	}
}