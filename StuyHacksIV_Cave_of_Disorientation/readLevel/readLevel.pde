 PImage myImage;
 PrintWriter output;
 int level;
void setup(){
  size(420, 490);
  level = 4;
  draw(level);
}
void draw(int Level){
    myImage = loadImage(Level+".png");
    output = createWriter(Level+".txt"); 
    image(myImage, 0, 0);
    for(int y = 0; y < 12;y++){
      for(int x = 0; x < 17; x++){
        color m = get(x,y);
        output.println(m);
      }
    }  
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit();
}