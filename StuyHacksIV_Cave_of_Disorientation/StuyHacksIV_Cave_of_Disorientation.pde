ArrayList<PImage[]> images = new ArrayList<PImage[]>();
String[] Sections = {"Enemies","Tiles","UI","other","Drops"};
Level starting;
static Level current;
float Tbuffer = (980 - (11 * constants.blockWidth)) / 2;
float Sbuffer = (1440 - (17 * constants.blockWidth)) / 2;
Hitbox top = new Hitbox(new PVector(0,0), new PVector(1440,Tbuffer));
Hitbox bottom = new Hitbox(new PVector(0,980 - Tbuffer), new PVector(1440,Tbuffer)); 
Hitbox left = new Hitbox(new PVector(0,0),new PVector(Sbuffer,980));
Hitbox right = new Hitbox(new PVector(1440 - Sbuffer,0),new PVector(Sbuffer,980));
PVector playerDimensions = new PVector(constants.blockWidth*0.7,constants.blockWidth* 0.7);
Player player;
boolean U,D,L,R = false;
int S = 1;
void setup(){
  loadImageData();
  player = new Player(new PVector(width/2 - (playerDimensions.x /2),height/2 - (playerDimensions.y/2)-80),playerDimensions);
  starting = new Level(0);
  current = starting;
  size(1440,980);
}
void draw(){
  clear();
  textSize(32);
  text(Integer.toString(current.ID),width/2,height - 20);
  current.update();
  player.update();
}
void changeLevel(int i, PVector Spawn){
  player.hitBox.TR = Spawn;
  player.hitBox.Center.x = player.hitBox.TR.x + (player.hitBox.Dimensions.x /2);
  player.hitBox.Center.y = player.hitBox.TR.y + (player.hitBox.Dimensions.y /2);
  if (player.deadFrames > 0){
      fill(255,0,0);
      rect(0,0,width,height);
  }
  current = new Level(i);
}
void loadImageData(){
  for (String j: Sections){
    File dir;
    File[] files;
    dir= new File(dataPath("/"+j+"/"));
    files= dir.listFiles();
    PImage[] folderImages = new PImage[files.length];
    for(int i =0;i <= files.length - 1; i++){
      String path = files[i].getAbsolutePath();
      if (path.toLowerCase().endsWith(".jpg")|| path.toLowerCase().endsWith(".png")){
        println(path);
        folderImages[i] = loadImage(path);
      }
    }
    images.add(folderImages);
  }
}
public void keyPressed(){
   if(key == ' '){player.launchSpear();}
   if(keyCode == UP|| key == 'w'){U = true;}
   if(keyCode == DOWN|| key == 's'){D = true;}
   if(keyCode == LEFT|| key == 'a'){L = true;}
   if(keyCode == RIGHT|| key == 'd'){R = true;}
}
public void keyReleased(){
   if(key == ' '){S = 2;}
   if(keyCode == UP || key == 'w'){U = false;}
   if(keyCode == DOWN || key == 's'){D = false;}
   if(keyCode == LEFT|| key == 'a'){L = false;}
   if(keyCode == RIGHT|| key == 'd'){R = false;}
}
public interface constants{
  int blockWidth = 80;
}
 public Tile[] getNearestTile(PVector n){
    ArrayList<Tile> nearest = new ArrayList<Tile>();
    float minDistance = 999999;
    for (Tile i : current.Tiles){
      PVector temp = PVector.sub(i.TR,n);
      if (temp.mag() <= minDistance){
        if(temp.mag() == minDistance){
          nearest.add(i);
          minDistance = temp.mag();
        }else{
          nearest.clear();
        }
      }
    }
    return nearest.toArray(new Tile[nearest.size()]);
  }