
PImage dirtSprite;
PImage dirtBulkSprite;
PImage grassSprite;
PImage playerSprite;
PImage playerDeadSprite;
PImage spikeSprite;
PImage spikeDownSprite;
PImage lavaSprite;
PImage iceSprite;
PImage checkpointOnSprite;
PImage checkpointOffSprite;
PImage slimeSprite;
PImage coinSprite;
PImage gemSprite;
PImage[] goombaSprite = new PImage[4];
PImage[] cannonSprite = new PImage[2];
PImage[] thwompSprite = new PImage[2];
PImage bulletSprite;
PImage goodBulletSprite;
PImage bricksSprite;
PImage bricksAltSprite;
PImage bricksCrackedSprite;
PImage sandSprite;
PFont mono;

void loading(){
  fill(WHITE);
  textSize(20);
  text("Loading", width/2, height/2);
  dirtSprite = loadImage("sprites/dirt.png");
  dirtBulkSprite = loadImage("sprites/dirt-bulk.png");
  grassSprite = loadImage("sprites/grass.png");
  playerSprite = loadImage("sprites/player.png");
  playerDeadSprite = loadImage("sprites/player-dead.png");
  spikeSprite = loadImage("sprites/spike.png");
  spikeDownSprite = loadImage("sprites/spike-down.png");
  lavaSprite = loadImage("sprites/lava.png");
  iceSprite = loadImage("sprites/ice.png");
  checkpointOnSprite = loadImage("sprites/checkpoint.png");
  checkpointOffSprite = loadImage("sprites/checkpoint-off.png");
  slimeSprite = loadImage("sprites/slime.png");
  coinSprite = loadImage("sprites/coin.png");
  gemSprite = loadImage("sprites/gem.png");
  bulletSprite = loadImage("sprites/bullet.png");
  goodBulletSprite = loadImage("sprites/good-bullet.png");
  bricksSprite = loadImage("sprites/bricks.png");
  bricksAltSprite = loadImage("sprites/bricks-alt.png");
  bricksCrackedSprite = loadImage("sprites/bricks-cracked.png");
  sandSprite = loadImage("sprites/sand.png");
  for (int i = 0; i < 4; i ++){
    goombaSprite[i] = loadImage("sprites/goomba/" + i + ".png");
  }
  for (int i = 0; i < 2; i ++){
    cannonSprite[i] = loadImage("sprites/cannon/" + i + ".png");
  }
  thwompSprite[0] = loadImage("sprites/thwomp/rest.png");
  thwompSprite[1] = loadImage("sprites/thwomp/active.png");
  mono = createFont("JetBrainsMono-Regular.ttf", 1);
  textFont(mono);
  toMode(INTRO);
}
