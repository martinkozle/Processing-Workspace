class playArea {
  public int startX;                  //gorno levo kjose na 4*4 zelenite kvadratcija (numberSqares)
  public int startY;                  //
  private int wide;                   //kolku e siroko toa 4*4
  private int high;                   //kolku e visoko
  private int gap;                    //prostor pomegju 2 numberSquares
  private int sX;                     //square X polozba na gorno levo kjose
  private int sY;                     //square Y
  private int p;
  private int l;
  private int xHeld=-1;               //indeksi na momentalniot numberSquare sto se drzi
  private int yHeld=-1;               //
  private int squareSide;             //shirocina na numberSquare
  private int mat[][]=new int[5][2];  //matrica, od sostojbata na poslednite 5 numberSquares staveni vo inputSquares 
  private PFont font;
  //private boolean held[][]=new boolean[4][4];
  private numberSquare[][] numberSquares=new numberSquare[4][4];    //4*4=16 objekti od numberSquares
  public playArea(int w, int h, PFont font) {    //konstruktor
    this.font=font;
    gap=w/22;
    startX=w/18+(w%18)/2;
    startY=h-w+w/18-(w%18)/2;
    wide=w-w/9-w%18+gap/2;
    high=wide;
    p=(wide)/4;
    l=(wide)/4;
    squareSide=wide/4-gap/2;
    setNumbers();
    for (int i=0; i<5; i++) {
      mat[i][0]=-1;
      mat[i][1]=-1;
    }
  }

  public void drawPlayArea() {      //gi crta tie 16 numberSquares
    boolean tempij[][]=new boolean[4][4];    //tie numberSquares sto se dvizat, na kraj da se iscrtaat uste ednas za da bidat nad site drugi
    for (int i=0; i<4; i++)
      for (int j=0; j<4; j++) {
        boolean temp=true;
        for (int k=0; k<5; k++) {
          if (i==mat[k][0]&&j==mat[k][1])temp=false;    //ako e vo inputSquare toj numberSquare da ne se iscrta uste ednas dole
        }

        if (temp&&numberSquares[i][j].drawSquare(true)) {

          tempij[i][j]=true;
        }
      }
    for (int i=0; i<4; i++)
      for (int j=0; j<4; j++)
        if (tempij[i][j])numberSquares[i][j].drawSquare(false);
  }
  public void setNumbers() {        //namesti gi site numberSquares so random numbers
    int randomNumber;
    for (int i=0; i<4; i++)
      for (int j=0; j<4; j++) {
        float temp=random(10);
        if (temp<1)
          randomNumber=(int)random(100);      //namesteno e taka sto da ima povekje pomali brojki, a pomalku pogolemi
        else if (temp<2)
          randomNumber=(int)random(50);
        else if (temp<4)
          randomNumber=(int)random(30);
        else if (temp<6)
          randomNumber=(int)random(20);
        else
          randomNumber=(int)random(10);
        numberSquares[i][j]=new numberSquare(randomNumber, startX+i*p, startY+j*l, squareSide, font);
      }
  }
  public int getVal(int x, int y) {           //vrati value od daden number square so indexi x y
    return numberSquares[x][y].getVal();
  }
  public void putIt(int which) {              //zapisi deka nekoj numberSquare e vo inputNumber so index which
    numberSquares[xHeld][yHeld].put=true;
    if (mat[which][0]!=-1&&mat[which][1]!=-1)numberSquares[mat[which][0]][mat[which][1]].put=false;
    mat[which][0]=xHeld;
    mat[which][1]=yHeld;
  }
  public void unPutIt(int which) {            //zapisi deka nekoj numberSquare vekje NE E vo nito eden inputNumber, pa moze da se iscrtava
    if (mat[which][0]!=-1&&mat[which][1]!=-1)numberSquares[mat[which][0]][mat[which][1]].put=false;
    mat[which][0]=-1;
    mat[which][1]=-1;
  }
  public int[][] getValues(){
    int temp[][]=new int[4][4];
    for(int i=0;i<4;i++)
      for(int j=0;j<4;j++)
        temp[i][j]=numberSquares[i][j].getVal();
    return temp;
  }
  public int pressed(int mX, int mY) {        //dali e stisnat nekoj numberSquare
    if (mX>=startX&&mX<startX+wide&&mY>=startY&&mY<startY+high) {
      sX=(int)((mX-startX)/(wide/4));
      sY=(int)((mY-startY)/(high/4));
      for (int i=0; i<5; i++) {
        if (sX==mat[i][0]&&sY==mat[i][1])return -1;
      }
      if (!numberSquares[sX][sY].put) {
        numberSquares[sX][sY].held=true;
        xHeld=sX;
        yHeld=sY;
        return numberSquares[sX][sY].value;
      }
    }
    return -1;
  }
  public void released() {
    numberSquares[sX][sY].held=false;
  }
}