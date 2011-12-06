
setContext =
function(g)
{
  col = as(g$col, "RGBStrict")
  fill = as(g$fill, "RGBStrict")

  c(if(col != "transparent")
      sprintf("ctx.lineStyle(%d, %s, %f);", g$lwd, col, g$gamma),
    if(fill != "transparent" && fill != "0x00000000")
       sprintf('ctx.beginFill(%s);', fill)
    )
}

 # These are the classes we import at the top of the generated file.
FlashImports = c("mx.core.*", "RFlash.*", "flash.text.*", "mx.controls.Alert") # "flare.util.Shapes",



Types =
  c(line = "RSprite",
    circle = "RSprite",
    rect = "RSprite",
    polyline = "RSprite",
    polygon = "RSprite",
    text = "TextField"
   )

asArray =
function(x, y, digits = 3)
{
 paste("[", paste(sprintf("xscale * %.3f, yscale * %.3f", x, y), sep = ", ", collapse = ", "), "]")
}




