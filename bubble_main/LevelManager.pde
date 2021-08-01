static class LevelManager {
  private static int currentLevel = -1;
  private static int maxLevel = 2;
  private static float[] difficulty = {0.5, 0.75};
  private static int[] numBubbles = {15, 20};
  
  static int getCurrent() {
    return currentLevel;
  }
  static boolean nextLevel() {
     if (currentLevel + 1 >= maxLevel)
       return false; //there is no next level
     currentLevel += 1;
     return true;
  }
  static void prevLevel() {
    currentLevel -= 1;
  }
  
  static void restart() {
    currentLevel = -1;
  }
  static float getDifficulty() {
    return difficulty[currentLevel];
  }
  static int getNumBubbles() {
    println("current level", currentLevel);
    return numBubbles[currentLevel];
  }
}
