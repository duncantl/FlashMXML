package RFlash {

import flash.display.Graphics;
import flash.text.*;

public class RText extends RSprite {
  public var txt: TextField;
  public var rot: Number;

  public function RText(x :int,  y :int,  str : String, rot: Number) {
      super(x, y);
      txt = new TextField();
      txt.x = x;
      txt.y = y;
      txt.text = str;
      this.rotation = rot;
  }

  override public function draw() : void {
     var g : Graphics;
  }

  override public function setContext(g : RGContext) : void {
     gcontext = g;
// http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/text/TextField.html
// http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/text/TextFormat.html
     var format:TextFormat = new TextFormat();
       format.font = g.font;
       format.color = g.col;
       format.size = g.ps;

       if(g.fontface == RGContext.BOLD)
           format.bold = true;
       else if(g.fontface == RGContext.ITALIC)
           format.italic = true;

     txt.setTextFormat(format);
     txt.textColor = g.col;
     txt.autoSize = TextFieldAutoSize.LEFT;
  }

  
} 

}