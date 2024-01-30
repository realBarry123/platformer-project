
class Player extends FBox{
  
  int lives;
  int maxLives = 5;
  int damageCooldown;
  boolean injured;
  boolean foo;
  int fooTimer;
  boolean onIce;
  boolean inLiquid;
  float spawnX;
  float spawnY;
  float terminalV = 600;
  float jumpHeight = 285;
  float savedJumpHeight = jumpHeight;
  boolean facingRight;
  boolean canShoot = false;
  int shootCooldown;
  
  public Player(float _x, float _y){
    super(PIXEL*6, PIXEL*6);
    setPosition(_x, _y);
    attachImage(playerSprite);
    
    setDensity(0.1);
    setFriction(1);
    setRestitution(0);
    
    setGrabbable(DEBUG);
    lives = maxLives;
    damageCooldown = 30;
    
    setRotatable(false);
    
    foo = false;
    
    onIce = false;
    inLiquid = false;
    
    facingRight = true;
    
    shootCooldown = 0;
  }
  
  public void update(){
    
    
    //println(facingRight);
    handleMovement();
    
    setVelocity(min(getVelocityX(), terminalV), min(getVelocityY(), terminalV));
    
    handleContacts();
    
    
    fooTimer --;
    if (fooTimer == 0){
      foo = false;
    }
    
    damageCooldown --;
    if (damageCooldown <= 0 && injured){
      recover();
      if (lives <= 0){
        setAngularVelocity(random(-5, 5));
        setFriction(0);
        setRestitution(1);
        revive();
      }
    }
    
    shootCooldown --;
    if (spaceKey && canShoot) shoot();
  }
  
  private void handleMovement(){
    if (lives > 0){
      float relativeX = round(getX()%BLOCK_SIZE/PIXEL);
      float relativeY = round(getY()%BLOCK_SIZE/PIXEL);
      boolean onGround = getVelocityY() <= 5 && getVelocityY() >= -0.1 && relativeY == 2;
      boolean touchingLeftWall = relativeX == 8.0 && !onGround && getContacts().size() != 0;
      boolean touchingRightWall = relativeX == 2.0 && !onGround && getContacts().size() != 0;
      /*
      println("(" + relativeX + ", " + relativeY + ")");
      println("touchingLeftWall: " + touchingLeftWall);
      println("touchingRightWall: " + touchingRightWall);
      */
      
      if (aKey && !touchingLeftWall){
        if (!onIce && !inLiquid){
          setVelocity(-150, getVelocityY());
        }
        else{
          setVelocity(getVelocityX() - 10, getVelocityY());
        }
      }
      if (dKey && !touchingRightWall){
        if (!onIce && !inLiquid){
          setVelocity(150, getVelocityY());
        }
        else{
          setVelocity(getVelocityX() + 10, getVelocityY());
        }
      }
      if (canJump() && wKey){
        setVelocity(getVelocityX(), -jumpHeight);
        setFriction(0);
        return;
      }
      
      if ((relativeX == 2.0 || relativeX == 8.0) && !onGround){
        setFriction(0);
      }else{
        setFriction(1);
      }
      
    }
  }
  
  private boolean canJump(){
    
    /*
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i ++){
      FContact contact = contacts.get(i);
      FBody block;
      if (contact.getBody1() instanceof Block){
        block = contact.getBody1();
        if (getY() <= block.getY() && abs(getX()-block.getX()) < 0.5*PIXEL){
          return true;
        }
      }else if (contact.getBody2() instanceof Block){
        block = contact.getBody2();
        if (getY() <= block.getY() && abs(getX()-block.getX()) < PIXEL){
          return true;
        }
      }
    }
    return false;
    */
    
    float relativeX = round(getX()%BLOCK_SIZE/PIXEL);
    float relativeY = round(getY()%BLOCK_SIZE/PIXEL);
    boolean onGround = getVelocityY() <= 5 && getVelocityY() >= -0.1 && relativeY == 2;
    if (onGround || inLiquid){
      return true;
    }
    return false;
    
  }
  
