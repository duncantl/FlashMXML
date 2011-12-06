package RFlash {
import flash.display.Graphics;

public class RPolygon extends RPolyline {

  public function RPolygon(points : Array) {
      super(points);
  }

  override public function draw() : void {
     if(gcontext)
        gcontext.setContext(graphics);

     RPolyline.drawPolygon(points, graphics);

     if(gcontext && gcontext.alpha[1] > 0.0)
        graphics.endFill();
  }
} 

}