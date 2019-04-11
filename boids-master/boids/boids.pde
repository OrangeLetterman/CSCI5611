Boid barry;
ArrayList<Boid> boids;
ArrayList<Avoid> avoids;
ArrayList<Astar> astar;
ArrayList<Node> node;
ArrayList<PVector> obstacle;
int numOfObstacle = 5;
ArrayList<ArrayList<Node>> graphNode;
ArrayList<ArrayList<Node>> result = new ArrayList<ArrayList<Node>>();
float radius = 40;
 
int numberofNode = 20;
int nodeDistance = 300;
Node goal;
int numofBoids = 20;

float globalScale = .91;
float eraseRadius = 20;
String tool = "boids";

// boid control
float maxSpeed;
float friendRadius;
float crowdRadius;
float avoidRadius;
float coheseRadius;

boolean option_friend = true;
boolean option_crowd = true;
boolean option_avoid = true;
boolean option_noise = true;
boolean option_cohese = true;

int messageTimer = 0;
String messageText = "";

void setup () {
  size(800, 576);
  
  textSize(16);
  recalculateConstants();
  boids = new ArrayList<Boid>();
  avoids = new ArrayList<Avoid>();
  node = new ArrayList<Node>();
  graphNode = new ArrayList<ArrayList<Node>>();
  astar = new ArrayList<Astar>();
  goal = new Node(new PVector(width - 20,20));
 
 
  int count = 0;
  // set up boid and add it to node array
  while(count <numofBoids){
    float x = random(width - 10);
    float y = random(height - 10);
    PVector temp = new PVector(x, y);
    boids.add(new Boid(x, y));
    node.add(new Node(temp));
    
    
    count ++;
  
  }
   obstacle = new ArrayList<PVector>();
 for(int i = 0; i<numOfObstacle; i++){
   float x = random(width - 10);
   float y = random(height);
   pushMatrix();
   fill(255,215,0);
   ellipse(x, y, radius, radius);
   popMatrix();
   obstacle.add(new PVector(x, y));
 
 
 }
  //add node path for each boids
  
  int counter = 0;
  for(int i = 0; i<node.size(); i++){
    ArrayList<Node> temp = new ArrayList<Node>();
    temp.add(node.get(i));
    while(counter < numberofNode){//add node path
      boolean ok = true;
      float x = random(width - 10);
      float y = random(height - 10);
      for(PVector obs : obstacle) {
        if(PVector.dist(obs, new PVector(x, y)) < 28) {
          ok = false;
          break;
        }
      }
      if(!ok) {
        continue;
      }
      temp.add(new Node(new PVector(x, y))); 
      counter++;
    
     }
      counter = 0;
      temp.add(goal);
      graphNode.add(temp);
  
   }//for

 // node.add(goal);


     goal.changeColor();
   //set up node path for each boids
   for(int z = 0; z<graphNode.size();z++){
     ArrayList<Node> temp = graphNode.get(z);
     for(int i = 0; i< temp.size(); i++){
       for(int j = 0; j < temp.size(); j++){
          Node a = temp.get(i);
        //  a.display();
            Node b = temp.get(j);//numofBoids - 1
        //    b.display();
            float distance = dist(a.location.x, a.location.y, b.location.x, b.location.y);
             if (distance < nodeDistance && i != j){
                stroke(126);
                a.addEdge(b);
                float x1 = a.location.x;
                float y1 = a.location.y;
                float x2 = b.location.x;
                float y2 = b.location.y;
              //  line(x1, y1, x2, y2);
          }
         
       
       }
     
     
     }
   
   
   
   }// z for loop
   for(int i =0; i< graphNode.size();i++){//set up a star array
      Astar a = new Astar(graphNode.get(i));
      astar.add(a);
         Node agent = graphNode.get(i).get(0);
        
       ArrayList<Node> solution = a.astar(agent, goal);
      
      if(solution != null){//if this particular agent found an optimal path to the goal
         print("here");
          solution.add(0, goal);
         result.add(solution);
         for(int j = 0; j<solution.size();j++){
           Node b = solution.get(j);
          //   b.display();
     
     
          }//for
        }//if 
  
    }

  
  
  //setupWalls();
  goal.display();
}

