Button startButton = new Button(560, 400, 160, 40, "PLAY");

void intro(){
  fill(WHITE);
  textSize(36);
  text("Blue Square Adventures", 640, 260);
  textSize(28);
  text("current level: " + level, 640, 320);
  startButton.render();
}
