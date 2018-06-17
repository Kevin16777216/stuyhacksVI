public class Player{
  Hitbox hitBox;
  PShape body;
  int speed = 5;
  PImage texture;
  Bar healthBar;
  int maxHealth = 10000;
  int deadFrames = 0;
  int Health = 10000;
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
    image(texture,hitBox.TR.x,hitBox.TR.y,hitBox.Dimensions.x,hitBox.Dimensions.y);
    //shape(body);
    updateHealth();
    Health += 4;
    ArrayList<Spear> Removed = new ArrayList<Spear>();
    for(Spear i: Spears){
      i.update();
      ArrayList<Enemy> toBeRemoved = new ArrayList<Enemy>();
      for(Enemy p: current.Enemies){
        if(i.Box.isHit(p.EBox)){
          p.getHit(i.damage);
          if(p.health == 0){
            toBeRemoved.add(p);
          }
        }
      }
      for(Enemy p: toBeRemoved){
        p = null;
        Health += 10;
        if(Health > maxHealth){
          Health = maxHealth;
        }
        current.Enemies.remove(p);
      }
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
    healthBar.pos.x = hitBox.TR.x +5;
    healthBar.pos.y = hitBox.TR.y - 50;
    healthBar.render();
    if (Health <= 0){
      changeLevel(0,new PVector(width/2 - (playerDimensions.x /2),height/2 - (playerDimensions.y/2)-80));
      Health = maxHealth;
    }
  }
  public void getHit(int damage){
    Health -= damage;
    if(Health <0){
      Health = 0;
      deadFrames++;
    }
    healthBar.updateValue(Health);
  }
  public void launchSpear(){
    if (Spears.size() < 5){
      Spears.add(new Spear(new PVector(hitBox.Center.x - 10,hitBox.Center.y - 10),new PVector(mouseX,mouseY),-1));
    }
  }
  private void readInput(){
   if (U && !D){
     hitBox.Movement.y = -speed;
   }else{
     if (D && !U){
       hitBox.Movement.y = speed;
     }else{
       hitBox.Movement.y = 0;
     }
   }
   if (L && !R){
     hitBox.Movement.x = -speed;
   }else{
     if (R && !L){
       hitBox.Movement.x = speed;
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