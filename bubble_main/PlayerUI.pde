class PlayerUI {
   PFont font;
   PlayerUI() {
     font = loadFont("Papyrus-Regular-48.vlw");
   }
   void drawAll() {
     drawTitle();
     displayScore();
   }
   
   void drawTitle() {
    fill(0, 102, 153, 128);  
    textFont(font, 40);
    text("Welcome to Buble World", 10, 60);
  }
  void displayScore() {
    fill(0, 102, 153, 128);  
    textFont(font, 40);
    String scoreText = "Score: " + PlayerManager.score;
    text(scoreText, width / 2, 60);
  }
}
