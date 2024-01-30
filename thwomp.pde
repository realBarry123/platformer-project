
class Thwomp extends Enemy{
  private final int RESTING_TOP = 0;
  private final int FALLING = 1;
  private final int RESTING_BOTTOM = 2;
  private final int RISING = 3;
  int mode;
  int bottomTimer;
  public Thwomp(float _x, float _y){
    super(_x + BLOCK_SIZE/2, _y + BLOCK_SIZE/2, thwompSprite);
    setHeight(2 * BLOCK_SIZE);
    setWidth(2 * BLOCK_SIZE);
    attachImage(thwompSprite[0]);
    mode = RESTING_TOP;
    setStatic(true);
    setRestitution(0);
    setDensity(100);
  }
  
  public void update(){
    bottomTimer --;
    if (bottomTimer == 0){
      toMode(RISING);
    }
    handleContacts();
    if (mode == RESTING_TOP){
      
    }
    else if (mode == FALLING){
      if (getVelocityY() == 0){
        toMode(RESTING_BOTTOM);
      }
    }
    else if (mode == RESTING_BOTTOM){
      
    }
    else if (mode == RISING){
      if (getVelocityY() == 0){
        toMode(RESTING_TOP);
      }
      setVelocity(0, -100);
    }
  }
  
  private void toMode(int _mode){
    mode = _mode;
    if (mode == RESTING_TOP){
      setStatic(true);
      attachImage(sprites[0]);
      setVelocity(0, 0);
    }
    else if (mode == FALLING){
      setVelocity(0, 200);
      setStatic(false);
      attachImage(sprites[1]);
    }
    else if (mode == RESTING_BOTTOM){
      bottomTimer = 60;
      setStatic(true);
      attachImage(sprites[1]);
      setVelocity(0, 0);
    }
    else if (mode == RISING){
      setStatic(false);
      setVelocity(0, -100);
      attachImage(sprites[0]);
    }
  }
  
  private void handleContacts(){
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i ++){
      FContact contact = contacts.get(i);
      FBody body;
      if (contact.getBody1() instanceof Thwomp){
        body = contact.getBody2();
      }else if (contact.getBody2() instanceof Thwomp){
        body = contact.getBody1();
      }else{
        return;
      }
      
      if (body instanceof Player){
        println(getVelocityY());
        if (player.getY() - getY() > BLOCK_SIZE && abs(player.getX() - getX()) < PIXEL*10){
          ((Player)body).takeDamage(5);
        }else if (getY() - player.getY() > BLOCK_SIZE  && abs(player.getX() - getX()) < PIXEL*10 && mode == RISING && round(getVelocityY()) == 0){
          ((Player)body).takeDamage(5);
        }
      }
    }
    if (mode == RESTING_TOP && abs(getX() - player.getX()) < BLOCK_SIZE * 1.5 && player.getY() > getY()){
      toMode(FALLING);
    }
  }
}
