public class Level{
  int ID;
  ArrayList<Integer> Spawns = new ArrayList<Integer>();
  ArrayList<PVector> Entrances = new ArrayList<PVector>(); //list of coordinates corresponding to Spawns.
  ArrayList<Enemy> Enemies = new ArrayList<Enemy>();
  ArrayList<Tile> Tiles = new ArrayList<Tile>();
  ArrayList<TileE> Teleporters = new ArrayList<TileE>();
  public Level(int ID){
    this.ID = ID;
    try{
      loadLevel();
    }catch (Exception e){
      println(e);
      setupDefault();
    }
  }
  public void update(){
    for(Tile i : Tiles){
      i.render();
    }
    for(TileE i : Teleporters){
      i.update();
    }
  }
  private void setupDefault(){
    int defHeight = 11;
    int defWidth = 17;
    for (int y = 0; y < defHeight;y++){
      for (int x = 0; x < defWidth; x++){
        Tiles.add(new Tile(1,new PVector(((width - (defWidth * constants.blockWidth)) / 2) + (x * constants.blockWidth) ,
                                         ((height - (defHeight * constants.blockWidth)) / 2) +(y* constants.blockWidth)),
                                         (x == 0 || x == defWidth - 1 || y == defHeight - 1)
                                         ));
      }
    }
  }
  public void loadLevel(){
    String[] rawData = loadStrings("/Rooms/readLevel/"+Integer.toString(ID)+".txt");
    int i = 0;
    while (!rawData[i].equals("<Entrances>")){
        Spawns.add(int(rawData[i]));
        i++;
    }
    i++;
    while (!rawData[i].equals("<Enemies>")){
        String[] temp = rawData[i].split(",");
        
        Entrances.add(new PVector(int(temp[0]),int(temp[1])));
        i++;
    }
    i++;
    while (!rawData[i].equals("<Tiles>")){
        String[] temp = rawData[i].split(",");
        Enemies.add(createEnemy(temp));
        i++;
    }
    i++;
    while (!rawData[i].equals("<Teleporters>")){
        String[] temp = rawData[i].split(",");
        Tiles.add(new Tile(int(temp[0]),new PVector(int(temp[1]),int(temp[2])),(temp[3].equals("1"))));
        i++;
    }
    i++;
    while (!rawData[i].equals("<End>")){
        String[] temp = rawData[i].split(",");
        Tiles.add(new TileE(int(temp[0]),new PVector(int(temp[1]),int(temp[2])),(temp[3].equals("1")),int(temp[4])));
        i++;
    }
  }
  private Enemy createEnemy(String[] data){
     switch (data[0]){
       case "S":
         break;
       case "R":
         break;
       default:
         return new Enemy();
     }
     return new Enemy();
  }
}