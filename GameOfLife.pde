import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_COLS = 20;
public final static int NUM_ROWS = 20;
private LifeCell[][] buttons; //2d array of minesweeper buttons
private boolean[][] buffer; //2d array of booleans to store state of buttons array

void setup ()
{
    size(400, 450);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new LifeCell[NUM_ROWS][NUM_COLS];

    for(int i = 0; i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_COLS; j++){
            buttons[i][j] = new LifeCell(i, j);
        }
    }

    //your code to initialize buffer goes here
    buffer = new boolean[NUM_ROWS][NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_COLS; j++){
            buffer[i][j] = false;
        }
    }
    frameRate(4);

    setCells();
}

public void setCells()
{
    for(int i = 0; i < 10; i++){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(!buffer[row][col]){
            buffer[row][col] = true;
            buttons[row][col].makeAlive();
        }else{
            i--;
        }
    }
}

public void draw ()
{
    background(100,100,100);
}
public boolean isValid(int r, int c)
{
    //your code here
    return r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0;
}
public int countNeighbors(int row, int col)
{
    int neighbors = 0;
    //your code here

    for(int i = row - 1; i <= row + 1; i++){
        for(int j = col - 1; j <= col + 1; j++){
            if(isValid(i, j) && buffer[i][j]){
                neighbors++;
            }
        }
    }

    return neighbors;
}
/*public class GameController{
    private float x,y, width, height;
    private String myLabel;
    private boolean running;

    public GameController ()
    {
        width = 40.0;
        x = (400.0/2) - (width/2);
        height = 25.0;
        y = 415;
        myLabel = "Start";
        running = false;
        Interactive.add( this ); // register it with the manager
    }
    public void mousePressed () 
    {
        if(running){
            for(int i = 0; i < NUM_ROWS; i++){
                for(int j = 0; j < NUM_COLS; j++){
                    buttons[i][j].stop();
                }
            }
            running = false;
            myLabel = "Start";
        }else{
            for(int i = 0; i < NUM_ROWS; i++){
                for(int j = 0; j < NUM_COLS; j++){
                    buttons[i][j].start();
                }
            }
            running = true;
            myLabel = "Stop";
        }
    }
    public void draw(){
        fill(200);
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }

}*/

public class LifeCell
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean alive, running;
    
    public LifeCell ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        alive = false;
        running = true;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        //your code here
        if(alive){
            buffer[myRow][myCol] = false;
            alive = false;
        }else{
            buffer[myRow][myCol] = true;
            alive = true;
        }
    }
    public void draw () 
    {
        if(running){
            int neighbors = countNeighbors(myRow, myCol);
            // 1
            if(!alive && neighbors == 3){
                alive = true;
            // 2
            }else if(alive && (neighbors == 2 || neighbors == 3)){
                alive = true;
            // 3
            } else {
                alive = false;
            }

            updateAlive();
        }

        if (alive != true){
            fill(0);
        }
        else {
            fill(0, 150, 0);
        }

        rect(x, y, width, height);
    }
    public boolean isAlive()
    {
        return alive;
    }
    public void stop(){
        running = false;
    }
    public void start(){
        running = true;
    }
    public void makeAlive(){
        alive = true;
    }
    private void updateAlive(){
        if(alive){
            buffer[myRow][myCol] = true;
        }else {
            buffer[myRow][myCol] = false;
        }
    }
}
