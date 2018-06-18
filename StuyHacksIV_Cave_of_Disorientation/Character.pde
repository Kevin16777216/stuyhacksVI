public class Player{
  Hitbox hitBox;
  PShape body;
  int speed = 5;
  PImage texture;
  Bar healthBar;
  int maxHealth = 10000;
  int deadFrames = 0;
  int Frames = 0;
  Inventory inv = new Inventory();
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
    Frames++;
    inv.update();
    setupSprite();
    //image(texture,hitBox.TR.x,hitBox.TR.y,hitBox.Dimensions.x,hitBox.Dimensions.y);
    //shape(body);
    fill(66,197,244);
    ellipseMode(RADIUS);
    stroke(66,197,244);
    noFill();
    strokeWeight(5);
    float shift = (Frames*4%180);
    arc(hitBox.Center.x,hitBox.Center.y,(hitBox.Dimensions.x *(0.5)),(hitBox.Dimensions.y *(0.5)),radians(shift), 2+radians(shift));
    arc(hitBox.Center.x,hitBox.Center.y,(hitBox.Dimensions.x *(0.5)),(hitBox.Dimensions.y *(0.5)),PI+radians(shift), 2 + PI + radians(shift));
    stroke(244,143,66);
    arc(hitBox.Center.x,hitBox.Center.y,(hitBox.Dimensions.x *(0.4)),(hitBox.Dimensions.y *(0.4)),radians(shift)-2, radians(shift));
    arc(hitBox.Center.x,hitBox.Center.y,(hitBox.Dimensions.x *(0.4)),(hitBox.Dimensions.y *(0.4)),PI+radians(shift)-2,  PI + radians(shift));
    fill(255);
    ellipse(hitBox.Center.x,hitBox.Center.y,(hitBox.Dimensions.x *(0.4)),(hitBox.Dimensions.y *(0.4)));
    strokeWeight(10);
    PVector diff = PVector.sub(hitBox.Center,new PVector(mouseX,mouseY));
    diff.div(8);
    diff.setMag(16);
    line(hitBox.Center.x,hitBox.Center.y,hitBox.Center.x - diff.x,hitBox.Center.y - diff.y);
    updateHealth();
    Health += 4;
    ArrayList<Spear> Removed = new ArrayList<Spear>();
    for(Spear i: Spears){
      i.update();
      ArrayList<Enemy> toBeRemoved = new ArrayList<Enemy>();
      for(Enemy p: current.Enemies){
        if(i.Box.isHit(p.EBox)){
          p.getHit(i.damage);
          if(p.health == 0 && p.deadFrames < 1){
            int k = int(random(0,3));
            int s = int(random(1,3));
            inv.addItem(k,s);
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
    if(Health > maxHealth){
      Health = maxHealth;
    }
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
      PVector back = PVector.sub(new PVector(mouseX,mouseY),new PVector(hitBox.Center.x - 10,hitBox.Center.y - 10));
      back.div(-8);
      back.setMag(10);
      hitBox.TR.add(back);
      hitBox.Center.add(back);
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