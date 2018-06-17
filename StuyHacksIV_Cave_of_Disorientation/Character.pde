public class Player{
  Hitbox hitBox;
  PShape body;
  PImage texture;
  Bar healthBar;
  int maxHealth = 100;
  int Health = 100;
  ArrayList<Spear> Spears = new ArrayList<Spear>();
  public Player(PVector TR,PVector Dimensions){
    hitBox = new Hitbox(TR,Dimensions);
    hitBox.isImportant = true;
    healthBar = new Bar(new PVector(hitBox.TR.x,hitBox.TR.y - 50),new PVector(60,20),maxHealth);
    try{
      loadTexture();
    }catch (Exception e){
    
    }
    setupSprite();
  }
  public void update(){
    readInput();
    setupSprite();
    shape(body);
    updateHealth();
    ArrayList<Spear> Removed = new ArrayList<Spear>();
    for(Spear i: Spears){
      i.update();
      for (Tile j: current.Tiles){
          if(i.Box.isHit(j.hitBox) && j.isSolid || i.Box.TR.x < 0 || i.Box.TR.x > width || i.Box.TR.y < 0 || i.Box.TR.y > height){
            Removed.add(i);
            break;
          }
      }
    }
    for (Spear i: Removed){
      Spears.remove(i);
      i = null;
    }
  }
  private void updateHealth(){
    healthBar.pos.x = hitBox.TR.x +10;
    healthBar.pos.y = hitBox.TR.y - 50;
    healthBar.updateValue(34);
    healthBar.render();
  }
  public void launchSpear(){
    if (Spears.size() < 5){
      Spears.add(new Spear(new PVector(hitBox.Center.x,hitBox.Center.y - 10),new PVector(mouseX,mouseY)));
    }
  }
  private void readInput(){
   if (U && !D){
     hitBox.Movement.y = -10;
   }else{
     if (D && !U){
       hitBox.Movement.y = 10;
     }else{
       hitBox.Movement.y = 0;
     }
   }
   if (L && !R){
     hitBox.Movement.x = -10;
   }else{
     if (R && !L){
       hitBox.Movement.x = 10;
     }else{
       hitBox.Movement.x = 0; 
     }
   }
   hitBox.applyMovement();
   boolean o = false;
   for (Tile i: current.Tiles){
     if (i.isSolid){
       o = hitBox.isHit(i.hitBox);
     }
   }
   o = hitBox.isHit(top);
   o = hitBox.isHit(bottom);
   o = hitBox.isHit(left);
   o = hitBox.isHit(right);
  }
  private void loadTexture(){
    texture = loadImage("player.jpg");
  }
  private void setupSprite(){
    body = createShape();
    body.beginShape();
    if (texture != null){
      body.texture(texture);
    }else{
    }
    body.fill(255);
    body.vertex(hitBox.TR.x,hitBox.TR.y);
    body.vertex(hitBox.TR.x + hitBox.Dimensions.x, hitBox.TR.y);
    body.vertex(hitBox.TR.x + hitBox.Dimensions.x, hitBox.TR.y + hitBox.Dimensions.y);
    body.vertex(hitBox.TR.x , hitBox.TR.y+hitBox.Dimensions.y);
    body.endShape(CLOSE);   
  }
}