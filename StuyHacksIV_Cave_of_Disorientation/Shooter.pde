private class Shooter extends Enemy{
   ArrayList<Spear> Projectiles = new ArrayList<Spear>();
   PImage Spear;
   int Range,maxBullets,bulletID = 0;
   public Shooter(int maxHealth,PVector startPos,int ID,int Range, int maxBullets,int bulletID){
     super(maxHealth,startPos,ID);
     this.Range = Range;
     this.bulletID = bulletID;
     this.maxBullets = maxBullets;
   }
   public void update(){
     super.update();
     if(health!=0){
       if (int(random(speed)) == 0){
         int m = int(random(5)) +1;
         for(int i = 0; i < m; i++){
           shoot();
         }
       }
     ArrayList<Spear> toBeRemoved = new ArrayList<Spear>();
     for(Spear i: Projectiles){
      i.update();
        if(i.Box.isHit(player.hitBox)){
          player.getHit(i.damage);
          if(player.Health == 0){
            
          }
        }

      for (Tile j: current.Tiles){
          if(i.Box.isHit(j.hitBox) && j.isSolid || i.Box.TR.x < 0 || i.Box.TR.x > width || i.Box.TR.y < 0 || i.Box.TR.y > height){
            toBeRemoved.add(i);
            break;
          }
      }
      
    }
    for(Spear i : toBeRemoved){
      Projectiles.remove(i);
    }
     }
   }
   private void shoot(){
     if(Projectiles.size() < maxBullets){
     switch (Projectiles.size()){
       case 0:
         Projectiles.add(new Spear(new PVector(EBox.Center.x,EBox.Center.y - 10),new PVector(player.hitBox.Center.x,player.hitBox.Center.y),bulletID));
       case 1:
         Projectiles.add(new Spear(new PVector(EBox.Center.x,EBox.Center.y - 10),new PVector(player.hitBox.Center.x + player.hitBox.Movement.x,player.hitBox.Center.y),bulletID));
       case 2:
         Projectiles.add(new Spear(new PVector(EBox.Center.x,EBox.Center.y - 10),new PVector(player.hitBox.Center.x ,player.hitBox.Center.y + player.hitBox.Movement.y),bulletID));
       default:
        Projectiles.add(new Spear(new PVector(EBox.Center.x,EBox.Center.y - 10),new PVector(player.hitBox.Center.x,player.hitBox.Center.y),bulletID));
     }
     }
   }
   
}