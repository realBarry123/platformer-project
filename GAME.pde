
// block limit: 2000
FWorld world;

int level = 0;
int topMargin = 99;
int leftMargin = 99;

int money = 0;
int savedMoney = 0;

Player player;

ArrayList<FBody> changers = new ArrayList();
ArrayList<FBody> savedChangers = new ArrayList();

ArrayList<Enemy> enemies = new ArrayList();
ArrayList<Enemy> savedEnemies = new ArrayList();

Button quitButton = new Button(1120, 30, 80, 40, "QUIT");

void game(){
  world.step();
  pushMatrix();
  translate(-player.getX() + width/2, -player.getY() + height/2);
  world.draw();
  popMatrix();
  player.update();
  ArrayList<FBody> allBodies = world.getBodies();
  for (int i = 0; i < allBodies.size(); i++){
    FBody body = allBodies.get(i);
    if (body instanceof Sensor){
      ((Sensor)body).update();
    }
    else if (body instanceof Enemy){
      ((Enemy)body).update();
    }
    else if (body instanceof Bullet){
      ((Bullet)body).update();
    }
    else if (body instanceof Sand){
      ((Sand)body).update();
    }
  }
  fill(WHITE);
  textSize(32);
  textAlign(LEFT, CENTER);
  text("Money: " + money, 20, 30);
  for (int i = 0; i < player.maxLives; i ++){
    if (i < player.lives) image(playerSprite, 20 + 40 * i, 70, 9*PIXEL, 9*PIXEL);
    else image(playerDeadSprite, 20 + 40 * i, 70, 9*PIXEL, 9*PIXEL);
  }
  
  quitButton.render();
}

void loadGame(){
  if (loadImage("levels/" + level + ".png") == null){
    level = 0;
  }
  PImage map = loadImage("levels/" + level + ".png");
  world.clear();
  changers.clear();
  enemies.clear();
  println("loading level " + level);
  for (int i = 0; i < map.width; i ++){
    for (int j = 0; j < map.height; j ++){
      color pixel = map.get(i, j);
      float x = leftMargin + BLOCK_SIZE * i;
      float y = topMargin + BLOCK_SIZE * j;
      
      if (pixel == color(100, 50, 0)){
        if (j != 0 && map.get(i, j-1) != color(100, 50, 0) && map.get(i, j-1) != color(150, 200, 255) && map.get(i, j-1) != color(255, 0, 0)){
          world.add(new Block(x, y, grassSprite));
        }else{
          world.add(new Block(x, y, dirtSprite));
        }
      }
      else if (pixel == color(100, 100, 150)){
        if (random(0, 1) < 0.01){
          world.add(new Block(x, y, bricksAltSprite));
        }
        else if (random(0, 1) < 0.1){
          world.add(new Block(x, y, bricksCrackedSprite));
        }
        else{
          world.add(new Block(x, y, bricksSprite));
        }
      }
      else if (pixel == color(0, 0, 0)){
        world.add(new Bulk(x, y));
      }
      else if (pixel == color(0, 0, 255)){
        if (player == null){
          player = new Player(x, y);
          println("created player");
        }else{
          player.setPosition(x, y);
          println("repositioned player");
        }
        player.spawnX = x;
        player.spawnY = y;
        player.setVelocity(0,0);
        player.recover();
        player.regenerate();
        player.jumpHeight = 285;
        player.savedJumpHeight = player.jumpHeight;
        world.add(player);
        player.fooTimer = 60;
      }
      else if (pixel == color(150)){
        if (
          (map.get(i, j-1) == color(100, 50, 0) || map.get(i, j-1) == color(150, 200, 255)) || map.get(i, j-1) == color(0, 255, 0) || map.get(i, j-1) == color(100, 100, 150) && 
          map.get(i, j+1) == color(0, 0, 0, 0)
          ){
          world.add(new Spike(x, y, false));
        }else{
          world.add(new Spike(x, y, true));
        }
      }  
      else if (pixel == color(255, 0, 0)){
        world.add(new Lava(x, y));
      }  
      else if (pixel == color(255)){
        world.add(new End(x, y));
      }
      else if (pixel == color(150, 200, 255)){
        world.add(new Ice(x, y));
      }
      else if (pixel == color(255, 255, 0)){
        world.add(new Checkpoint(x, y));
      }
      else if (pixel == color(0, 255, 0)){
        world.add(new Slime(x, y));
      }
      else if (pixel == color(255, 200, 100)){
        enemies.add(new Sand(x, y));
      }
      else if (pixel == color(255, 200, 0)){
        changers.add(new Coin(x, y));
      }
      else if (pixel == color(255, 0, 255)){
        changers.add(new Gem(x, y));
      }
      else if (pixel == color(100, 0, 0)){
        enemies.add(new Goomba(x, y));
      }
      else if (pixel == color(0, 150, 100)){
        enemies.add(new Cannon(x, y));
      }
      else if (pixel == color(50, 50, 50)){
        enemies.add(new Thwomp(x, y));
      }
    }
  }
  
  savedChangers = new ArrayList(changers);
  for (int i = 0; i < changers.size(); i ++){
    world.add(changers.get(i));
  }
  
  savedEnemies = new ArrayList(enemies);
  for (int i = 0; i < enemies.size(); i ++){
    world.add(enemies.get(i));
  }
  savedMoney = money;
  player.savedJumpHeight = player.jumpHeight;
  player.onIce = false;
}
