ArrayList<PImage[]> images = new ArrayList<PImage[]>();
String[] Sections = {"Enemies","Tiles","UI","other"};
Level starting;
Level current;
float Tbuffer = (980 - (11 * constants.blockWidth)) / 2;
float Sbuffer = (1440 - (17 * constants.blockWidth)) / 2;
Hitbox top = new Hitbox(new PVector(0,0), new PVector(1440,Tbuffer));
Hitbox bottom = new Hitbox(new PVector(0,980 - Tbuffer), new PVector(1440,Tbuffer)); 
Hitbox left = new Hitbox(new PVector(0,0),new PVector(Sbuffer,980));
Hitbox right = new Hitbox(new PVector(1440 - Sbuffer,0),new PVector(Sbuffer,980));
PVector playerDimensions = new PVector(constants.blockWidth*0.7,constants.blockWidth* 0.7);
Player player;
boolean U,D,L,R = false;
int S = 0;
void setup(){
  loadImageData();
  player = new Player(new PVector(width/2 - (playerDimensions.x /2),height/2 - (playerDimensions.y/2)-80),playerDimensions);
  starting = new Level(0);
  current = starting;
  size(1440,980);
}
void draw(){
  clear();
  current.update();
  player.update();
}
void changeLevel(int i, PVector Spawn){
  player.hitBox.TR = Spawn;
  player.hitBox.Center.x = player.hitBox.TR.x + (player.hitBox.Dimensions.x /2);
  player.hitBox.Center.y = player.hitBox.TR.y + (player.hitBox.Dimensions.y /2);
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
        folderImages[i] = loadImage(path);
      }
    }
    println(folderImages.length);
    images.add(folderImages);
  }
}
public void keyPressed(){
   if(key == ' '){S = 0;}
   if(keyCode == UP){U = true;}
   if(keyCode == DOWN){D = true;}
   if(keyCode == LEFT){L = true;}
   if(keyCode == RIGHT){R = true;}
}
public void keyReleased(){
   if(key == ' '){S = 2;}
   if(keyCode == UP){U = false;}
   if(keyCode == DOWN){D = false;}
   if(keyCode == LEFT){L = false;}
   if(keyCode == RIGHT){R = false;}
}
void mouseClicked(){
  player.launchSpear();
}
public interface constants{
  int blockWidth = 80;
}