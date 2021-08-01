  // adapted from the "BouncyBubbles" example.


int numBubbles = 20; // initial bubble count
float enemyDiameter = 40;

// code for "broken", may have other states later
final int MAXDIAMETER = 120; // maximum size of expanding bubble


ArrayList<Projectile> enemies; // all the playing pieces
color colors[] = {color(255,0,0), color(0,255,0), color(0,0,255)};
int colorIndex = 0;

Player player;
PlayerUI playerUI;

String playerSpritesheet = "./avatar/spaceship_red.png";

//Volume control
Sound s;

int screenRange = 800;
public void settings() 
{
  size(800,800);
}

void setup() 
{
  playerUI = new PlayerUI();
  enemies = new ArrayList<Projectile>();
  SoundFX.setupFX(this);
  noStroke();
  smooth();
  for (int i = 0; i < numBubbles; i++) {
    //Bubble(float xin, float yin, float din, int idin, ArrayList oin) 
      Bubble b = new Bubble(random(width), 10 + random(30), enemyDiameter, i, enemies);
      //make buble float down
       b.setVelocity(0.0, 2);
       /*
      if (i % 2 == 0) {
        b.setVelocity(0.5, 0.0);
      } else {
        b.setVelocity(0.0, 0.5);
      }*/
      //set color for buble
      b.setColor(colors[i%3]);
      b.setTag(Helper.TAG_ENEMY);
      
      enemies.add(new Projectile(b, Helper.TAG_ENEMY));
      
      //Sound volume control
      s = new Sound(this);
  }
  
  //Player(String spritesheetsource, int posX, int posY, int moveRange, int DIM, int speed)
  int playerSpeed = 15; 
  player = new Player(PlayerManager.getAvatar(colorIndex), screenRange/2, screenRange - 10, screenRange, 1, playerSpeed);
  float fps = 24.0;
  player.playerSetup(fps, colors[colorIndex]);
}

void mousePressed()
{  
      // on click, create a new burst bubble at the mouse location and add it to the field      
      //Bubble b = new Bubble(mouseX,mouseY,2,numBubbles,pieces);
      //b.burst();
      //pieces.add(b);
      //numBubbles++;   
      if (mouseButton == RIGHT) {
        colorIndex = (colorIndex + 1) % colors.length;
        player.changeProjectile(PlayerManager.getAvatar(colorIndex), colors[colorIndex]);
        SoundFX.playChangeProjectile(this);
      }
      else if (mouseButton == LEFT) {
        if (StateManager.isPlaying()) {
          if (player.canShoot(true)) {
            player.shooting();
            SoundFX.playPlayerShoot(this);
          }
        }
      }
}

void mouseMoved() {
  if (StateManager.isPlaying()){
    println("I moved my mouse");
    println("Mouse X: ", mouseX);
    player.moveWithMouse();
  }
}

void draw() 
{
  background(0);
  s.volume(0.5);
  StateManager.updateTimer();
  if ( (key == 82 || key == 114) && StateManager.isDead()) {
    PlayerManager.resetLife();
    StateManager.restart();
  } //restart
  if ( (keyPressed == true || mousePressed) && StateManager.isPlaying() == false) {
    StateManager.nextState();
   
  }
  if (StateManager.isPlaying() == false) {
    StateManager.loadStory(this);
  }
  
  else {

  //test acceleration
  //float acceleration = 1;
  
    player.update();
    player.updatePlayerProjectiles(enemies);
    player.collide(enemies);
    //remove enemies
    for (int i = 0; i < enemies.size(); i++) 
      {
        Projectile pr = enemies.get(i);
        if (pr.isOutOfRange()) {
          enemies.remove(i);
          --i;
        }
      }
    for (Projectile enemy : enemies)  
    {
      enemy.update();
      enemy.display();
    }
    PlayerManager.animateDestroyed();
    playerUI.drawAll();
  }
}

//buble falling from the sky
//buble with different colors
