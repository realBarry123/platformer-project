
class Block extends FBox{
  
  public boolean deadly;
  
  public Block(float _x, float _y, PImage _image){
    super(BLOCK_SIZE, BLOCK_SIZE);
    setPosition(_x, _y);
    setStaticBody(true);
    setRestitution(0);
    setGrabbable(DEBUG);
    attachImage(_image);
    deadly = false;
    setFriction(1);
  }
  
  public Block(float _x, float _y){
    super(BLOCK_SIZE, BLOCK_SIZE);
    setPosition(_x, _y);
    setStatic(true);
    setRestitution(0);
    setGrabbable(DEBUG);
    deadly = false;
    setFriction(1);
  }
}

class Ice extends Block{
  public Ice(float _x, float _y){
    super(_x, _y);
    setFriction(0);
    attachImage(iceSprite);
  }
}

class Bulk extends Block{
  public Bulk(float _x, float _y){
    super(_x, _y);
    setHeight(3 * BLOCK_SIZE);
    setWidth(3 * BLOCK_SIZE);
    attachImage(dirtBulkSprite);
  }
}

class Slime extends Block {
  public Slime(float _x, float _y){
    super(_x, _y);
    attachImage(slimeSprite);
    setRestitution(1.3);
  }
}
