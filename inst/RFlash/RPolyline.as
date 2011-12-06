package RFlash {
import flash.display.Graphics;

public class RPolyline extends RSprite {

  public var points : Array;

  public function RPolyline(points : Array) {
      super(0, 0);
      this.points = points;
  }

  override public function draw() : void {
     if(gcontext)
        gcontext.setContext(graphics);
     drawPolygon(points, graphics);
  }

  static public function drawPolygon(points : Array, g : Graphics) : void{
     g.moveTo(points[0], points[1]); 
     for(var i: int = 2; i < points.length; i+=2) 
         g.lineTo(points[i], points[i+1]);
  }
} 

}