// haha
void recalculateConstants () {
  maxSpeed = 2.1 * globalScale;
  friendRadius = 60 * globalScale;
  crowdRadius = (friendRadius / 1.3);
  avoidRadius = 90 * globalScale;
  coheseRadius = friendRadius;
}


//void setupWalls() {
//  avoids = new ArrayList<Avoid>();
//   for (int x = 0; x < width; x+= 20) {
//    avoids.add(new Avoid(x, 10));
//    avoids.add(new Avoid(x, height - 10));
//  } 
//}

//void setupCircle() {
//  avoids = new ArrayList<Avoid>();
//   for (int x = 0; x < 50; x+= 1) {
//     float dir = (x / 50.0) * TWO_PI;
//    avoids.add(new Avoid(width * 0.5 + cos(dir) * height*.4, height * 0.5 + sin(dir)*height*.4));
//  } 
//}


void draw () {
  noStroke();
 // colorMode(HSB);
  fill(0, 100);
 background(255);
 // rect(0, 0, width, height);
 for(int i = 0; i<obstacle.size(); i++){
 
   pushMatrix();
   fill(255,215,0);
   ellipse(obstacle.get(i).x, obstacle.get(i).y, radius, radius);
   popMatrix();
  
 
 
 }
 
 // draw all nodes
  for(int i = 0; i< graphNode.size(); i++){
    ArrayList<Node> temp = graphNode.get(i);
    for(int j = 0; j<temp.size(); j++){
      ArrayList<Node> neighbor = temp.get(j).edge;
      for(int z = 0; z<neighbor.size();z++){
     //   neighbor.get(z).display();
      
      }
    
    
    }
    
  
  
  }//graphnode for, draw the solution
  
  for(int i = 0; i<result.size(); i++){
    ArrayList<Node> sol = result.get(i);
    for(int j = 0; j< sol.size(); j++){
    //  sol.get(j).showPath();
    
    
    }
  
  
  }
 

    

  if (tool == "erase") {
    noFill();
    stroke(0, 100, 260);
    rect(mouseX - eraseRadius, mouseY - eraseRadius, eraseRadius * 2, eraseRadius *2);
    if (mousePressed) {
      erase();
    }
  } else if (tool == "avoids") {
    noStroke();
    fill(0, 200, 200);
    ellipse(mouseX, mouseY, 15, 15);
  }

// update the boid
  for (int i = 0; i <boids.size(); i++) {//update boid and node
    Boid current = boids.get(i);
    current.go(i);
  //  Node currentNode = node.get(i);
    graphNode.get(i).get(0).location.x = current.pos.x;
    graphNode.get(i).get(0).location.y = current.pos.y;
    //currentNode.location.x = current.pos.x;
    //currentNode.location.y = current.pos.y;
    
    current.draw();
  }

  /*for (int i = 0; i <avoids.size(); i++) {
    Avoid current = avoids.get(i);
    current.go();
    current.draw();
  }*/

  if (messageTimer > 0) {
    messageTimer -= 1; 
  }
  
 // drawGUI();
 //for(int i = 0; i<astar.size();i++){
   
 //  Node agent = graphNode.get(i).get(0);
 //  Astar temp = astar.get(i);
 //  ArrayList<Node> solution = temp.astar(agent, goal);
 //  if(solution != null){//if this particular agent found an optimal path to the goal
 //    print("here");
 //    for(int j = 0; j<solution.size();i++){
 //      Node a = solution.get(j);
 //      a.display();
     
     
 //    }
 //  }
   
   
 
 
 //}// atar loop

  //for(int i = 0; i<astar.size();i++){
  //  Astar current = astar.get(i);
  //  Node agentNode = node.get(i);
  //  print("agentNode neightbor: " + agentNode.edge.size() + " *************\n");
  //  ArrayList<Node> output = current.astar(agentNode,goal);
  //  if(output != null){
  //    for(int j = 0; j< output.size(); j++){
  //   //   output.get(j).showPath();
  //    }
    
  //  }
  //  result.add(output);
  
  //}
  //if(result != null){
  //  for(int i = 0;i<result.size();i++){
      
  //      if(result.get(i) != null){
  //          for(int j = 0; j<result.get(i).size();j++){
  //            result.get(i).get(j).showPath();
  //          }
        
  //      }
  //   }
  
  //}else{
  
   
  //}
  
  
  
  

}

