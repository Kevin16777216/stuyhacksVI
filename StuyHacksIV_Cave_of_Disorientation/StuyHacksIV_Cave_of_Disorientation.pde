ArrayList<PImage[]> images = new ArrayList<PImage[]>();
String[] Sections = {"Enemies","Tiles","UI","other"};
Level starting;
Level current;
PVector playerDimensions = new PVector(constants.blockWidth,constants.blockWidth* 1.618);
Player player;
boolean U,D,L,R = false;
void setup(){
  loadImageData();
  player = new Player(new PVector(width/2 - (playerDimensions.x /2),height/2 - (playerDimensions.y/2)),playerDimensions);
  starting = new Level(-1);
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
      if (path.toLowerCase().endsWith(".jpg")){
        println(path);
        folderImages[i] = loadImage(path);
      }
    }
    images.add(folderImages);
  }
}
public void keyPressed(){
   if(keyCode == UP){U = true;}
   if(keyCode == DOWN){D = true;}
   if(keyCode == LEFT){L = true;}
   if(keyCode == RIGHT){R = true;}
}
public void keyReleased(){
   if(keyCode == UP){U = false;}
   if(keyCode == DOWN){D = false;}
   if(keyCode == LEFT){L = false;}
   if(keyCode == RIGHT){R = false;}
}
public interface constants{
  int blockWidth = 80;
}