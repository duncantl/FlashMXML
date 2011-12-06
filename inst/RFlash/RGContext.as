package RFlash {

import flash.display.Graphics;

// See http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Graphics.htm

/*
We might split this into RGContext RLineGContext and RTextGContext
                     
*/
public class RGContext {

// Max uint = 4294967295

   static public var TRANSPARENT : uint = 16777215;

   static public var BOLD : uint;
   static public var ITALIC : uint;

   public var col : uint;
   public var fill : uint;
   public var alpha : Array;
   public var lty : uint;
   public var lwd : uint;
   public var ljoin : String;
   public var lend : String;
   public var lmitre : Number;

   public var ps : uint;
   public var font : String;
   public var fontface: uint;

   public function RGContext(col : uint, fill : uint, alpha : Array, 
                             lwd : uint, lend : String, ljoin : String, lmitre : Number,
                             ps : uint, font : String, fontface : uint) 
   {
       this.col = col ;
       this.fill = fill ;
       this.alpha = alpha;
       this.lwd = lwd ;
       this.lty = lty ;
       this.lend = lend ;
       this.ljoin = ljoin ;
       this.lmitre = lmitre;
       this.ps = ps;
       this.font = font;
       this.fontface = fontface;
   }


  /* Given a graphics object, populate it with the relevant settings from this context. */
  public function setContext(g : Graphics) : void {
     if(alpha[1] > 0.0)
       g.beginFill(fill, alpha[1]);

     g.lineStyle(lwd, col, alpha[0],  false, "normal", lend, ljoin, lmitre);
  }
 }
}