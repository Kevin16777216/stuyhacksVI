public class Inventory{
  ArrayList<InvBox> inventory = new ArrayList<InvBox>();
  PVector InvShift = new PVector(50,60);
  int selected = 0;
  public Inventory(){
  }
  public void update(){
    noFill();
    strokeWeight(5);
    if (selected == 0){
      rect(InvShift.x - 5 + 10 * constants.blockWidth,InvShift.y - 6,constants.blockWidth+5,constants.blockWidth+5);
    }else{
      rect(InvShift.x - 5 + (selected - 1) * constants.blockWidth,InvShift.y - 6,constants.blockWidth+5,constants.blockWidth+5);
    }
    
    for(InvBox i : inventory){
      i.render();
    }
  }
  public void addItem(int ID, int Amount){
    for(InvBox box: inventory){
      if(box.ID == ID){
        box.addItem(ID,Amount);
        return;
      }
    }
     inventory.add(new InvBox(new PVector(InvShift.x + inventory.size() * (constants.blockWidth),InvShift.y),ID,Amount) );
  }
}