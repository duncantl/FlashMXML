import RFlash.RSprite;
import mx.controls.Alert;

public function foo() : void 
{
  var els : Array;
  els = rdraw();
  var i : int;

  for(i = 0 ; i < els.length; i++) {
     var sp : RSprite;
     sp = els[i] as RSprite;
     sp.addEventListener(MouseEvent.MOUSE_OVER, sayHi);
  }
}

protected function sayHi(e : Event) : void {
     Alert.show("Hi state");
}