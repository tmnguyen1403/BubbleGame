import processing.sound.*;


static class SoundFX {
  private static String srcFolder = "./soundfx/";
  private static String deadFile = "gameover.mp3";
  private static String shootFile = "fire.mp3";
  private static String changeProjectileFile = "change_projectile.mp3";
   private static String backgroundFile = "background.mp3";
  private static String explosionFile = "explosion.mp3";
  
  private static SoundFile deadSound;
  private static SoundFile shootSound;
  private static SoundFile changeSound;
  private static SoundFile backgroundSound;
  private static SoundFile explosionSound;
  
  private static float background_amp = 0.1;
  private static float sound_amp = 0.3;
  
  private static String getFile(String f) {
    return srcFolder + f;
  }
  static void setupFX(PApplet p) {
    deadSound = new SoundFile(p, getFile(deadFile));
    shootSound = new SoundFile(p, getFile(shootFile));
    changeSound = new SoundFile(p, getFile(changeProjectileFile));
    backgroundSound = new SoundFile(p, getFile(backgroundFile));
    explosionSound = new SoundFile(p, getFile(explosionFile));
    
    playBackground(p);
  }
  
  static void playExplosion(PApplet p) {
    explosionSound.play(1, sound_amp - 0.25);
  }
  static void playPlayerDead(PApplet p) {
    deadSound.play(1, sound_amp);
  }
  static void playPlayerShoot(PApplet p) {
    shootSound.play(1, sound_amp);
  }
  static void playChangeProjectile(PApplet p ) {
    changeSound.play(1, sound_amp);
  }
  static void playBackground(PApplet p ) {
    backgroundSound.loop(1, background_amp); //(rate, amp)
  }
}
