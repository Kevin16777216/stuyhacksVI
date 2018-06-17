public class Inventory{
  ArrayList<InvBox> inventory = new ArrayList<InvBox>();
  PVector InvShift = new PVector(50,60);
  public Inventory(){
  }
  public void update(){
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
     inventory.add(new InvBox(new PVector(InvShift.x + inventory.size() * constants.blockWidth,InvShift.y),ID,Amount) );
  }
}