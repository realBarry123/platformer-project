class Checkpoint extends Block{
  boolean on;
  public Checkpoint(float _x, float _y){
    super(_x, _y, checkpointOffSprite);
    on = false;
    setFriction(0.8);
  }
  public void turnOn(){
    on = true;
    attachImage(checkpointOnSprite);
  }
  public void turnOff(){
    on = false;
    attachImage(checkpointOffSprite);
  }
}
