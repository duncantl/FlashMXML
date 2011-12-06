flashDevice =
function(file, dim = c(1000, 800), col = "black", fill = "transparent", ps = 10, wrapup = writeCode, ...)
{
  pages = new("FlashPlotsCode")
  commands = new("FlashPlotCode")
  add = function(x, type, context) {
    var = if(type == "text") "txt" else "tmp"
    x = c(paste("//", type),
          sprintf("%s = new %s();", var, Types[type]),
          if(var != "txt")
            sprintf("ctx = %s.graphics;", var),
          sprintf("plotObjects[i++] = %s;", var),
          sprintf("plot.addChild(%s);", var),
          setContext(context),
          x
         )
    commands <<- c(commands, x)
  }

  endPage = function()
    {
      if(length(commands)) {
         pages[[ length(pages) + 1 ]] <<- commands
         commands <<- new("FlashPlotCode")
      }
    }


  funs = dummyDevice() # Make into a Flash object!


    # No implementations for
  funs@mode = NULL
  funs@metricInfo = NULL
  funs@activate = NULL
  funs@deactivate = NULL
  funs@deactivate = NULL
  funs@locator = NULL
  funs@onExit = NULL

  
  funs@line = function(x1, y1, x2, y2, context, dev) {

    add(c(sprintf("ctx.moveTo(%s, %s);", as.integer(x1), as.integer(y1)),
          sprintf("ctx.lineTo(%s, %s);", as.integer(x2), as.integer(y2))
          ), "line", context)
  }

  funs@rect = function(x1, y1, x2, y2, context, dev) {
    add(c(sprintf("ctx.drawRect(%d, %d, %d, %d);",
                  as.integer(min(x1, x2)), as.integer(min(y1, y2)),
                  abs(as.integer(x2 - x1)), abs(as.integer(y2 - y1)))), "rect", context)
  }

  funs@circle = function(x1, y1, r, context, dev) {

    add(sprintf("ctx.drawCircle(%d, %d, %d);", as.integer(x1), as.integer(y1), as.integer(r)),
          "circle", context)
  }


  funs@polyline =
      #
      # XXX Connecting all the successive points. i.e. Polygon.
      #
  function(n, x, y, gcontext, dev) {

    x = x[1:n]
    y = y[1:n]
    add(c( # move to the first point and then connect all the subsequent ones.
        sprintf("ctx.moveTo(%s, %s);", as.integer(x[1]), as.integer(y[1])),
        sprintf("ctx.lineTo(%s, %s);", as.integer(x[-1]), as.integer(y[-1]))
        ), "polyline", gcontext)
  }

  funs@polygon =
    function(n, x, y, gcontext, dev)
      {
        x = x[1:n]
        y = y[1:n]
  #      cmd = paste("Shapes.drawPolygon(ctx,",  asArray(x, y), ")")
        cmd = c(sprintf("ctx.moveTo(%s, %s);", as.integer(x[1]), as.integer(y[1])),
                sprintf("ctx.lineTo(%s, %s);", as.integer(x[-1]), as.integer(y[-1])))
        add(cmd, "polygon", gcontext)
      }


  
  funs@textUTF8 = funs@text = function(x1, y1, txt, rot, hadj, context, dev) {

    add(c( sprintf('txt.text = "%s";', txt),
           sprintf("txt.x = %d;", as.integer(x1)),
           sprintf("txt.y = %d;", as.integer(y1))), "text", context)
  }

  funs@strWidth = function(str, gcontext, dev) {
     nchar(str) * max(10, gcontext$ps) * gcontext$cex
  }

  funs@newPage = function(gcontext, dev) {
     endPage()
  }


  funs@close = function(dev) {
      endPage()
      if(!is.language(file))      
        wrapup(pages, file, ...)
  }




  funs@initDevice = function(dev) {

       # The all important parameter to set ipr to get the plot region with adequate margins
#    print("initDevice")
    dev$ipr = rep(1/72.27, 2)
    dev$cra = rep(c(6, 13)/12) * 10
    dev$startps = 10
    dev$canClip = FALSE
    dev$canChangeGamma = TRUE
    dev$startgamma = 1
    dev$startcol = as("black", "RGBInt")
  }

  dev = graphicsDevice(funs, dim, col, fill, ps)
}


