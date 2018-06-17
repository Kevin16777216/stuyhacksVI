private class TileE extends Tile{
  int spawnID;
  
  public TileE(int ID,PVector location,boolean isSolid, int spawnID){
    super(ID,location,isSolid);
    this.spawnID =spawnID;
  }
  public void update(){
    if ((hitBox.isHit(player.hitBox) || current.frames <= 30) && current.Touch == 1){
      current.Touch = 2; 
      return;
    }
    if (hitBox.isHit(player.hitBox) && current.frames > 30 && current.Touch == 0){
      String[] data = loadStrings("/Rooms/readLevel/loading.txt");
      int i = 0;
      while(int(data[i].split(",")[0]) != current.ID){
        i++;
      }
      i+= spawnID;
      println(data[i]);
      PVector ne = new PVector(((width - (17 * constants.blockWidth)) / 2) + (int(data[i].split(",")[3]) * constants.blockWidth)+ 4 ,((height - (11 * constants.blockWidth)) / 2) +(int(data[i].split(",")[4])* constants.blockWidth + 5));
      changeLevel(int(data[i].split(",")[2]),ne);
    }
  }
}