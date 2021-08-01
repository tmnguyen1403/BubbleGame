// Add color to the buble


//
class Bubble 
{
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  int status = 0;
  float growrate = 0;
 
  color mycolor;
  String tag;
  
  Bubble(float xin, float yin, float din, int idin) 
  {
    x = xin;
    y = yin;
    diameter = din;
    growrate = 0;
    id = idin;
    vx = random(0,100)/50. - 1.;
    vy = random(0,100)/50. - 1.;

    mycolor = color(255,255,255);
  }
  
  color getColor() {
    return mycolor;
  }
  
  void setVelocity(float vx, float vy) {
      this.vx = vx;
      this.vy = vy;
  }
  
  void setColor(color inputcolor) {
    this.mycolor = inputcolor;
  }
  
  void setTag(String tag) {
    this.tag = tag;
  }
  
  void setGrowRate(float rate) {
    this.growrate = rate;
  }
  
  void burst()
  {
      if (this.status != Helper.BROKEN) // only burst once
      {
         this.status = Helper.BROKEN;
      }
  }
  
 
  void updateVelocity(float acceleration) {
    //assume frame rate is 24
    if ( vx != 0)
      vx += acceleration * 1/24;
    if (vy != 0)
      vy += acceleration * 1/24;
  }
  
  void updateSize(float diameter) {
    this.diameter += diameter;
  }
  
  void update() 
  {
     if (this.status != Helper.BROKEN)
     {
         
        // move via Euler integration
        x += vx;
        y += vy;
        if (tag == Helper.TAG_PLAYER && Helper.outOfRange(x , y, width, height, diameter/2 ,diameter/2)) {
            this.status = Helper.OUT_RANGE;
            return;
        }
        if (tag == Helper.TAG_ENEMY) 
        {
          if (y >= height - diameter/2) {
            this.status = Helper.OUT_RANGE;
            return;
          }
        }
      
    }
  }
  
  
  
  void display() 
  {
    // how to draw a bubble: set to white with some transparency, draw a circle
    fill(this.mycolor);
    ellipse(x, y, diameter, diameter);
  }
  
}
