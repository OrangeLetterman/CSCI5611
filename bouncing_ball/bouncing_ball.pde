//declare variable
float x = 600;
float y = 300;
float xRate = 1.5;
float yRate = 2.1;
int width = 800;
int height = 600;
float gravityX = 0;
float gravityY = 0.2;
//float velocityX = 1.5;
//float velocityY = 2.1;
int squareX = 600;
int squareY = 550;

color ballColor = color(random(0, 255), random(0, 255), random(0, 255));

color boxColor = color(random(0, 255), random(0, 255), random(0, 255));

// Special Processing function to configure your program.
void setup() {
  size(800, 600, P3D);//get 800 by 600 window
  surface.setTitle("bouncing ball");
}
// Special Processing function that is called every frame
// to perform the rendering.
void draw() {
  
  // for every frame before we draw, then for every frame, x and y going to be increase
  x = x + xRate;
  y = y + yRate;
  //xRate = gravityX + xRate;
  yRate = gravityY + yRate;
  
  
  //if x is go beyond than the width of the screen 
  if ( x > width - 25){//|| x < 0, || x - 25 > squareX
    //xRate = xRate * -0.3;// bounce back
    xRate *= -0.95;
    x = width - 25;
  }else if (x - 25 < 0){
    xRate *= -0.95;
    x = 25;
  }
  
  
  //if x is go beyond the screen 
  if ( y > height-25 || y < 0){
    yRate = yRate * -0.55;// bounce back
    xRate *= 0.95;
    y = height-25;
  }
  
  if (y + 25 > squareY &&  x + 25 > squareX && 
      y - 25 < squareY + 50 &&  x - 25 < squareX + 50) {
        boxColor = color(random(0, 255), random(0, 255), random(0, 255));
  }
  
  
  background(100, 50, 10);//brown background
  fill(ballColor);
  ellipse(x, y, 50, 50);//a ball
  
  fill(boxColor);
  rect(squareX, squareY, 50, 50);

//translate(100, 100, 0);
  
}

void keyPressed(){
  
  if (keyCode == LEFT && squareX > 0){
   println("Position: " + squareX);
   squareX -= 15;
  }else if (keyCode == RIGHT && squareX < 750){
    println("Position: " + squareX);
    squareX += 10;
  }
  
}
