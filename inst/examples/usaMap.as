import flare.util.Shapes; 
import mx.core.UIComponent;

import mx.controls.Alert;

import R.RSprite;


/* The polys variable comes from the usaPolygons.as file. */

public var fpolys : Array = new Array();


public function usa() : void {
  var ref : UIComponent = new UIComponent();
  var p : Sprite = new Sprite();
  var g : Graphics = p.graphics;

  this.visible = true;

  g.beginFill(0xFFCC00);


       /* Draw each of the polygons */
    var i : int;
    for(i = 0; i < polys.length; i++) {
	var tmp : RSprite = new RSprite(); /* Sprite() */
	fpolys[i] = tmp;
        tmp.poly = polys[i];
        tmp.index = i;
	g = tmp.graphics;
	g.lineStyle(.5, 0x0000FF);
        g.beginFill(0xFFCC00);
        Shapes.drawPolygon(g, polys[i]);                
        ref.addChild(tmp);

	tmp.addEventListener(MouseEvent.CLICK, showCountyDetails); /* fpolys[i]) */
	tmp.addEventListener(MouseEvent.MOUSE_OVER, highlightCounty);
	tmp.addEventListener(MouseEvent.MOUSE_OUT, unhighlightCounty);
    }

    addChild(ref);
}

public function highlightCounty(event : Event) : void 
{
    var g : Graphics = event.target.graphics;
    var county : RSprite  = event.target as RSprite;
    g.beginFill(0xFF0000);
    Shapes.drawPolygon(g, county.poly)
    g.endFill();
}

public function unhighlightCounty(event : Event) : void 
{
    var g : Graphics = event.target.graphics;
    var county : RSprite  = event.target as RSprite;
    g.beginFill(0xFFCC00);
    Shapes.drawPolygon(g, county.poly)
    g.endFill();
}


public function showCountyDetails(event : Event) : void /* , data : Sprite, i : int) : void  */
{
    var g : Graphics = event.target.graphics;
    var county : RSprite  = event.target as RSprite;
//Alert.show("showCountyDetails " + i)
    g.beginFill(0xFF0000);
    Shapes.drawPolygon(g, county.poly)
    g.endFill();
}