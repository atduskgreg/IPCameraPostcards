import ipcapture.*;

IPCapture cam;
ArrayList<String> categoryFiles;
String currentCamURL;
String camURLsPath;
int currentCategoryNum = 0;
int currentURLNum = 0;

void setup() {
  size(640,480);
  camURLsPath = dataPath("../../cam_urls");
  java.io.File folder = new java.io.File(camURLsPath);
  String[] cam_categories = folder.list();
  categoryFiles = new ArrayList<String>();
  for (int i = 0; i < cam_categories.length; i++) {
    categoryFiles.add(cam_categories[i]);
  }
  
  for(int i = 0; i < 20; i++){
    println(getNextCamURL());
  }
  
//  cam = new IPCapture(this, "http://3636782061:80/mjpg/video.mjpg", "", "");
//  cam.start();
}

String getNextCamURL(){
  String catFilename = categoryFiles.get(currentCategoryNum);
  String[] camURLs = loadStrings(camURLsPath + "/" + catFilename);
  if(currentURLNum > camURLs.length - 1){
    currentCategoryNum++;
    catFilename = categoryFiles.get(currentCategoryNum);
    camURLs = loadStrings(camURLsPath + "/" + catFilename);
    currentURLNum = 0;
  }
  String result = camURLs[currentURLNum];
  currentURLNum++;
  return result;
}




void draw(){}

//
//void draw() {
//  if (cam.isAvailable()) {
//    cam.read();
//    image(cam,0,0);
//  }
//}
//
//void keyPressed() {
//  if (key == ' ') {
//    if (cam.isAlive()) cam.stop();
//    else cam.start();
//  }
//}
