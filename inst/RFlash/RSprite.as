package RFlash {

import mx.core.UIComponent;
import flash.display.Sprite;
import flash.utils.Dictionary;

public class RSprite extends Sprite {

//  public var poly : Array;
//  public var index : int;
  public var objects : Dictionary;

  public var rx : int;
  public var ry : int;
  public var gcontext : RGContext 

/*
  public function RSprite() {
    objects = new Dictionary();
  }
*/


  public function RSprite(x: int, y: int) {
     setLocation(x, y);
     objects = new Dictionary();
  }

  public function setContext(g : RGContext) : void {
     gcontext = g;
  }

  public function draw() : void {  
     if(gcontext)
        gcontext.setContext(graphics);
  }

  
  public function setLocation(x : int, y : int) : void {
    this.rx = x;
    this.ry = y;
  }
}


};
