static class PlayerManager {
  static int score = 0;
  static ArrayList<Projectile> destroyedPrs = new ArrayList<Projectile>(); //handle destroyed projectiles
  
  static void updateScore(int by) {
    score += by;
  }
  
  static void animateDestroyed() {
    for (Projectile pr : destroyedPrs) {
      //pr.getAvatar().setGrowRate(10); 
      pr.updateBroken(Helper.BURST_RATE);
    }
    for (int i = 0; i < destroyedPrs.size(); ++i) {
      Projectile pr = destroyedPrs.get(i);
      if (pr.getDiameter() < Helper.TOO_SMALL) {
        destroyedPrs.remove(i);
        --i;
      }
    }
  }
}
