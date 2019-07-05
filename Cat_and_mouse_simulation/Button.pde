class Button{
	private int x;
	private int y;
	private int sizeX;
	private int sizeY;
	private String text;
	private color buttonColor;
	private color clickedColor;
	private color textColor;
	private boolean buttonPressed;
	Button(int x, int y, int sizeX, int sizeY, String text, color buttonColor, color textColor){
		this.x = x;
		this.y = y;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		this.text = text;
		this.buttonColor = buttonColor;
		clickedColor = buttonColor - (1 << 31);	//substract from the alpha value of the color
		this.textColor = textColor;
	}
	Button(int x, int y, int sizeX, int sizeY, String text){
		this.x = x;
		this.y = y;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		this.text = text;
		this.buttonColor = #cccccc;
		clickedColor = buttonColor - (1 << 31); //substract from the alpha value of the color
		this.textColor = #000000;
	}
	public void pressed(){
		if(mouseX >= x && mouseX <= x + sizeX && mouseY >= y && mouseY <= y + sizeY){
			buttonPressed = true;
		}
	}
	public boolean released(){
		if(buttonPressed && mouseX >= x && mouseX <= x + sizeX && mouseY >= y && mouseY <= y + sizeY){
			buttonPressed = false;
			return true;
		}
		return false;
	}
	public void moveButton(int x, int y){
		this.x = x;
		this.y = y;
	}
	public void resizeButton(int resizeX, int resizeY){
		sizeX += resizeX;
		sizeY += resizeY;
	}
	public void printInfo(){
		print(x + ", " + y + ", " + sizeX + ", " + sizeY + ", \"" + text + "\"\n");
	}
	public void draw(){
		fill(buttonColor);
		if(buttonPressed){
			//fill(clickedColor);
			fill(clickedColor);
		}
		stroke(0, 0 ,0);
		rect(x, y, sizeX, sizeY);
		textSize(sizeY * 0.8);
		if(buttonPressed){
			textSize(sizeY * 0.75);
		}
		fill(textColor);
		textAlign(CENTER, TOP);
		text(text, x + sizeX / 2, y);
	}
}