class Enemy extends FBox{
  int lives;
  int velocity;
  PImage[] sprites;
  public Enemy(float _x, float _y, PImage[] _sprite){
    super(PIXEL*6, PIXEL*6);
    setPosition(_x, _y);
    attachImage(_sprite[0]);
    sprites = _sprite;
    
    setDensity(0.1);
    setFriction(1);
    setRestitution(0);
    
    setGrabbable(DEBUG);
    
    setRotatable(false);
  }
  public Enemy(float _x, float _y){
    super(PIXEL*6, PIXEL*6);
    setPosition(_x, _y);
    
    setDensity(0.1);
    setFriction(1);
    setRestitution(0);
    
    setGrabbable(DEBUG);
    
    setRotatable(false);
  }
  
  public void update(){
    if (frameCount % 20 == 0){
      attachImage(sprites[(frameCount/20)%sprites.length]);
    }
  }
  
  private void handleContacts(){
    
  }
  
  public void takeDamage(){
    lives -= 1;
    if (lives <= 0) die();
   }
   
  public void die(){
    world.remove(this);
    enemies.remove(this);
  }
}
