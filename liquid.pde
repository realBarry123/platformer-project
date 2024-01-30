
class Liquid extends Sensor{
  
  float vMult;
  
  public Liquid(float _x, float _y){
    super(_x, _y, 10);
  }
  
  public void update(){
    super.update();
  }
  
  public void trigger(){
    super.trigger();
    player.setVelocity(getVelocityX() * vMult, getVelocityY() * vMult);
  }
}

class Lava extends Liquid{
  public Lava(float _x, float _y){
    super(_x, _y);
    attachImage(lavaSprite);
    vMult = 0.99;
    setHeight(6*PIXEL);
    setWidth(6*PIXEL);
  }
  
  public void update(){
    super.update();
  }
  
  public void trigger(){
    super.trigger();
    player.takeDamage(2);
  }
}
