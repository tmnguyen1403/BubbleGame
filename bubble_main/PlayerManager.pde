static class PlayerManager {
  static int score = 0;
  static int life = 3;
  static ArrayList<Projectile> destroyedPrs = new ArrayList<Projectile>(); //handle destroyed projectiles
  private static String [] avatarSrcs = {"./avatar/spaceship_red.png","./avatar/spaceship_green.png","./avatar/spaceship_blue.png"};
  private static boolean deadSoundPlay = false;
  static String getAvatar(int index) {
    
    return avatarSrcs[index % avatarSrcs.length];
  }
  static void updateScore(int by) {
    score += by;
  }
  
  static void decreaseLife() {
    life -= 1;
  }
  
  static void restart() {
    life = 3;
    score = 0;
    deadSoundPlay = false;
  }
  
  static void dead(PApplet p) {
    if (!deadSoundPlay) {
      deadSoundPlay = true;
      SoundFX.playPlayerDead(p);
    }
  }
  static void animateDestroyed(PApplet p) {
    for (Projectile pr : destroyedPrs) {
      //pr.getAvatar().setGrowRate(10); 
      pr.updateBroken(Helper.BURST_RATE);
    }
    for (int i = 0; i < destroyedPrs.size(); ++i) {
      Projectile pr = destroyedPrs.get(i);
      if (pr.getDiameter() < Helper.TOO_SMALL) {
        destroyedPrs.remove(i);
        --i;
        SoundFX.playExplosion(p);
      }
    }
  }
}
