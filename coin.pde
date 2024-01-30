
class Coin extends Sensor{
  public Coin(float _x, float _y){
    super(_x, _y, 60);
    setHeight(8*PIXEL);
    setWidth(8*PIXEL);
    attachImage(coinSprite);
  }
  public void trigger(){
    if (cooldown != 0) return;
    world.remove(this);
    changers.remove(this);
    money += 1;
    super.trigger();
  }
}

class Gem extends Sensor{
  public Gem(float _x, float _y){
    super(_x, _y, 60);
    setHeight(6*PIXEL);
    setWidth(6*PIXEL);
    attachImage(gemSprite);
  }
  public void trigger(){
    if (cooldown != 0) return;
    world.remove(this);
    changers.remove(this);
    player.jumpHeight += 65;
    super.trigger();
  }
}
