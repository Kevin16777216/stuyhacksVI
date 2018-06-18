public class Level{
  int ID;
  int frames = 0;
  int framekill = 400;
  ArrayList<Enemy> Enemies = new ArrayList<Enemy>();
  ArrayList<Tile> Tiles = new ArrayList<Tile>();
  ArrayList<TileE> Teleporters = new ArrayList<TileE>();
  int Touch = 2;
  public Level(int ID){
    this.ID = ID;
    try{
      loadLevel();
    }catch (Exception e){
      println(e);
      setupDefault();
    }
    setupEnemies();
  }
  public void update(){
    if (Touch == 2){
      Touch = 1;
    }
    strokeWeight(30);
    stroke(255);
    line(30,25,width-30,25);
    strokeWeight(30);
    stroke(255*(frames/framekill),255*(1-(frames/framekill)),0);
    line(30,25,width-30-((width-60)* frames/framekill),25);
    for(Tile i : Tiles){
      i.render();
    }
    for(TileE i : Teleporters){
      i.update();
    }
    for(Enemy i:Enemies){
      i.update();
    }
    if (frames > framekill){
      fill(255,0,0);
      rect(0,0,width,height);
      player.Health = 0;
    }
    PImage crosshair = images.get(3)[2];
    crosshair.resize(40,40);
    image(crosshair,mouseX - 20,mouseY - 20);
    if (Touch == 1){
      Touch = 0;
    }
    frames++;
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
    while (!rawData[i].equals("<End>")){
        String[] temp = rawData[i].split(",");
        if(temp.length > 4){
          Teleporters.add(new TileE(int(temp[0]),new PVector(int(temp[1]),int(temp[2])),(temp[3].equals("1")),int(temp[4])));
        }else{
          Tiles.add(new Tile(int(temp[0]),new PVector(int(temp[1]),int(temp[2])),(temp[3].equals("1"))));
        }
        i++;
    }
  }
  private void setupEnemies(){
    int amount = int(random(3)) + 1;
    for (int i = 0; i < amount; i++){
      Tile p = Tiles.get(int(random(Tiles.size())));
      while(p.isSolid || p instanceof TileE ){
        p = Tiles.get(int(random(Tiles.size())));
      }
      int type = int(random(3));
      Enemy m;
      switch(type){
        case 0:
          m = new Shooter(100,new PVector(p.TR.x,p.TR.y),0,5,9,0);
          m.isChasing = true;
          break;
        case 1:
          m = new Shooter(100,new PVector(p.TR.x,p.TR.y),1,5,20,-1);
          m.isChasing = false;
          m.speed = 10;
          break;
        case 2:
          m = new Enemy(100,new PVector(p.TR.x,p.TR.y),2);
          m.isChasing = true;
          break;
        default:
          m = new Enemy(100,new PVector(p.TR.x,p.TR.y),2);
      }
      Enemies.add(m);
      //p.spawnEnemy(int(random(5)));
      
    }
  }
  private Enemy createEnemy(String[] data){
     switch (data[0]){
       case "S":
         break;
       case "R":
         break;
       default:
         return new Enemy(100,new PVector(width/2,height/2),0);
     }
     return new Enemy(100,new PVector(width/2,height/2),0);
  }
}