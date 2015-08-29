import ipcapture.*;

IPCapture cam;
ArrayList<String> categoryFiles;
String currentCamURL;
String camURLsPath;
int currentCategoryNum = 0;
String currentCategoryName;
int currentURLNum = 0;

boolean thisCamCaptured = false;

void setup() {
  size(640,480);
  camURLsPath = dataPath("../../img_urls");
  java.io.File folder = new java.io.File(camURLsPath);
  String[] cam_categories = folder.list();
  categoryFiles = new ArrayList<String>();
  for (int i = 0; i < cam_categories.length; i++) {
    if(!cam_categories[i].equals(".DS_Store")){
      categoryFiles.add(cam_categories[i]);
    }
  }
  
  cam = new IPCapture(this, getNextCamURL(), "", "");
  cam.start();
  
}

String getNextCamURL(){
  String catFilename = categoryFiles.get(currentCategoryNum);
  currentCategoryName = split(catFilename, ".")[0];
  println(camURLsPath + "/" + catFilename);
  String[] camURLs = loadStrings(camURLsPath + "/" + catFilename);
  if(currentURLNum > camURLs.length - 1){
    currentCategoryNum++;
    catFilename = categoryFiles.get(currentCategoryNum);
    camURLs = loadStrings(camURLsPath + "/" + catFilename);
    currentURLNum = 0;
  }
  String result = camURLs[currentURLNum];
  thisCamCaptured = false;
    cam = new IPCapture(this, result, "", "");
      cam.start();
  println("next URL: " + result);
  currentURLNum++;
  return result;
}

void draw() {
  if (cam.isAvailable()) {
    println("reading cam...");
    cam.read();
    image(cam,0,0);
    if(!thisCamCaptured){
      saveCam();
      getNextCamURL();
      thisCamCaptured = true;
    }
  }
}

void saveCam(){
  println("saving...");
  PImage output = createImage(cam.width, cam.height, RGB);
  output.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
  output.save(dataPath("cams/" + currentCategoryName + "-" + (currentURLNum-1) + ".png"));

}

void keyPressed(){
  cam = new IPCapture(this, getNextCamURL(), "", "");
  cam.start();
}
