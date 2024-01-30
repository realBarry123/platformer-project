

class Cannon extends Enemy{
  public Cannon(float _x, float _y){
    super(_x, _y, cannonSprite);
    setRestitution(0);
    setStaticBody(true);
    setFriction(1);
    setWidth(8*PIXEL);
  }
  
  public void update(){
    super.update();
    if (frameCount%100 == 0){
      for (int i = 0; i < 5; i ++){
        world.add(new Bullet(getX(), getY(), random(-200, 200), -600, false, 60));
      }
    }
    handleContacts();
  }
  
  private void handleContacts(){
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i ++){
      FContact contact = contacts.get(i);
      FBody body;
      if (contact.getBody1() instanceof Cannon){
        body = contact.getBody2();
      }else if (contact.getBody2() instanceof Cannon){
        body = contact.getBody1();
      }else{
        return;
      }
      
      if (body instanceof Bullet && ((Bullet)body).isGood){
        world.remove(body);
        world.remove(this);
        enemies.remove(this);
      }
    }
  }
}

class Bullet extends FBox{
  int lives;
  boolean isGood;
  public Bullet(float _x, float _y, float _vx, float _vy, boolean _good, int _lives){
    super(2*PIXEL, 2*PIXEL);
    setPosition(_x, _y);
    setVelocity(_vx, _vy);
    setFriction(0);
    setRestitution(1);
    lives = _lives;
    isGood = _good;
    if (isGood) attachImage(goodBulletSprite);
    else attachImage(bulletSprite);
  }
  public void update(){
    lives -= 1;
    if (lives <= 0 && getContacts().size() != 0){
      world.remove(this);
    }
  }
}
