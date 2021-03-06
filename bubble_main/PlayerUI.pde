class PlayerUI {
   PFont font;
   String FONT_FILE;
   PlayerUI() {
     FONT_FILE = "Charter-BoldItalic-24.vlw";
     font = loadFont(FONT_FILE);
   }
   void drawAll() {
     //drawTitle();
     displayScore();
     displayLife();
     displayLevel();
     if (PlayerManager.life <= 0) {
       StateManager.nextState();
       drawGameOver();
     } else if (StateManager.isEndGame())// no more level
     {
       StateManager.nextState();
       drawEndGame();
     }
   }
   
  // void drawTitle() {
  //  fill(0, 102, 153, 128);  
  //  textFont(font, 20);
  //  text("Welcome to Buble World", 10, 60);
  //}
  void displayScore() {
    fill(255, 234, 0, 128);  
    textFont(font, 30);
    String scoreText = "Score: " + PlayerManager.score;
    text(scoreText, width - width/5, 60);
  }
  void displayLife() {
    fill(255, 0, 0);  
    textFont(font, 40);
    String scoreText = "Life: " + PlayerManager.life;
    text(scoreText, width - width/5, 60 + 50);
  }
  void displayLevel() {
    fill(255, 0, 0);  
    textFont(font, 40);
    String scoreText = "Game level: " + LevelManager.getCurrent();
    text(scoreText, width - width/3, 60 + 50 * 2);
  }
  
  void drawGameOver() {
    int fontSize = 60;
    fill(255,0,0);  
    textFont(font, 60);
    String scoreText = "Game Over";
    text(scoreText, width/fontSize, height/2);
    text("Press R to replay", width/fontSize, height/1.5);
  }
  
  void drawEndGame() {
    
    int fontSize = 40;
    fill(255,0,0);  
    textFont(font, fontSize);
    String scoreText = "You survived! To be continued! \n Creator: Minh Nguyen - UHD \n 08012021";
    text(scoreText, width/fontSize, height/4);
    text("Press R to start over", width/fontSize, height/1.5);
  }
}
