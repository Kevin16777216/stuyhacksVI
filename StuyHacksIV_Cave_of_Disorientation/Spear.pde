private class Spear{
  Hitbox Box;
  PVector target;
  PImage image;
  PVector shift;
  public Spear(PVector Pos,PVector target){
    image = images.get(3)[0];
    Box = new Hitbox(Pos,new PVector (30,30));
    this.target = target;
    shift = new PVector((target.x-Pos.x),(target.y-Pos.y));
    shift.setMag(10);
    render();
  }
  private void update(){
    Box.TR.add(shift);
    render();
  }
  public void render(){
    pushMatrix();
    image(image,Box.TR.x,Box.TR.y,30,30);
    popMatrix();
  }
}