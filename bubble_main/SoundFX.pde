import processing.sound.*;


static class SoundFX {
  static String srcFolder = "./soundfx/";
  static String deadFile = "mixkit-arcade-space-shooter-dead-notification-272.wav";
  static SoundFile deadSound;
  static void setupFX(PApplet p) {
    deadSound = new SoundFile(p, srcFolder + deadFile);
  }
  static void playPlayerDead(PApplet p) {
    deadSound.play();
  }
}
