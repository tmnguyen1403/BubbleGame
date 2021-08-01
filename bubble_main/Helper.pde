//contain util functions

static class Helper
{
  public static String TAG_PLAYER = "Player";
  public static String TAG_ENEMY = "Enemy";
  public static float TOO_SMALL = 1;
  public static float BURST_RATE = 5;
  public static float MAX_DIAMETER_ENEMY = 80;
  public static float MAX_DIAMETER_PLAYER = 50;
  public static int BROKEN = -99;
  public static int OUT_RANGE = -98;
  
  
  public static float distance(int x1, int y1, int x2, int y2) {
    float d = sqrt(pow((x1 - x2),2) + pow((y1 - y2), 2));
    return d;
  }
  
  public static float distanceFloat(float x1, float y1, float x2, float y2) {
    float d = sqrt(pow((x1 - x2),2) + pow((y1 - y2), 2));
    return d;
  }

  public static boolean inrange(float d, float range) {
    return d <= range;
  }
  
  //offset based on image width and height
  public static boolean outOfRange(int x, int y, int W, int H, int offsetX, int offsetY) {
    return x >= W - offsetX || x <= 0  - offsetX || y >= H - offsetY || y <= 0 - offsetY;
  }
  
  public static boolean outOfRange(float x, float y, float W, float H, float offsetX, float offsetY) {
    return x >= W - offsetX || x <= 0  - offsetX || y >= H - offsetY || y <= 0 - offsetY;
  }
}
