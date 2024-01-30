
boolean wKey = false;
boolean aKey = false;
boolean sKey = false;
boolean dKey = false;
boolean spaceKey = false;

void mouseReleased(){
  if (mode == INTRO){
    if (startButton.isHover){
      toMode(GAME);
      loadGame();
    }
  }else if (mode == GAME){
    if (quitButton.isHover){
      toMode(INTRO);
    }
  }
}

void keyPressed(){
  if (key == 'w' || keyCode == UP) wKey = true;
  if (key == 'a' || keyCode == LEFT) {aKey = true; player.facingRight = false;}
  if (key == 's' || keyCode == DOWN) sKey = true; 
  if (key == 'd' || keyCode == RIGHT) {dKey = true; player.facingRight = true;}
  if (key == ' ') spaceKey = true;
}

void keyReleased(){
  if (key == 'w' || keyCode == UP) wKey = false;
  if (key == 'a' || keyCode == LEFT) aKey = false;
  if (key == 's' || keyCode == DOWN) sKey = false;
  if (key == 'd' || keyCode == RIGHT) dKey = false;
  if (key == 'r') player.revive();
  if (key == ' ') spaceKey = false;
}
