class Level {
  int nbEnemies;
  float enemyDiameter;
  private ArrayList<Projectile> enemies;
  private ArrayList<Float[]> locations;
  private float difficulty;
  
  Level(int nbEnemies, float enemyDiameter, float difficulty) {
    this.nbEnemies = nbEnemies;
    this.enemyDiameter = enemyDiameter;
    this.difficulty = difficulty;
    locations = new ArrayList<Float[]>();
    if (nbEnemies > 0) {
      setupEnemies();
    } else {
      println("ERROR: Number of enemies has to a positive number");
    }
    
  }
  
  boolean isNotOccupied(Float [] loc) {
    if (locations.size() == 0)
      return true;
    float distance;
    for (Float[] occupied: locations) {
      distance = Helper.distanceFloat(loc[0],loc[1],occupied[0],occupied[1]);
      if (distance <= enemyDiameter / 2)
        return false;
    }
    return true;
  }
  
  Float[] getLocation() {
    Float[] location = {1.0, 1.0};
    boolean validLocation = false;
    float offset = enemyDiameter + enemyDiameter / 2;
    location[0] = random(enemyDiameter, width - enemyDiameter); //x 
    location[1] = random(30); //y
    while (! validLocation) {
      validLocation = isNotOccupied(location);
      if (!validLocation) {
        location[0] += random(-1,1) * offset;
        location[1] -= offset * 2;
      }
    }
    locations.add(location);
    return location;
  }
  
  void setupEnemies() {
    enemies = new ArrayList<Projectile>();
    for (int i = 0; i < nbEnemies; i++) {
      Float [] location = getLocation();
      Bubble b = new Bubble(location[0], location[1], enemyDiameter, i);
      //make buble float down
       b.setVelocity(0.0, random(2,3*this.difficulty));
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
