static class StateManager {
  private static int state = 0;
  private static final int MAX_STATE = 4;
  private static PFont font = null;
  private static String FONT_FILE = "Charter-BoldItalic-24.vlw";
  private static float timer = 0;
  private static float fps = 24; 
  private static float cooldown = 12/fps;
  static void nextState() {
    if (timer < cooldown)
      return;
    if (state < MAX_STATE)
      state += 1;
    timer = 0;
  }
  static void updateTimer() {
    timer += 1/fps;
  }
  static boolean isPlaying() {
    return state >= 3;
  }
  static boolean isDead() {
    return state == 4;
  }
  static void restart() {
    state = 3;
  }
  
  static void loadStory(PApplet p) {
    if (state == 1) {
      loadStory2(p);
      return;
    } else if (state == 2) {
      loadTutorial(p);
      return;
    }
    if (font == null) {
      font = p.loadFont(FONT_FILE);
    }
    p.fill(255, 204, 0, 255); 
    int fontSize = 20;
    p.textFont(font, fontSize);
    String storyFile = "story.txt";
    String [] lines = p.loadStrings(storyFile);
    int index = 0;
    int nb_chars_on_line = p.width / fontSize * 2;
    for (String line : lines) {
      //println(line);
      StringBuilder sb = new StringBuilder(line); 
      int position = nb_chars_on_line;
      while (position < sb.length()) {
         sb.insert(position, "\n\n");
         position += nb_chars_on_line;
      }
      p.text(sb.toString(), 20, p.height / 8 + index * fontSize);
      index += position / fontSize + 1;
    }
    p.fill(255, 0, 0, 255);
    p.textFont(font, fontSize * 2);
    p.text(lines[lines.length - 1], p.width / 2 - 10 * fontSize , p.height - 100);
  }
  
  static void loadStory2(PApplet p) {
    if (font == null) {
      font = p.loadFont(FONT_FILE);
    }
    p.fill(255, 204, 0, 255); 
    int fontSize = 20;
    p.textFont(font, fontSize);
    String storyFile = "story2.txt";
    String [] lines = p.loadStrings(storyFile);
    int index = 0;
    int nb_chars_on_line = p.width / fontSize * 2;
    
    for (String line : lines) {
      if (line.contains("continue"))
        break;
      //println(line);
      StringBuilder sb = new StringBuilder(line); 
      int position = nb_chars_on_line;
      while (position < sb.length()) {
         sb.insert(position, "\n\n");
         position += nb_chars_on_line;
      }
      p.text(sb.toString(), 20, p.height / 8 + index * fontSize);
      index += position / fontSize;
    }
    p.fill(255, 0, 0, 255);
    p.textFont(font, fontSize * 2);
    p.text(lines[lines.length - 1], p.width / 2 - 10 * fontSize , p.height - 100);
  }
  
  static void loadTutorial(PApplet p) {
    if (font == null) {
      font = p.loadFont(FONT_FILE);
    }
    p.fill(255, 204, 0, 255); 
    int fontSize = 20;
    p.textFont(font, fontSize);
    String storyFile = "tutorial.txt";
    String [] lines = p.loadStrings(storyFile);
    int index = 0;
    int nb_chars_on_line = p.width / fontSize * 2;
    for (String line : lines) {
      if (line.contains("start"))
        break;
      StringBuilder sb = new StringBuilder(line); 
      int position = nb_chars_on_line;
      while (position < sb.length()) {
         sb.insert(position, "\n\n");
         position += nb_chars_on_line;
      }
      p.text(sb.toString(), 20, 100 + index * fontSize);
      index += position / fontSize;
    }
    p.fill(255, 0, 0, 255);
    p.textFont(font, fontSize * 2);
    p.text(lines[lines.length - 1], p.width / 5 , p.height - 100);
  }
}
