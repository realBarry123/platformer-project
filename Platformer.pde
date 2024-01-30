
// Barry Yu
// Nov 8, 2023
// Blue Square Adventures
// 643200,0000ff,969696,ff0000,ffffff,96c8ff,ffff00,00ff00,ffc800,ff00ff,640000,009664,323232,646496,ffc864

import fisica.*;
import java.util.ArrayList;

final int PIXEL = 3;
final int BLOCK_SIZE = PIXEL * 8;

// mode framework
final int LOADING = 0;
final int INTRO = 1;
final int GAME = 2;
int mode = LOADING;
int pendingMode = LOADING;

// colors
color BLACK = color(0, 0, 30);
color WHITE = color(255);

// fading
float crossFade = 0;
float dCrossFade = 0;

final boolean DEBUG = true;

void toMode(int _mode){
  if (mode == _mode || pendingMode == _mode) return;
  pendingMode = _mode;
  dCrossFade = 0.1;
}

void setup(){
  size(1280, 640);
  textAlign(CENTER, CENTER);
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
  frameRate(60);
}

void draw(){
  background(BLACK);
  crossFade = min(max(crossFade + dCrossFade, 0), 1);
  
  if (mode == LOADING) loading();
  else if (mode == INTRO) intro();
  else if (mode == GAME) game();
  
  if (crossFade >= 1){
    mode = pendingMode;
    dCrossFade = -0.1;
  }
  
  
  
  noStroke();
  fill(BLACK, crossFade * 255);
  rect(0, 0, width, height);
}

void drawPixelChecker(){
  fill(WHITE, 75);
  noStroke();
  for (int i = PIXEL; i < PIXEL*9; i += PIXEL){
    for (int j = PIXEL; j < PIXEL*9; j += PIXEL){
      if ((i + j) % (PIXEL*2) == 0){
        rect(round(mouseX/PIXEL)*PIXEL-i, round(mouseY/PIXEL)*PIXEL-j, PIXEL, PIXEL);
      }
    }
  }
}
