private class Hitbox{
  PVector TR;
  PVector Dimensions;
  PVector Center;
  PVector Movement = new PVector(0,0);
  boolean isImportant = false;
  public Hitbox(PVector TR, PVector Dimensions){
     this.TR = TR;
     this.Dimensions = Dimensions;
     Center = new PVector(TR.x + (Dimensions.x / 2),TR.y + (Dimensions.y / 2));
  }
  private boolean isHit(Hitbox other){
   if (other != this){
      if (TR.x <= (other.TR.x + other.Dimensions.x) &&
         TR.y <= (other.TR.y + other.Dimensions.y) &&
         (TR.x + Dimensions.x) >= other.TR.x   &&
         (TR.y + Dimensions.y) >= other.TR.y){
         float forceX;
         float forceY;
         if (isImportant){
           if (Center.x > other.Center.x){
             forceX = (other.TR.x + other.Dimensions.x) - TR.x ;
           }else{
             forceX = -((TR.x + Dimensions.x) - other.TR.x) ;
           }
           if (Center.y > other.Center.y){
             forceY = TR.y - (other.TR.y + other.Dimensions.y);
           }else{
             forceY = (TR.y + Dimensions.y) - other.TR.y ;
           }
           if (abs(forceX) < abs(forceY)){
               Movement.x = forceX;
               applyMovement();
               Movement.x = 0;
           }else{
               Movement.y = -forceY;
               applyMovement();
               Movement.y = 0;

           }
         }
         return true;
     }
   }
   return false;
  }
  private void applyMovement(){
    TR.add(Movement);
    Center.add(Movement);
  }
}