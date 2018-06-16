private class TileE extends Tile{
  int spawnID;
  public TileE(int ID,PVector location,boolean isSolid, int spawnID){
    super(ID,location,isSolid);
  }
  public void update(){
    if (hitBox.isHit(player.hitBox)){
      changeLevel(current.Spawns.get(spawnID),current.Entrances.get(spawnID));
    }
  }
}