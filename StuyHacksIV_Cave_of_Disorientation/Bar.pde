private class Bar{//foo
  PVector pos;
  PVector Dimensions;
  color full = color (0,255,0);
  color empty = color(255,0,0);
  color border = 55;
  float max;
  float value;
  public Bar(PVector pos, PVector Dimensions, float max){
    this.max = max;
    this.pos = pos;
    this.Dimensions = Dimensions;
    value = max;
  }
  public void render(){
    fill(empty);
    stroke(border);
    strokeWeight(5);
    rect(pos.x,pos.y, Dimensions.x,Dimensions.y);
    fill(full);
    rect(pos.x,pos.y, Dimensions.x * (value /max),Dimensions.y);
    strokeWeight(1);
  }
  public void updateValue(float value){
    this.value = value;
  }
  
}