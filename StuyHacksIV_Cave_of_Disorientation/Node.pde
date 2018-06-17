public class Node {
  Tile self;
  boolean stopped = false;
  int iteration;
  Enemy main;
  Node parent;
  ArrayList<Node> child = new ArrayList<Node>();
  public Node(Tile e, Enemy main) {
    iteration = 0;
    this.main = main;
    self = e;
  }
  public Node(Enemy main) {
    this.main = main;
    iteration = 0;
  }
  public Node(Tile e, int iteration, Enemy main, Node parent) {
    self = e;
    this.main = main;
    this.parent = parent;
    this.iteration = iteration;
    if (this.self == main.target) {
      println("ok");
      ArrayList<Tile> pathT =new ArrayList<Tile>();
      ArrayList<Node> path = new ArrayList<Node>();
      path.add(this);
      pathT.add(self);
      path.add(parent);
      pathT.add(parent.self);
      for (int i = 1; i < iteration; i++) {
        path.add(path.get(i));
        pathT.add(path.get(i + 1).self);
        println(path.get(i + 1).self.TR);
      }
      main.moveList(pathT);
    }else{
      if (iteration < 7) {
        Tile[] g = main.getNearestTil(self.TR,self);
        println(g.length);
        println(mouseX +","+mouseY);
        for (Tile i : g) {
          if (iteration == 2){
          println(i.TR);
          println(self.TR);
          }
          if (i != self){addObject(i);}
        }
      }
    }
  }
  public void addObject(Tile e) {
    child.add(new Node(e, this.iteration + 1, main, this));
  }
}