  private void handleContacts(){
    ArrayList<FContact> contacts = getContacts();
    inLiquid = false;
    if (getVelocityY() <= 5 && getVelocityY() >= -0.1 && round(getY()%BLOCK_SIZE/PIXEL) == 2) onIce = false;
    for (int i = 0; i < contacts.size(); i ++){
      FContact contact = contacts.get(i);
      FBody body;
      if (contact.getBody1() instanceof Player){
        body = contact.getBody2();
      }else if (contact.getBody2() instanceof Player){
        body = contact.getBody1();
      }else{
        return;
      }
      
      if (body instanceof Block){
        if (((Block)body).deadly){
          takeDamage(1);
        }else if (body instanceof End && !foo){
          foo = true;
          println("level " + level + " completed");
          level += 1;
          loadGame();
        }else if (body instanceof Ice){
          onIce = true;
        }else if (body instanceof Checkpoint){
          ArrayList<FBody> allBodies = world.getBodies();
          for (int j = 0; j < allBodies.size(); j++){
            FBody thisBody = allBodies.get(j);
            if (thisBody instanceof Checkpoint){
              ((Checkpoint)thisBody).turnOff();
            }
          }
          ((Checkpoint)body).turnOn();
          spawnX = body.getX();
          spawnY = body.getY() - BLOCK_SIZE;
          savedMoney = money;
          savedJumpHeight = jumpHeight;
          
          savedChangers = new ArrayList(changers);
          //savedEnemies = new ArrayList(enemies);
        }
      }else if (body instanceof Sensor){
        ((Sensor)body).trigger();
        if (body instanceof Liquid){
          inLiquid = true;
        }
      }else if (body instanceof Bullet && !((Bullet)body).isGood){
        player.takeDamage(1);
      }
    }
  }
  
  public void takeDamage(int damage){
    println("player took damage");
    if (damageCooldown > 0) return;
    
    injured = true;
    damageCooldown = 30;
    lives -= damage;
    
    attachImage(playerDeadSprite);
  }
  
  public void recover(){
    println("recovering player");
    injured = false;
    attachImage(playerSprite);
    setRotation(0);
    setAngularVelocity(0);
    setRotatable(false);
    setFriction(1);
    setRestitution(0);
    damageCooldown = 30;
  }
  
  public void revive(){
    println("reviving player");
    setPosition(spawnX, spawnY);
    lives = maxLives;
    recover();
    
    money = savedMoney;
    jumpHeight = savedJumpHeight;
    for (int i = 0; i < changers.size(); i ++){
      world.remove(changers.get(i));
    }
    changers = new ArrayList(savedChangers);
    for (int i = 0; i < changers.size(); i ++){
      world.add(changers.get(i));
    }
    
    for (int i = 0; i < enemies.size(); i ++){
      world.remove(enemies.get(i));
    }
    enemies = new ArrayList(savedEnemies);
    for (int i = 0; i < enemies.size(); i ++){
      Enemy enemy = enemies.get(i);
      world.add(enemy);
      if (enemy instanceof Thwomp){
        ((Thwomp)enemy).toMode(0);
        ((Thwomp)enemy).bottomTimer = 0;
      }
      else if (enemy instanceof Sand){
        ((Sand)enemy).setStatic(true);
        ((Sand)enemy).fallTimer = -1;
      }
      
    }
    ArrayList<FBody> bodies = world.getBodies();
    for (int i = 0; i < bodies.size(); i ++){
      if (bodies.get(i) instanceof Bullet){
        world.remove(bodies.get(i));
      }
    }
  }
  
  public void regenerate(){
    lives = maxLives;
  }
  
  public void shoot(){
    if (shootCooldown > 0) return;
    shootCooldown = 20;
    if (facingRight){
      world.add(new Bullet(getX() + 2*PIXEL, getY(), 500, -50, true, 30));
      player.setVelocity(getVelocityX() - 5, getVelocityY() - 1);
    }
    else{
      world.add(new Bullet(getX() - 2*PIXEL, getY(), -500, -5, true, 30));
      player.setVelocity(getVelocityX() + 5, getVelocityY() - 1);
    }
  }
}
