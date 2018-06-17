private class Enemy{
  int health;
  int maxHealth;
  Bar healthBar;
  Hitbox EBox;
  PVector spawnPoint;
  PImage texture;
  PShape shape;
  int speed = 100;
  int ID;
  boolean isChasing;
  Tile target;
  int deadFrames = 0;
  public Enemy(int maxHealth,PVector startPos,int ID){
    this.maxHealth = maxHealth; 
    health = maxHealth;
    this.ID = ID;
    spawnPoint = startPos;
    EBox = new Hitbox(startPos,new PVector(constants.blockWidth,constants.blockWidth));
    this.maxHealth = maxHealth;
    healthBar = new Bar(new PVector(EBox.TR.x,EBox.TR.y - 50),new PVector(60,20),maxHealth);
    try{
        texture = images.get(0)[ID];
        texture.resize(constants.blockWidth,constants.blockWidth);
    }catch (Exception e){
    }
  }
  public void update(){
    updateShape();
    render();
    if(isChasing){
      getPath();
    }
  }
  public void render(){
    if (deadFrames > 0){
    if (deadFrames < 30){
      image(texture,EBox.TR.x,EBox.TR.y);
      if (health == 0){
        deadFrames++;
      }
    }
    }else{
        updateHealth();
        if(isChasing && EBox.isHit(player.hitBox)){
          player.getHit(10);
        }
        image(texture,EBox.TR.x,EBox.TR.y);
    }
    //shape(shape);
  }
  public void drawSpikey(){
    float inRadius = constants.blockWidth/1.5;
    for(int i = 0; i < 25; i++){
      if (i % 2 == 0){
         //line(Ebox.Center.x + cos((i/25)*360),Ebox.Center.x + cos((i/25)*360),Ebox.Center.x + cos((i/25)*360),Ebox.Center.x + cos((i/25)*360));
      }else{
      }
    }
  }
  private void updateHealth(){
    healthBar.pos.x = EBox.TR.x +10;
    healthBar.pos.y = EBox.TR.y - 50;
    healthBar.render();
  }
  public void getHit(int damage){
    health -= damage;
    if(health <0){
      health = 0;
      deadFrames++;
    }
    healthBar.updateValue(health);
  }
  private void updateShape(){
    shape = createShape();
    shape.beginShape();
    if (texture != null){
      shape.texture(texture);
    }else{
    }
    shape.fill(255);
    shape.vertex(EBox.TR.x,EBox.TR.y);
    shape.vertex(EBox.TR.x + EBox.Dimensions.x, EBox.TR.y);
    shape.vertex(EBox.TR.x + EBox.Dimensions.x, EBox.TR.y + EBox.Dimensions.y);
    shape.vertex(EBox.TR.x , EBox.TR.y+ EBox.Dimensions.y);
    shape.endShape(CLOSE);   
  }
  private void getPath(){
    Node main = new Node(this);
    target = getNearestTile(player.hitBox.TR)[0];
    Tile[] g = getNearestTile(EBox.TR);
    for(Tile i:g){
      main.addObject(i);
    }
  }
  private void moveList(ArrayList<Tile> pathT){
   if(pathT.size() > 1){
     try{
     PVector diff = PVector.sub(EBox.TR,pathT.get(0).TR);
     diff.div(8);
     diff.setMag(-0.1);
     EBox.TR.add(diff);
     EBox.Center.add(diff);
     }catch(Exception e){
     }
   }
  }
    public Tile[] getNearestTile(PVector n){
    ArrayList<Tile> nearest = new ArrayList<Tile>();
    float minDistance = 999999;
    for (Tile i : current.Tiles){
      PVector temp = PVector.sub(i.TR,n);
      if (temp.mag() <= minDistance ){
        if(temp.mag() == minDistance){
          nearest.add(i);
          minDistance = temp.mag();
        }else{
          nearest.clear();
          nearest.add(i);
          minDistance = temp.mag();
        }
      }
    }
    return nearest.toArray(new Tile[nearest.size()]);
  }
  public Tile[] getNearestTil(PVector n,Tile k){
    ArrayList<Tile> nearest = new ArrayList<Tile>();
    float minDistance = 999999;
    for (Tile i : current.Tiles){
      if (i != k){
      PVector temp = PVector.sub(i.TR,n);
      if (temp.mag() <= minDistance && !i.isSolid){
        if(abs(temp.mag() -minDistance) < 5){
          nearest.add(i);
          minDistance = temp.mag();
        }else{
          nearest.clear();
          nearest.add(i);
          minDistance = temp.mag();
        }
      }
      }
    }
    return nearest.toArray(new Tile[nearest.size()]);
  }
}