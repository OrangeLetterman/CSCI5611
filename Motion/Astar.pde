// Credit: The code is base on the pseudo code found in wikipedia 
import java.util.Map;
class Astar{
  
ArrayList<Node> graph;
ArrayList<Node> open;//the set of currently discovered node that has not evaluated yet
ArrayList<Node> close; //set of node already evaluated
HashMap<Node,Integer> gscore;
HashMap<Node,Integer> fscore;
//ArrayList<Node> cameFrom = new ArrayList<Node> ();
Astar(ArrayList<Node> node){
  graph = node;
 
}

int getLowestFscore(ArrayList<Node>  openList){

  int minfs = fscore.get(openList.get(0));
  int minIndex = 0;
  for(int i = 0; i<openList.size(); i++){
    Node temp = openList.get(i);
    int fs = fscore.get(temp);
    if(fs < minfs){
      minfs = fs;
      minIndex = i;
    }
  
  }
  return minIndex;

}

float heuristic_cost_estimate(Node start, Node goal){

  float a = start.location.x - goal.location.x; //<>//
  float b = start.location.y - goal.location.y;
  return sqrt(a*a + b*b);
}
boolean equals(Node a, Node b){
  int aIndex = graph.indexOf(a);
  int bIndex = graph.indexOf(b);
  return( aIndex == bIndex);
}

ArrayList<Node> reconstructPath(ArrayList<Node>  camefrom, Node current){
  ArrayList<Node> totalPath = new ArrayList<Node>();
 
  while(current.parent != null){
 //   Node previous = current;
    int currentIndex = camefrom.indexOf(current);
    current = camefrom.get(currentIndex).parent;
    totalPath.add(current);
  
  }
  return totalPath;
  
}

float distanceBetween(Node start, Node next){
  float a = start.location.x - next.location.x;
  float b = start.location.y - next.location.y;
  float distance = sqrt(a*a + b*b);
  return distance;
}

ArrayList<Node> astar(Node start, Node goal){
  
  // The set of nodes already evaluated
  close = new ArrayList<Node> ();
  
  // The set of currently discovered nodes that are not evaluated yet. 
  open = new ArrayList<Node> ();
  // Initially, only the start node is known.
  open.add(start);
  
  // For each node, which node it can most efficiently be reached from.
  // If a node can be reached from many nodes, cameFrom will eventually contain the most efficient previous step.
  ArrayList<Node>  cameFrom = new ArrayList<Node> ();
   
 // For each node, the cost of getting from the start node to that node.
  gscore = new HashMap<Node,Integer>();
  
  // set default value to infinity
  for(int i = 0; i< graph.size(); i++){
    Node v = graph.get(i);
    gscore.put(v, Integer.MAX_VALUE);
  
  }
  
  // The cost of going from start to start is zero.
  gscore.put(start, 0);
  
  // For each node, the total cost of getting from the start node to the goal
  // by passing by that node. That value is partly known, partly heuristic.
  fscore = new HashMap<Node,Integer>();
  // set default value to infinity
  for(int i = 0; i< graph.size(); i++){
    Node v = graph.get(i);
    fscore.put(v, Integer.MAX_VALUE);
  
  }
  
   // For the first node, that value is completely heuristic.
  fscore.put(start, (int)heuristic_cost_estimate(start,goal));

  while (open.size()>0){
    
    //current := the node in openSet having the lowest fScore[] value??
    int lowestFscoreIndex = getLowestFscore(open);
    Node current = open.get(lowestFscoreIndex);
    if(equals(current, goal)){
      return reconstructPath(cameFrom, goal);
    }
    
    open.remove(lowestFscoreIndex);
    close.add(current);
    
    for(int i = 0; i< current.edge.size(); i++){//loop through each neighbor vertex
      Node neighbor = current.edge.get(i);
      if(close.contains(neighbor)){
        
        continue; // ignore the neighbor node that has been evaluated
      }
      // The distance from start to a neighbor
      int tenetiveGScore = gscore.get(current) + (int)distanceBetween(current, neighbor);
      if(!(open.contains(neighbor))){
        open.add(neighbor);// Discover a new node
      }else if (tenetiveGScore >= gscore.get(neighbor)){
        continue;
      
      }
      
      // This path is the best until now. Record it!
     // cameFrom.put(neighbor, current);
       neighbor.parent = current;
       cameFrom.add(neighbor);
      gscore.put(neighbor, tenetiveGScore);
      int estimatedFScore = gscore.get(neighbor) +(int) heuristic_cost_estimate(neighbor, goal);
      fscore.put(neighbor, estimatedFScore);
    }//for 
  
  }// while
  return null;


}//astar









}
