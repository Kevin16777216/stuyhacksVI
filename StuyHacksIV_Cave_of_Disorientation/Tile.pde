private class Tile{
  int textureID;
  PVector TR;
  PImage texture;
  PShape shape;
  boolean isSolid = false;
  boolean isHidden = false;
  public Hitbox hitBox;
  public Tile(int ID,PVector location,boolean isSolid){
    this.isSolid = isSolid;
    textureID = ID;
    TR = location;
    hitBox = new Hitbox(location,new PVector(constants.blockWidth,constants.blockWidth));
    try{
      getImage();
    }catch (Exception e){
      println(e);
    }
    setShape();
  }
  public void render(){
    if (!isHidden){
      shape(shape);
      image(texture,TR.x,TR.y);
    }
  }
  private void getImage(){
    texture = images.get(1)[textureID];
  }
  private void setShape(){
    shape = createShape();
    shape.beginShape();
    if (texture != null){
      texture(texture);
    }else{
    }
    shape.vertex(TR.x,TR.y);
    shape.vertex(TR.x + constants.blockWidth, TR.y);
    shape.vertex(TR.x + constants.blockWidth, TR.y + constants.blockWidth);
    shape.vertex(TR.x , TR.y+constants.blockWidth);
    shape.endShape(CLOSE);
    shape.setFill(isSolid ? color(200) : color(100));
  }
}