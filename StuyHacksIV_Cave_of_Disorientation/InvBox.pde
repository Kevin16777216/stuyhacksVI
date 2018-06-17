private class InvBox{
  PImage Item;
  int Amount = -1;
  int ID = -1;
  PVector Pos;
  PVector textShift = new PVector(constants.blockWidth *0.65,constants.blockWidth *0.7);
  public InvBox(PVector Pos){
    this.Pos = Pos;
  }
 public InvBox(PVector Pos,int ID,int Amount){
    this.Pos = Pos;
    this.ID = ID;
    this.Amount = Amount;
  }
  public void render(){
    fill(60,60,60,180);
    stroke(20,20,20);
    strokeWeight(5);
    rect(Pos.x,Pos.y,constants.blockWidth * 0.9,constants.blockWidth*0.9);
    image(images.get(4)[ID],Pos.x + 5,Pos.y + 5,constants.blockWidth * 0.9,constants.blockWidth*0.9);
    fill(0);
    addText();
  }
  public void addText(){
    text(Integer.toString(Amount),Pos.x+textShift.x, Pos.y + textShift.y,600,300);
  }
  public void addItem(int ID,int Amount){
    if(this.ID == -1){
      this.ID = ID;
      this.Amount = Amount;
    }else{
      this.Amount += Amount;
    }
  }
  public void removeItem(int Amount){
    if(ID != -1){
      this.Amount -= Amount;
      if(Amount <= 0){
        player.inv.inventory.remove(this);
        ID = -1;
        Amount = -1;
      }
    }
  }
}