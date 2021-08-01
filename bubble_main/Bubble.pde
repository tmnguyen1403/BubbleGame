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
        if (Helper.outOfRange(x , y, width, height, diameter/2 ,diameter/2)) {
            this.status = Helper.OUT_RANGE;
            return;
        }
        if (tag == Helper.TAG_PLAYER) 
        {
          //outOfRange(int x, int y, int W, int H, int offsetX, int offsetY) {
          
          return;
        }
       // the rest: reflect off the sides and top and bottom of the screen
       if (x + diameter/2 > width) 
       {
           x = width - diameter/2;
           vx *= -1; 
       }
       else if (x - diameter/2 < 0) 
       {
           x = diameter/2;
           vx *= -1;
       }

       if (y + diameter/2 > height) 
       {
           y = height - diameter/2;
           vy *= -1; 
       } 
       else if (y - diameter/2 < 0) 
       {
           y = diameter/2;
           vy *= -1;
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
