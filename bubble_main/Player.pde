class Player
{
  PImage spritesheet;
  String spritesheetsource;
  
//load character sprites
  int DIM;
  int W;
  int H;
  int posX, posY;
  PImage sprite; //define a global variable for your character

  int moveRange;
  int speed;
  //projectile setup
  ArrayList<Projectile> projectiles;
  int projectileSpeed;
  float projectileDiameter;
  color projectileColor;
  
  float fireRate; // assume frame is 24
  boolean didFire;
  float cooldown;
  float fps;
  
  Player(String spritesheetsource, int posX, int posY, int moveRange, int DIM ,int speed) 
  {
    this.spritesheetsource = spritesheetsource;    
    //starting position of the player
    this.posX = posX;
    this.posY = posY;
    this.moveRange = moveRange; //limit movement in screensize
    this.speed = speed;
    //dimension of spritesheet
    this.DIM = DIM;
    projectiles = new ArrayList<Projectile>();
    didFire = false;
    cooldown = 0.0;
  }
  
  
  private void loadAvatar(String source) {
    spritesheet = loadImage(source);
    W = spritesheet.width/DIM;
    H = spritesheet.height/DIM;
    sprite = spritesheet.get(0, 0, W, H);//starting image of the character
  }
  
  void playerSetup(float fps, color defaultColor)
  {
    loadAvatar(spritesheetsource);
    //initial position, middle of screen
    posY -= H;
    
    
    int speed = 8;
    float diameter = 25;
    projectileSetup(speed, diameter, defaultColor);
    
    this.fps = fps;
    this.fireRate = 12.0/fps; // assume frame is 24
      //println("FireRate ", this.fireRate);
  }
  
  void projectileSetup(int speed, float diameter, color defaultColor) 
  {
    projectileSpeed = speed;
    projectileDiameter = diameter;
    projectileColor = defaultColor;
    
  }
  
  void changeProjectile(String avatarSrc, color c) {
     loadAvatar(avatarSrc);
    //initial position, middle of screen
    this.projectileColor = c;
  }
  
  void moveWithMouse() {
    // move left
    if (mouseX < posX) {
      posX -= speed;
    }
    //move right
    if (mouseX > posX) {
      posX += speed;
    }
  }
  boolean moving(int x, int y) {
      
      boolean willMove = false;
      if (keyCode == LEFT || key == 97 || key == 65 ) // 97: a, 65: A
      {   
          posX -= speed;
          willMove = true;
      }
      else if (keyCode == RIGHT || key == 100 || key == 68 ) //100: d, 68: D
      {  
          posX += speed;
          willMove = true;
      }
      return willMove;
  }
  
  void shooting() {   
     // println("press space. shoot buble");
      int id = projectiles.size() + 1;
     // print("id: ", id);
      Bubble b = new Bubble(this.posX + W/2, this.posY, projectileDiameter, id);
      b.setVelocity(0.0, -projectileSpeed);
      b.setTag(Helper.TAG_PLAYER);
      b.setColor(this.projectileColor);
      
      Projectile new_projectile = new Projectile(b, Helper.TAG_PLAYER);
      projectiles.add(new_projectile);
      didFire = true;
      cooldown = 0;
  }
  
  void update() 
  {
    updatePlayer();
    //updatePlayerProjectiles();
  }
 
 boolean canShoot(boolean override)
 {
   int SPACE = 32; // default
   
   return (key == SPACE || override) && didFire == false;
 }
 
 void updatePlayer() 
  {  
    int prevX = posX;
    int prevY = posY;
    if (didFire == true) {
       cooldown += 1/this.fps;
       //println("cooldown: ", didFire, cooldown);
    }
    
    if (cooldown > fireRate) {
      didFire = false;
      cooldown = 0;
      //println("canfire: ", didFire, cooldown);
    }
    
    if (keyPressed == true) 
    {    
         // println("player pressed");
          boolean performingAction = false;
          //character can only move left and right
          
    
          performingAction = moving(0, 0);
          
          //check if player can fire
          if (!performingAction && canShoot(false)) {
           shooting();
          }
          
          
          //shooting action
          //println(posX," ", posY); //this is for debugging purpose, so that you can inspect the character's position
          
    }
    //int x, int y, int W, int H, int offsetX, int offsetY
    if (Helper.outOfRange(posX, posY, moveRange, moveRange, W/2, H/2)) {
      //text("Stop!! ", screenRange/2, screenRange/2);
      posX = prevX;
      posY = prevY;
    }
    
    image(sprite, posX, posY); //display the image
   // println("Player: ", posX, posY);
    //drawTitle();
        
  }
  
  void collide(ArrayList<Projectile> enemies){
    boolean hit;
    int i = 0;
    while (i < enemies.size()) {
      Projectile pr = enemies.get(i);
      hit = pr.isCollide(posX, posY, H/3);
      if (hit) {
        println("Player was hit");
        pr.destroySelf();
        PlayerManager.decreaseLife();
        enemies.remove(i);
        break;
        //destroyed enemy
      } else {
       // println("Did not HIT");
      }
      ++i;
    }
  }
  
  void updatePlayerProjectiles(ArrayList<Projectile> enemies)
  {
    if (projectiles.size() == 0)
      return;
   // print("projectile size", projectiles.size());
    for (Projectile pr : projectiles) {
      //println("Projectile: ", pr.getId());
      pr.collide(enemies, Helper.TAG_ENEMY);
       pr.update();
       pr.display();
    }
    for (int i = 0; i < projectiles.size(); i++) 
    {
      // get the current piece
      Projectile pr = projectiles.get(i);
      if (pr.isBroken()) {
        //b.collide();
        projectiles.remove(i);
        PlayerManager.destroyedPrs.add(pr);
        --i;
      }
      else if (pr.isOutOfRange()) {
        projectiles.remove(i);
        --i;
      }
    }
    //Check if enemy hit player
     
    //println("Number enemies: ", enemies.size());
 
  }

}
