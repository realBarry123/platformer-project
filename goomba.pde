
class Goomba extends Enemy{
  float lastV;
  public Goomba(float _x, float _y){
    super(_x, _y, goombaSprite);
    setRestitution(0);
    velocity = 55;
    lastV = velocity;
    setFriction(0);
  }
  
  public void update(){
    super.update();
    if (round(getVelocityX()) != velocity){
      velocity = -velocity;
    }
    setVelocity(velocity, max(getVelocityY(), -450));
    handleContacts();
  }
  
  private void handleContacts(){
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i ++){
      FContact contact = contacts.get(i);
      FBody body;
      if (contact.getBody1() instanceof Goomba){
        body = contact.getBody2();
      }else if (contact.getBody2() instanceof Goomba){
        body = contact.getBody1();
      }else{
        return;
      }
      
      if (body instanceof Player){
        if (player.getY() < getY() - 2*PIXEL){
          player.setVelocity(-player.getVelocityX(), -500);
          world.remove(this);
          enemies.remove(this);
        }else{
          player.takeDamage(1);
        }
      }
      else if (body instanceof Bullet){
        world.remove(body);
        if (((Bullet)body).isGood){
          world.remove(this);
          enemies.remove(this);
        }
        else{
          setVelocity(getVelocityX(), -100);
        }
      }
    }
  }
}
