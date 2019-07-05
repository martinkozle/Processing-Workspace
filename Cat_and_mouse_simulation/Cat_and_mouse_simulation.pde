import java.text.*;

final int width = 1000;
final int height = 600;
Button startSimulationButton = new Button(100, 529, 218, 34, "Start simulation", #994400, #000000);
boolean startSimulation = false;
Button resetButton = new Button(342, 529, 157, 34, "Reset", #990000, #000000);
int numAnimals = 100;
float catSpeed = 0.5;
float catSprintSpeed = 0;
float catSprintDuration = 0;
float mouseSpeed = 0.7;
float mouseSprintSpeed = 0;
float mouseSprintDuration = 0;
PlayGround p1 = new PlayGround(numAnimals, catSpeed, catSprintSpeed, catSprintDuration, mouseSpeed, mouseSprintSpeed, mouseSprintDuration);
int startingMillis = 0;
int finishMillis = 0;
boolean catsWin = false;
int fastForward = 1;


boolean devMode = false;	//F3
Button devButton = new Button(100, 100, 150, 30, "Temporary", #ff0000, #000000);	//used for getting arguments for permanent buttons
float slowerFrameRateUpdater = 60;	//framerate counter on F3 screen that updates 3 times a second (every 20 frames)
Animal devAnimal = new Animal(100, 100, 0.5, 0, 0, 0, 0, 0, width, height, #ff0000);	//usually we won't be making Animal objects
DecimalFormat doubleFormat = new DecimalFormat("00");
DecimalFormat trippleFormat = new DecimalFormat("000");
DecimalFormat singlePrecision = new DecimalFormat("0.0");
DecimalFormat doublePrecision = new DecimalFormat("0.00");
DecimalFormat tripplePrecision = new DecimalFormat("0.000");


void drawGameElements(){	//draws text on screen and buttons
	if(p1.numAliveMice == 0 && !catsWin){
		catsWin = true;
		finishMillis = millis();
	}
	textSize(34);
	fill(0);
	textAlign(LEFT, TOP);
	long total;
	if(startSimulation && !catsWin){
		total = (millis() - startingMillis) * fastForward;
	}
	else{
		total = (finishMillis - startingMillis) * fastForward;
	}
	text("Timer : " + (total / 60000 != 0 ? total / 60000 : 0) + ":"
		+ doubleFormat.format((total % 60000) / 1000) + "." + trippleFormat.format(total % 1000) + "\n", 100, 0);
	textAlign(CENTER, TOP);
	text("Cats " + p1.numAnimals + " vs. " + p1.numAliveMice + " Mice", 300, 50);
	startSimulationButton.draw();
	resetButton.draw();
}

void draw(){
	background(255);
	p1.tick(fastForward, startSimulation);
	drawGameElements();
	if(devMode){
		drawDevOverlay();
	}
}

//below is input and developer functions
void strokeText(String message, int x, int y) 
{ 
  fill(255); 
  text(message, x-1, y); 
  text(message, x, y-1); 
  text(message, x+1, y); 
  text(message, x, y+1); 
  fill(255, 0 , 0); 
  text(message, x, y); 
} 

void drawDevOverlay(){
	devAnimal.basicDraw();
	devAnimal.roam();
	devButton.draw();
	fill(255, 0, 0);
	stroke(0);
	textSize(24);
	textAlign(LEFT, TOP);
	
	if(frameCount % 20 == 0) slowerFrameRateUpdater = frameRate;
	strokeText("Dev mode;\n"
		+ "FPS: " + singlePrecision.format(slowerFrameRateUpdater) + ";\n"
		+ "devAnimal direction: " + singlePrecision.format(devAnimal.getDirection() / PI) + " Pi (" + singlePrecision.format(devAnimal.getDirection() / PI * 180) + " degrees);\n"
		+ "Number of alive mice: " + p1.numAliveMice + ";\n"
		+ "Fast forward: " + fastForward + "x;\n"
		, 10, 10);
}

void mousePressed(){
	if(devMode){
		devButton.pressed();
	}
	startSimulationButton.pressed();
	resetButton.pressed();
}

void mouseReleased() {
	if(devMode){
		if(devButton.released()){
			print("Dev button pressed\n");
		}
	}
	if(startSimulationButton.released() && !startSimulation){
		//catsWin = false;
		startSimulation = true;
		startingMillis = millis();
	}
	if(resetButton.released()){
		p1 = new PlayGround(numAnimals, catSpeed, catSprintSpeed, catSprintDuration, mouseSpeed, mouseSprintSpeed, mouseSprintDuration);
		startSimulation = false;
		catsWin = false;
		finishMillis = startingMillis;
	}
}

void mouseDragged() {
	if(devMode){
		devButton.moveButton(mouseX, mouseY);
	}
}

void tweakDevButton(){
	switch(key){
 		case 'w': devButton.resizeButton(0, 1); break;	//increase button height
 		case 'a': devButton.resizeButton(-1, 0); break;	//decrease button width
 		case 's': devButton.resizeButton(0, -1); break;	//decrease button height
 		case 'd': devButton.resizeButton(1, 0); break;	//increase button width
 		case 'p': devButton.printInfo(); break;			//print arguments for creating new button
 		case 'i': numAnimals++; break;					//increase amount of animals
 		case 'k': numAnimals--; break;					//decrease amount of animals
 		case 'f': if(!startSimulation && fastForward != 1) fastForward--; break;	//decrease fast forward amount
 		case 'r': if(!startSimulation) fastForward++; break;						//increase fast forward amount
 	}
}

void keyPressed(){
	if(keyCode == 114){	//F3		devMode = devMode == true ? false : true;	//toggle devMode
		devMode = devMode == true ? false : true;
	}
	if(devMode){
		tweakDevButton();
	}
}


void settings(){
	size(width, height);
}

void setup(){
	randomSeed(2);
}