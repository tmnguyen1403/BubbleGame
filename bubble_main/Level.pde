class Level {
  int nbEnemies;
  float enemyDiameter;
  private ArrayList<Projectile> enemies;
  
  Level(int nbEnemies, float enemyDiameter) {
    this.nbEnemies = nbEnemies;
    this.enemyDiameter = enemyDiameter;
    if (nbEnemies > 0) {
      setupEnemies();
    } else {
      println("ERROR: Number of enemies has to a positive number");
    }
  }
  
  float[] getLocation() {
    float[] location = {1.0, 1.0};
    location[0] = random(width); //x 
    location[1] = 10 + random(30); //y
    return location;
  }
  
  void setupEnemies() {
    enemies = new ArrayList<Projectile>();
    for (int i = 0; i < nbEnemies; i++) {
      float [] location = getLocation();
      Bubble b = new Bubble(location[0], location[1], enemyDiameter, i);
      //make buble float down
       b.setVelocity(0.0, 2);
      //set color for buble
      b.setColor(colors[i%3]);
      b.setTag(Helper.TAG_ENEMY);
      
      enemies.add(new Projectile(b, Helper.TAG_ENEMY));
    }
  }
  
  ArrayList<Projectile> getEnemies() {
    return enemies;
  }
  
}
