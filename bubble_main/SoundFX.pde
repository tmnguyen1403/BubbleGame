import processing.sound.*;


static class SoundFX {
  private static String srcFolder = "./soundfx/";
  private static String deadFile = "mixkit-arcade-space-shooter-dead-notification-272.wav";
  private static String shootFile = "mixkit-game-whip-shot-1512.wav";
  
  private static SoundFile deadSound;
  private static SoundFile shootSound;
  
  static void setupFX(PApplet p) {
    deadSound = new SoundFile(p, srcFolder + deadFile);
    shootSound = new SoundFile(p, srcFolder + shootFile);
  }
  static void playPlayerDead(PApplet p) {
    deadSound.play();
  }
  static void playPlayerShoot(PApplet p) {
    shootSound.play();
  }
}
