class Button {
  float x;
  float y;
  float wid;
  float hei;
  float padding = 0;
  String text;
  boolean isHover = false; 
  public Button(float _x, float _y, float _wid, float _hei, String _text){
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
    text = _text;
  }
  
  void render(){
    
    stroke(255*(padding/10)+127);
    strokeWeight(3);
    fill(BLACK);
    if (mouseX > x && mouseX < x+wid && mouseY > y && mouseY < y+hei){
      if (mousePressed){
        padding = max(padding-1, 0);
      }else{
        padding = min(padding+1, 5);
      }
      isHover = true;
    }else{
      isHover = false;
      padding = max(padding-1, 0);
    }
    rect(
      x - padding, 
      y - padding, 
      wid + (padding * 2), 
      hei + (padding * 2)
    );
    textAlign(CENTER, CENTER);
    textSize(25+padding/2);
    fill(255*(padding/25)+200);
    text(text, x + (wid/2), y + (hei/2) - 4);
  }
}
