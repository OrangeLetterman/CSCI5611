//make particle bounce back and adjust the height

final int MAX_LIQUID = 5;
final float SPEED = 10;
PImage bg;

class Liquid {
  float locationX,locationY;
  float velocityX,velocityY;
  float gravity;
  float lifeSpan;

  Liquid() {
   // adjustLiquid();
    locationX = width / 2;
    locationY = height - 30;  // height is the height of the screen
    velocityX = SPEED * random(.50);
    velocityX *= random(0, 1) < 0.5 ? 1 : -1;
    velocityY = SPEED * random(-0.45, -0.35);
    gravity = 2 * random(0.005, 0.015);
    lifeSpan = 1000;
  }

  void adjustLiquid() {
    if (locationY < 0) {
      locationY = 0;
      velocityY *= -0.9;
    }
    if (locationY > height) {
      locationY = height;
      velocityY *= -0.9;
    }
    
    gravity = 2 * random(0.005, 0.015);//0.005, 0.015
    
  }

  void render() {
    pushMatrix();
    noStroke();
    fill(0, 191, 255);//change color
    translate(locationX, locationY);
    //point(10,10);
    ellipse(0, 0, 5, 5);//size of the liquid
    popMatrix();
  }

  void update() {
    locationX+=velocityX;
    locationY+=velocityY;
   

    velocityY += gravity;
    lifeSpan -= 3;
    if (offScreen()) {
      adjustLiquid();
    }
  }

  boolean offScreen() {
    return (locationY > height || locationX > width || locationX < 0 || locationY < 0);
  }
  
  boolean finished() {
    return lifeSpan <= 0;
  }
} // class Liquid

class Snow{
  float locationX,locationY;
  float velocityX,velocityY;
  float gravity;
  float lifeSpan;
  
  Snow() {
   // adjustLiquid();
    locationX = random(width);// randomGaussian*width
    //velocityX *= random(0, 1) < 0.5 ? 1 : -1;
    velocityY = random(0.01, 1);
    lifeSpan = random(500);
  }
  
  void render(){
    pushMatrix();
    noStroke();
    fill(100, 88, 88);//change color
    translate(locationX, locationY);
    //point(10,10);
    ellipse(0, 0, 5, 5);//size of the liquid
    popMatrix();
  
  
  }
  
  void update(){
    locationX-=velocityY;
   lifeSpan -= 3;
  
  }
  
  boolean finished() {
    return lifeSpan <= 0;
  }



}// class Snow


ArrayList<Liquid> liquids;
ArrayList<Snow> snows;

void setup() {
  size(800, 600, P3D);
  bg = loadImage("green-grass-and-clover-border-with-transparent-background-png-180.png");//51

  liquids = new ArrayList<Liquid>();
  int i = 0;
  while (i < MAX_LIQUID) {//random(MAX_LIQUID
    Liquid d = new Liquid();
    //Snow s = new Snow();
    //snows.add(s);
    liquids.add(d);
    i++;
  }
}

//void run() {
//    for (int i = liquids.size()-1; i >= 0; i--) {
//      Liquid p = liquids.get(i);
//      p.run();
//      if (p.finished()) {
//        particles.remove(i);
//      }
//    }
//  }

void draw() {
  
  background(bg);
 // background(255);
  
  //base box
  noStroke();
  pushMatrix();
  translate(width/2, height/2+65, -800);
  rotateX(radians(150));
  //fill(255,255,255);
 /// rotateY(radians(camAng));//increase or decrease depend on mouse drag
  //box(1500,20,1500);
  
  
  popMatrix();
  if (liquids. size() < 3000) {
    for (int k = 0; k < MAX_LIQUID; k++) {
      // Snow s = new Snow();
      //snows.add(s);
      Liquid d = new Liquid();
      liquids.add(d);
    }
  }
  for (int i = liquids.size()-1; i >= 0; i--) {
    Liquid drop =  liquids.get(i);
  
    drop.render();
    drop.update();
    if(drop.finished()){
      liquids.remove(i);
    }
   
  }
  //for (int i = snows.size()-1; i >= 0; i--) {
   
  //  Snow s = snows.get(i);
   
  //  s.render();
  //  s.update();
  //  if(s.finished()){
  //    snows.remove(i);
  //  }
  //}
  //for(int i = liquids.size()-1; i >= 0; i--) {
  //  Liquid f = liquids.get(i);
  ////  f.run();
  //  if (f.finished()) {
  //  //  liquids.remove(i);
  //  }
  //}// remove liquids when it die
  
}
