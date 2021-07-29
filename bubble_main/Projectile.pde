//projectile for player
class Projectile {
  Bubble avatar;
  String tag;
  private int life;
  private int power;
  private int reward;
  
  Projectile(Bubble b, String tag) {
    avatar = b;
    this.tag = tag;
    this.life = 1;
    this.power = 1;
    this.reward = 10;
  }
  
 //----------BEGIN GET METHODS---------------------

  int getId() {
    return avatar.id;
  }
  
  boolean isBroken() {
    return avatar.status == Helper.BROKEN;
  }
  
  boolean isOutOfRange() {
    return avatar.status == Helper.OUT_RANGE;
  }
  
  String getTag() {
    return tag;
  }
  
  float getX() {
    return avatar.x;
  }
  
  float getY() {
    return avatar.y;
  }
  
  float getDiameter() {
    return avatar.diameter;
  }
  
  color getColor() {
    return avatar.getColor();
  }
  
  Bubble getAvatar() {
    return avatar;
  }
  
  int getReward() {
    return this.reward;
  }
  //----------END GET METHODS---------------------
  
  
  void getAngry(float level) {
    avatar.updateVelocity(level);
    reward += 5;
  }
  
  void getFat(float diameter) {
    avatar.updateSize(diameter);
    reward += 5;
  }
  
  void getHappy(int life) {
    this.life += life;
    reward += 10;
  }
  
  void loseLife(int amount) {
    this.life -= amount;
  }
  
  boolean isAlive() {
    return this.life > 0;
  }
  
 
  void updateBroken(float rate) {
    if (avatar.growrate == 0.0) {
      avatar.setGrowRate(rate);
    }
    avatar.updateSize(avatar.growrate);
    
    //determine if need to shrink
    float max_d = Helper.MAX_DIAMETER_ENEMY;
    if (this.tag == Helper.TAG_ENEMY)
      max_d = Helper.MAX_DIAMETER_ENEMY;
    else if (this.tag == Helper.TAG_PLAYER)
      max_d = Helper.MAX_DIAMETER_PLAYER;
    if (avatar.diameter > max_d) {
      avatar.setGrowRate(-Helper.BURST_RATE);
    }
    display();
  }
  
  boolean isCollide(float x2, float y2, float diameter2) {
    float dx = x2 - this.getX();
    float dy = y2 - this.getY();
    float distance = sqrt(dx*dx + dy*dy);
    float minDist = diameter2/2 + this.getDiameter()/2;
    return distance <= minDist;
  }
  
  void destroySelf() {
       avatar.burst();
       PlayerManager.destroyedPrs.add(this);
  }
  
  void collide(ArrayList<Projectile> others, String withTag) 
  {
      if (others.size() == 0)
        return;
       
      //same type of projectile
      if (this.tag == others.get(0).getTag())
        return;
        
      // check collisions with all bubbles
      for (int i = 0; i < others.size(); i++) 
      {
         Projectile other = others.get(i);
         
         boolean hit = isCollide(other.getX(), other.getY(), other.getDiameter());
         color otherColor = other.getColor();
         
         if (hit) 
         {   // collision has happened
           if (otherColor == this.getColor()) {
             other.loseLife(this.power);
             avatar.burst();
           }
           else {
             avatar.burst();
             //RED - increase speed
             color myColor = this.getColor();
             if (myColor == color(255,0,0)) {
               print("You make the enemy angry. Its speed has been increased");
               other.getAngry(2 * 24);
             }
             //GREEN - increase size
             else if (myColor == color(0, 255, 0)) {
               other.getFat(this.getDiameter());
             }
             //BLUE - increase life
              else if (myColor == color(0, 0, 255)) {
               other.getHappy(this.power);
             }
           }
           //check for remove dead object
           if (other.isAlive() == false) {
             other.getAvatar().burst();
             others.remove(i);
             PlayerManager.destroyedPrs.add(other);
             
             //update player score
             PlayerManager.updateScore(other.getReward());
             print("My score: ", PlayerManager.score);
             --i;
           }
           
           break;
         }
     }
     //removed broken enemie
  }
  
  void update() {
    avatar.update();
  }
  
  void display() {
    avatar.display();
  }
}
