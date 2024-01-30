
class Sand extends Enemy{
  /*
  private final int RESTING_TOP = 0;
  private final int FALLING = 0;
  private final int RESTING_BOTTOM = 0;
  
  int mode;
  */
  int fallTimer = -1;
  
  public Sand(float _x, float _y){
    super(_x, _y);
    setStatic(true);
    attachImage(sandSprite);
    setHeight(BLOCK_SIZE);
    setWidth(BLOCK_SIZE);
  }
  
  void update(){
    if (fallTimer == 0){
      setStatic(false);
    }
    fallTimer --;
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i ++){
      FContact contact = contacts.get(i);
      FBody body;
      if (contact.getBody1() instanceof Sand){
        body = contact.getBody2();
      }else if (contact.getBody2() instanceof Sand){
        body = contact.getBody1();
      }else{
        return;
      }
      
      if (body instanceof Player){
        if (fallTimer < 0){
          fallTimer = 10;
        }
      }
    }
  }
}
