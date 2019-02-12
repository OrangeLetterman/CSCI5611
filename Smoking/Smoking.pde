ParticleSystem rightEye;
ParticleSystem leftEye;
PImage fox;

void setup() {
  size(800, 600, P3D);
  PImage fire_image = loadImage("fire-png-images-transparent-1.png");
  PImage smoke = loadImage("smoke.png");
  fox = loadImage("fox.png");
  fire_image.resize(200,200);
  smoke.resize(100,100);
  fox.resize(800,600);
  //fox.resize();
  rightEye = new ParticleSystem(new PVector((width/2)+100, height/2), fire_image, smoke);
  leftEye = new ParticleSystem(new PVector((width/2)-100, height/2), fire_image,smoke);
}

void draw() {
 // background(255);//make backgroud black
  background(fox);
 fill(100, 191, 255);
 // box(500,20,500);
  rightEye.run();
  leftEye.run();
 
  rightEye.addParticle();
   leftEye.addParticle();

}

class ParticleSystem {

  ArrayList<Particle> particles;    
  PVector begin;                   // where the fire begin and locate
  PImage fire_image;
  PImage smoke;

  ParticleSystem(PVector v, PImage image, PImage smo) {
    particles = new ArrayList<Particle>();             
    begin = v.copy();                                  
    fire_image = image;
    smoke = smo;
  
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.finished()) {
        particles.remove(i);
      }
    }
  }


  void addParticle() {
    particles.add(new Particle(begin, fire_image, smoke));
  }
}


class Particle {
 // PVector center;
  float centerX;
  float centerY;
  float positionX;
  float positionY;
  float velocityX;
  float veloctiyY;
  float acc;
  float lifespan;
  PImage fire_image;
  PImage smoke;
  color fireColor;
  Particle(PVector l, PImage image, PImage smo) {

    acc = 0;
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    velocityX = vx;
    veloctiyY = vy;

    positionX = l.x;
    positionY = l.y;
 
    centerX = l.x;
    centerY = l.y;
    lifespan = 100.0;
    fire_image = image;
    smoke = smo;
    fireColor = color(255, 226, 0);
  }

  void run() {
    update();
    render();
  }

//update particle postion
  void update() {
   // vel.add(acc);
   //velocityX+=acc;
   //veloctiyY+=acc;
  //  loc.add(vel);
  positionX+=velocityX;
  positionY+=veloctiyY;
    lifespan -= 2.5;
    //acc*=0;
   
  }

  void render() {
    imageMode(CENTER);
    tint(255, 255, 255, lifespan);//make it red like fire
   // fill(255,0,0);
    image(fire_image, positionX, positionY, 70,90);
    image(smoke, positionX,positionY-30, 50,70);
    
  }

  boolean finished() {
    return lifespan <= 0;
  }
}
