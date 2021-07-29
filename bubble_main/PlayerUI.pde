class PlayerUI {
   PFont font;
   PlayerUI() {
     font = loadFont("Papyrus-Regular-48.vlw");
   }
   void drawAll() {
     drawTitle();
     displayScore();
     displayLife();
     if (PlayerManager.life <= 0) {
       drawGameOver();
     }
   }
   
   void drawTitle() {
    fill(0, 102, 153, 128);  
    textFont(font, 20);
    text("Welcome to Buble World", 10, 60);
  }
  void displayScore() {
    fill(0, 102, 153, 128);  
    textFont(font, 30);
    String scoreText = "Score: " + PlayerManager.score;
    text(scoreText, width / 2 + 100, 60);
  }
  void displayLife() {
    fill(0, 102, 153, 128);  
    textFont(font, 40);
    String scoreText = "Life: " + PlayerManager.life;
    text(scoreText, width / 2, 60 + 50);
  }
  
  void drawGameOver() {
    
    int fontSize = 60;
    fill(255,0,0);  
    textFont(font, 60);
    String scoreText = "Game Over";
    text(scoreText, width/fontSize, height/2);
    text("Press R to replay", width/fontSize, height/1.5);
  }
}
