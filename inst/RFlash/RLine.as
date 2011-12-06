package RFlash {

import flash.display.Graphics;

public class RLine extends RSprite {
  public var x1: int;
  public var y1: int;

  public function RLine(x : int,  y :int,  x1 :int, y1 : int) {
      super(x, y);
      this.x1 = x1;
      this.y1 = y1;
  }

  override public function draw() : void {
     var g : Graphics;
     if(gcontext)
        gcontext.setContext(graphics);
     g = graphics;
     //g.lineStyle(1, 0x000000, 1.0);
     g.moveTo(rx, ry);
     g.lineTo(x1, y1);
  }

  
} 

}