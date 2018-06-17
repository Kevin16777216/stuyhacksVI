 PImage myImage;
 PrintWriter output;
 int level;
 color[] Colors = { color(181,230,29), 
                    color(255,255,255),
                    color(153,217,234),
                    color(63,72,204),
                    color(255,242,0),
                    color(239,228,176),
                    color(255,201,14),
                    color(255,127,39),
                    color(0,0,0),
                    color(127,127,127),
                    color(195,195,195),
                    color(185,122,87)
                    };
void setup(){
  size(420, 490);
  for (int i =0; i< 11; i++){ 
    level = i;
    drw(level);
  }
  exit();
  
}
void drw(int Level){
    myImage = loadImage("/gamemaps/"+Level+".png");
    String[] loading = loadStrings("loading.txt");
    output = createWriter(Level+".txt");
    output.println("<Entrances>");
    output.println("<Enemies>");
    output.println("<Tiles>");
    image(myImage, 0, 0);
    int ChangeCount = 0;
    for(int y = 0; y < 11;y++){
      for(int x = 0; x < 17; x++){
        color m = get(x,y);
        for(int i = 0; i < Colors.length; i++){
          if(Colors[i] == m){
            if (i == 0){
              int[] rocks = {0};
              output.println(rocks[int(random(rocks.length))]+","+Integer.toString(40+x*80)+","+Integer.toString(50+y*80)+","+"1");
            }else{
              if (2 <= i && i <=11 ){
                output.println(i+","+Integer.toString(40+x*80)+","+Integer.toString(50+y*80)+","+"0"+","+ChangeCount);
                ChangeCount++;
              }
              output.println(i+","+Integer.toString(40+x*80)+","+Integer.toString(50+y*80)+","+"0");
            }
          }
        }
      }
    }  
    output.println("<End>");
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  
}