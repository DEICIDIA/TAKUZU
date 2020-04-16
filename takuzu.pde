//DESIGN HORLOGE -> THE CODING TRAIN, CHAINE YOUTUBE, J'AIMAIS LE DESIGN DE L'HORLOGE+TRES BONNE EXPICATIONS.
Cell[][] cells = new Cell[8][8];
String fileName, ligne[], name, filename, tabSol[];
boolean game, clock, runOnce, help;
int milli, sec, min, x = 30, y = 30, tx = 150, ty = 50; //button
float secondes, minutes;
void setup() {
  fullScreen();
  selectInput("Sélectionnez la grille", "fileSelected");
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells.length; j++) {
      cells[i][j] = new Cell(i, j, 85) ; //INIT CELL
    }
  }
}
void draw() {
  if (game) { //game
    background(51); 
    end();
    load();
    help();
    disp();
    if (runOnce == false) {
      init();
      runOnce = true;
    }
    if (clock) {
      clock();
    }
  } else { //loading screen
    loadingScreen();
  }
}
//PARAMETRE DETECTION SOURIE SUR BOUTONS//
void mousePressed() {
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells.length; j++) {
      cells[i][j].contain();
    }
  }
  if (mouseX > width-180 && mouseX < width-180+tx && mouseY > y && mouseY < y+ty) {
    exit();
  }
  if (mouseX > width-180 && mouseX < width-180+tx && mouseY > y+200 && mouseY < y+200+ty) {
    verif();
    clock=false;
  }
  if (mouseX > width-180 && mouseX < width-180+tx && mouseY > y+100 && mouseY < y+100+ty) {
    retry();
  }
}
//INITIALISATION DES CELLULES//
void init() {
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells.length; j++) {
      cells[i][j].init();
    }
  }
}
//AFFICHAGE DES CELLULES//
void disp() {
  textSize(15);
  textAlign(LEFT);
  text("Same number of 0s and 1s in each row and each column. (1xx101 - 100101)", 8*90+60, height-100);
  text("More than two of the same number can't be adjacent. (xxx00x - xx1001)", 8*90+60, height-70);
  text("Each row and column is unique. (100101 1001xx - 100101 100110)", 8*90+60, height-40);
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells.length; j++) {
      cells[i][j].back();   
      cells[i][j].disp();
    }
  }
}
//BOUTON POUR QUITTER LE PROGRAMME//
void end() {
  if (mouseX > width-180 && mouseX < width-180+tx && mouseY > y && mouseY < y+ty) {
    fill(100, 255, 150);
  } else {
    fill(210);
  }
  stroke(0);
  textSize(30);
  textAlign(CENTER);
  rect(width-180, y, tx, ty);
  fill(255);
  text("END", width-90, y+35);
}
//BOUTON CHARGEMENT AUTRE GRILLE//
void load() {
  if (mouseX > width-180 && mouseX < width-180+tx && mouseY > y+100 && mouseY < y+100+ty) {
    fill(255, 100, 150);
  } else {
    fill(210);
  }
  stroke(0);
  textSize(30);
  textAlign(CENTER);
  rect(width-180, y+100, tx, ty);
  fill(255);
  text("NEW", width-90, y+35+100);
}
//BOUTON D'AIDE//
void help() {
  if (mouseX > width-180 && mouseX < width-180+tx && mouseY > y+200 && mouseY < y+200+ty) {
    fill(150, 100, 255);
  } else {
    fill(210);
  }
  stroke(0);
  textSize(30);
  textAlign(CENTER);
  rect(width-180, y+200, tx, ty);
  fill(255);
  text("VERIF", width-90, y+35+200);
}
//PARAMETRES BOUTON RETRY - REMISE A ZERO//
void retry() {
  game = false;
  runOnce = false;
  clock = false;
  milli = 0;
  sec = 0;
  min = 0;
  loadingScreen();
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells.length; j++) {
      cells[i][j] = null;
    }
  }
  setup();
}
void verif() {
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells.length; j++) {
      cells[i][j].verif();
    }
  }
}
//CELLULE//
class Cell {
  Boolean activated = true;
  Boolean good;
  int state, x, y, x1, y1, t;
  Cell(int posX, int posY, int taille) {
    x = posX;
    y = posY;
    t = taille;
    x1 = 90*x+30;
    y1 = 90*y+30;
  }
  void back() {
    strokeWeight(5);
    noStroke();
    textAlign(CENTER);
    textSize(26);
    rect( x1, y1, t, t);
  }
  void contain() {
    if (mouseX > x1  && mouseX < x1+t && mouseY > y1 && mouseY < y1+t) {
      if (activated == true) {
        state++; 
        clock=true;
      }
    }
  }
  void disp() {
    textAlign(CENTER);
    fill(255, 255, 255);
    if (state == 3) {
      state=0;
    }
    if (state == 1) {
      fill(150);
      rect(x1, y1, t, t);
      fill(255);
      text(state, x1+t/2, y1+t/2+13);
    }
    if (state == 0) {
      fill(100);
      rect(x1, y1, t, t);
      fill(255);
      text(state, x1+t/2, y1+t/2+13);
    }
    if (state == 2) {
      fill(200);
      rect(x1, y1, t, t);
    }
  }
  void init() {
    state = ligne[y+1].charAt(x)-'0';
    if (state == 1 || state == 0) {
      activated = false;
    }
  }
  void verif() {
    state = tabSol[y+1].charAt(x)-'0';
  }
}
//HORLOGE//
void clock() {
  if (millis()==millis()) {
    milli++;
  }
  if (milli%60==1) {
    sec++;
    if (sec==60) {
      sec=0;
      min++;
      if (min==60) {
        min=0;
      }
    }
  }
  noFill();
  strokeWeight(11);
  stroke(250);
  arc(width-400, 400, 300, 300, 0, 360);
  arc(width-400, 400, 250, 250, 0, 360);
  strokeWeight(7);
  secondes = map(sec, 0, 59, 0, TWO_PI)-HALF_PI;
  minutes = map(min, 0, 59, 0, TWO_PI)-HALF_PI;
  stroke(150, 100, 255);
  arc(width-400, 400, 250, 250, -HALF_PI, minutes);
  stroke(255, 100, 150);
  arc(width-400, 400, 300, 300, -HALF_PI, secondes); 
  textAlign(CENTER);
  fill(250);
  textSize(50);
  text(min+" : "+sec, width-400, 425);
  strokeWeight(5);
}
//SELECTION FICHIER JEU + FICHIER REPONSE//
void fileSelected(File selection) {
  if (selection != null) {
    fileName = selection.getAbsolutePath();
    ligne = loadStrings(fileName);
    StringBuilder filename =  new StringBuilder(fileName);
    filename.setCharAt(fileName.length()-3, 's');
    filename.setCharAt(fileName.length()-2, 'o');
    filename.setCharAt(fileName.length()-1, 'l');
    tabSol = loadStrings("" + filename);
    game = true;
  } else { 
    println("Window was closed or the user hit cancel.");
    exit();
  }
}
//ECRAN CHARGEMENT//
void loadingScreen() {
  background(51);
  textAlign(CENTER);
  fill(255);
  textSize(90);
  text("TAKUZU", width/2, 100);
}
