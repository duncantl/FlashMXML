package RFlash {

import flash.display.Graphics;

public class RCircle extends RSprite {
  public var radius: int;
  public function RCircle(x :int,  y :int,  r :int) {
      super(x, y);
      radius = r;
  }

  override public function draw() : void {
     var g : Graphics;
     if(gcontext)
        gcontext.setContext(graphics);
     g = graphics;
     // g.lineStyle(1, 0x000000, 1.0);
     g.moveTo(rx, ry);
     g.drawCircle(rx, ry, radius);
  }

  
} 

}