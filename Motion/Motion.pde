
int numberofNode = 100;
ArrayList<Node> graphNode = new ArrayList<Node>();
//2 int list for open and close node 
ArrayList<Node> result = new ArrayList<Node>();
 Node start ;
  Node goal ;
void setup() {
 size(700,700, P3D);
 int counter = 0;
 
 start = new Node(new PVector(10,height - 10));
// start.changeColor();
 graphNode.add(start); //start node
 goal = new Node(new PVector(width - 10,10));
 //goal.changeColor();
 graphNode.add(goal); //start node
 while (counter < 98){
   float x = random(700);
   float y = random(700);
   float distance = getDistance(x, y, 400, 400);//check the distance between obstacle 
   if(distance < 100){ //check if it collide with obstacle 
     //dont add node on this location
   }else{
     graphNode.add(new Node(new PVector(x, y))); 
     counter++;
   }
   
 }
 
 
}
void draw() {
  background(255,255,255);
   fill(0, 191, 255);//change color
  ellipse(400, 400, 200, 200);
  for(int i = 0; i< 98; i++){
    Node temp = graphNode.get(i);
      
      temp.display();
  }
  
  
  for(int i = 0; i<100; i++){
    for(int j = 0; j< 100; j++){
      Node a = graphNode.get(i);
      Node b = graphNode.get(j);
      float distance = getDistance(a.location.x, a.location.y, b.location.x, b.location.y);
       if (distance < 120 && i != j){
        stroke(126);
        a.addEdge(b);
        float x1 = a.location.x;
        float y1 = a.location.y;
        float x2 = b.location.x;
        float y2 = b.location.y;
        line(x1, y1, x2, y2);
      }
    
    }
    
  }// for
  start.changeColor();
  goal.changeColor();
  
  Astar a = new Astar(graphNode);
  result = a.astar(start, goal);
  if(result != null){
     displayResult(result);
  }
  //<>//
  

}// draw 

void displayResult(ArrayList<Node> result){
  //print("size: " + result.size());
  for(int i = 0; i< result.size(); i++){
    result.get(i).showPath();
  }
  goal.showPath();
  
}

float getDistance(float x, float y, float xx, float yy){
  float a = x - xx;
  float b = y - yy;
  float distance = sqrt(a*a + b*b);
  return distance;
}
