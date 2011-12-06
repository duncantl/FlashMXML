import RFlash.*;
import mx.core.UIComponent ;
import flash.text.*;

public function duncan() : void {

  var plot : UIComponent = new UIComponent();
  var cur : RSprite ;

  cur = new RLine(100, 100, 200, 200);
  plot.addChild(cur);
  cur.draw();

  cur = new RCircle(150, 150, 20);
  plot.addChild(cur);
  cur.draw();

  cur = new RRect(275, 275, 295, 300);
  plot.addChild(cur);
  cur.draw();

  cur = new RPolygon([30, 10, 10, 25, 30, 50, 80, 25, 10, 10]);
  plot.addChild(cur);
  cur.draw();
  
  var txt : TextField = new TextField();
  var fmt:TextFormat = new TextFormat();
  fmt.font = "Verdana";
  fmt.size = 24;
  fmt.color = 0xFF0000;

  txt.maxChars = 12;
  txt.text = "This is text";
  txt.setTextFormat(fmt);
  plot.addChild(txt);
//  txt.draw();


  addChild(plot);
}