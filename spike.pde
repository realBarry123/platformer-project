class Spike extends Block{
  public Spike(float _x, float _y, boolean _dir){
    super(_x, _y + BLOCK_SIZE * 0.25, spikeSprite);
    setHeight(BLOCK_SIZE*0.5);
    setWidth(BLOCK_SIZE*0.5);
    deadly = true;
    if (!_dir){
      setPosition(_x, _y - PIXEL*1);
      attachImage(spikeDownSprite);
    }
  }
}