void keyPressed () {
  //if( key == 'e'){
  //  tool = "erase";
  //  message("Eraser");
  
  
  //}
  if (key == 'q') {
    tool = "boids";
    message("Add boids");
  } else if (key == 'w') {
    tool = "avoids";
    message("Place obstacles");
  } else if (key == 'e') {
    tool = "erase";
    message("Eraser");
  } else if (key == '-') {
    message("Decreased scale");
    globalScale *= 0.8;
  } else if (key == '=') {
      message("Increased Scale");
    globalScale /= 0.8;
  } else if (key == '1') {
     option_friend = option_friend ? false : true;
     message("Turned friend allignment " + on(option_friend));
  } else if (key == '2') {
     option_crowd = option_crowd ? false : true;
     message("Turned crowding avoidance " + on(option_crowd));
  } else if (key == '3') {
     option_avoid = option_avoid ? false : true;
     message("Turned obstacle avoidance " + on(option_avoid));
  }else if (key == '4') {
     option_cohese = option_cohese ? false : true;
     message("Turned cohesion " + on(option_cohese));
  }else if (key == '5') {
     option_noise = option_noise ? false : true;
     message("Turned noise " + on(option_noise));
  } else if (key == ',') {
     //setupWalls(); 
  } else if (key == '.') {
     //setupCircle(); 
  }
  recalculateConstants();

}

void drawGUI() {
   if(messageTimer > 0) {
     fill((min(30, messageTimer) / 30.0) * 255.0);

    text(messageText, 10, height - 20); 
   }
   
  
}

String s(int count) {
  return (count != 1) ? "s" : "";
}

String on(boolean in) {
  return in ? "on" : "off"; 
}

void mousePressed () {
  //obstacle.add(new PVector(mouseX, mouseY));
  switch (tool) {
  
  case "boids":
  //  boids.add(new Boid(mouseX, mouseY));
    obstacle.add(new PVector(mouseX, mouseY));
    message(boids.size() + " Total Boid" + s(boids.size()));
    break;
  case "avoids":
    avoids.add(new Avoid(mouseX, mouseY));
    break;
  }
}

void erase () {
  for (int i = boids.size()-1; i > -1; i--) {
    Boid b = boids.get(i);
    if (abs(b.pos.x - mouseX) < eraseRadius && abs(b.pos.y - mouseY) < eraseRadius) {
      boids.remove(i);
    }
  }

  for (int i = avoids.size()-1; i > -1; i--) {
    Avoid b = avoids.get(i);
    if (abs(b.pos.x - mouseX) < eraseRadius && abs(b.pos.y - mouseY) < eraseRadius) {
      avoids.remove(i);
    }
  }
  for (int i = obstacle.size()-1; i > -1; i--) {
    PVector b = obstacle.get(i);
    if (abs(b.x - mouseX) < eraseRadius && abs(b.y - mouseY) < eraseRadius) {
      obstacle.remove(i);
    }
  }
  
}

void drawText (String s, float x, float y) {
  fill(0);
  text(s, x, y);
  fill(200);
  text(s, x-1, y-1);
}


void message (String in) {
   messageText = in;
   messageTimer = (int) frameRate * 3;
}
