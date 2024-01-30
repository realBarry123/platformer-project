
class Sensor extends FBox{
  
  int cooldown;
  int cooldownDuration;
  
  public Sensor(float _x, float _y, int _cooldown){
    super(BLOCK_SIZE, BLOCK_SIZE);
    setPosition(_x, _y);
    setGrabbable(DEBUG);
    setStaticBody(true);
    setRestitution(0);
    setSensor(true);
    cooldownDuration = _cooldown;
  }
  
  public void update(){
    if (cooldown > 0){
      cooldown -= 1;
    }
  }
  
  public void trigger(){
    cooldown = cooldownDuration;
  }
}
