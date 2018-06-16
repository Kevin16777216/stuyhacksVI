private class TileE extends Tile{
  int spawnID;
  
  public TileE(int ID,PVector location,boolean isSolid, int spawnID){
    super(ID,location,isSolid);
  }
  public void update(){
    if (hitBox.isHit(player.hitBox)){
      String[] data = loadStrings("/Rooms/readLevel/loading.txt");
      int i = 0;
      while(int(data[i].split(",")[0]) != current.ID){
        i++;
      }
      i+= spawnID;
      println(data[i]);
      //changeLevel(current.Spawns.get(spawnID),current.Entrances.get(spawnID));
    }
  }
}