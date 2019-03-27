class Node{
 PVector location;
 Node parent = null;
 ArrayList<Node> edge = new ArrayList<Node>();
 Node(PVector loc){
   location = loc;
 }
  
  void display() {
   
    fill(0, 191, 255);//change color
   
    //point(10,10);
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
  
    fill(255,69,0);//change color
     ellipse(location.x, location.y, 20, 20);
  }
  
  void showPath(){
      fill(34,139,34);//change color
      ellipse(location.x, location.y, 15, 15);
  }

}
