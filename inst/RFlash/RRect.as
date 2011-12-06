package RFlash {
import flash.display.Graphics;

public class RRect extends RSprite {
  public var rwidth: int;
  public var rheight: int;

  public function RRect(x :int,  y :int,  width :int, height : int) {
      super(x, y);
      this.rwidth = width - x ;
      this.rheight = height - y;
  }

  override public function draw() : void {
     var g : Graphics;
     if(gcontext)
        gcontext.setContext(graphics);

     g = graphics;
     g.drawRect(rx, ry, rwidth, rheight);

     if(gcontext && gcontext.alpha[1] != 0)
        g.endFill();
  }
} 

}