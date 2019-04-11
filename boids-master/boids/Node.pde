class Node{
 PVector location;
 Node parent = null;
 ArrayList<Node> edge = new ArrayList<Node>();
 Node(PVector loc){
   location = loc;
 }
  
  void display() {
   
    fill(30,255,100);//change color
   
    //point(10,10);
    stroke(50);
    ellipse(location.x, location.y, 15, 15);
  
  }
  void addEdge(Node e){
    for (Node temp: edge) {
      if (temp == e) {
        return;
      }
    }
    edge.add(e);
    //print("edge is add \n");
  }
    
  
  void changeColor(){
      pushMatrix();
    fill(255,69,0);//change color
     ellipse(location.x, location.y, 20, 20);
     popMatrix();
  }
  
  void showPath(){
    pushMatrix();
      fill(255,69,0);//change color
      ellipse(location.x, location.y, 15, 15);
      popMatrix();
  }

}
