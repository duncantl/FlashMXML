# Merge the code with basicDevice() in basicDevice.R

setClass("FlashDeviceMethods",
         representation(doc = "function"),
         contains = "RDevDescMethods")


setObjectContext =
function(g, type, font = "Verdana")
{
   col = as(g$col, "RGBStrict")
   fill = as(g$fill, "RGBStrict")
   
   lend = as(as(g$lend, "R_GE_lineend"), "FlashLineCaps")
   ljoin = as(as(g$ljoin, "R_GE_linejoin"), "FlashLineJoin")
  
   sprintf('tmp.setContext(new RGContext(%s, %s, [%f, %f], %d, "%s", "%s", %d, %d, "%s", %d));',
                col, fill, col@alpha, fill@alpha, g$lwd, lend, ljoin, g$lmitre,
                  as.integer(g$cex * min(10L, g$ps)), font, g$fontface)
}



flash =
function(file, dim = c(1000, 800), col = "black", fill = "transparent", ps = 10,
         font = Font(findFontFile("arial.ttf"), "arial", 1, ps), # default font.
         wrapup = writeCode, top = 0, left = 0, ...,
         funs = dummyDevice( obj = new("FlashDeviceMethods"))
        )
{

  if(is(funs, "FlashDeviceMethods") && is(funs@doc, "DegenerateDeviceFunction")) {
    funs@doc = function() xmlDoc
  }
  
    # variables shared by the functions implementing the graphics device methods
    # which are used to collect the ActionScript code for creating the plots.
    # pages holds each plot. commands holds all of the ActionScript commands for
    # the current plot.
  pages = new("FlashObjectsPlotsCode")
  commands = new("FlashObjectsPlotCode")
  xmlDoc = NULL

  sizes = if(is.matrix(dim)) dim else matrix(dim, , 2, byrow = TRUE)
         

     # A named list of fonts that are used within the commands and so have to be
     # explicitly embedded
  fonts = new("FontTable")

  if(!is(font, "Font"))
    font = Font(NA, font, "normal", ps)

  fonts = addFont(fonts, font)

     # Local utility function that adds the specified code to the commands
     # This is for creating an RSprite object of a particular type.
  add = function(create, context, type, extra = character()) {
    var = "tmp"
    x = c(
          paste(var, "=", create[1], ";"),
          create[-1],
          setObjectContext(context, type),      
          sprintf("plotObjects[i++] = %s;", var),
          sprintf("plot.addChild(%s);", var),
          sprintf("%s.draw();", var),
          extra,
          ""
         )
    names(x) = c(type, rep("", length(x) - 1))
    commands <<- c(commands, x)
  }

    # Function to be called when we finish a plot.
    # Wraps up the commands and moves them to the next element of pages.
  endPage = function()
    {
      if(length(commands)) {
         pages[[ length(pages) + 1 ]] <<- commands
         commands <<- new("FlashObjectsPlotCode")
           # set the dimension for the new plot.
      }
    }


  # funs = dummyDevice(obj) # Make into a Flash object!

    # No implementations for
  funs@mode = NULL
  funs@metricInfo = NULL
  funs@activate = NULL
  funs@deactivate = NULL
  funs@deactivate = NULL
  funs@locator = NULL
  funs@onExit = NULL

  
  funs@line = function(x1, y1, x2, y2, context, dev) {

    add(sprintf("new RLine(xscale * %d, yscale * %d, xscale * %d, yscale * %d)",
                      as.integer(x1), as.integer(y1),
                      as.integer(x2), as.integer(y2)),
          context, "line")
  }

  funs@rect = function(x1, y1, x2, y2, context, dev) {

    add(sprintf("new RRect(xscale * %d, yscale * %d, xscale * %d, yscale* %d)",
                  as.integer(min(x1, x2)), as.integer(min(y1, y2)),
                  as.integer(max(x1, x2)), as.integer(max(y1, y2))                
#                  abs(as.integer(x2 - x1)), abs(as.integer(y2 - y1))
               ),
         context, "rect")
  }

  funs@circle = function(x1, y1, r, context, dev) {
    add(sprintf("new RCircle(xscale * %d, xscale * %d, xscale * %d)", as.integer(x1), as.integer(y1), as.integer(r)),
          context, "circle")
  }


  funs@polyline =
      #
      # XXX Connecting all the successive points. i.e. Polygon.
      #
  function(n, x, y, gcontext, dev) {

    x = x[1:n]
    y = y[1:n]
    add(sprintf("new RPolyline(%s)", asArray(x, y)),
         gcontext, "polyline")
  }

  funs@polygon =
    function(n, x, y, gcontext, dev)
      {
        x = x[1:n]
        y = y[1:n]
        add(sprintf("new RPolygon(%s)", asArray(x, y)),  gcontext, "polygon")
      }

  funs@textUTF8 = funs@text = function(x1, y1, txt, rot, hadj, context, dev) {


         #XXX hadj
    cmd = sprintf('txt = new RText(xscale * %d, yscale * %d, "%s", %f)', as.integer(x1), as.integer(y1), txt, rot)
    cmd = c(cmd, "txt.txt.selectable = true;", sprintf("txt.txt.maxChars = %d;", nchar(txt)))
    if(context$fontfamily != "" || rot != 0.0) {

       font = if(context$fontfamily == "")  font else Font(findFontFile(context$fontfamily), context$fontfamily, context$fontface, context$ps)
         
       id = lookupFontName(fonts, font, context$fontface, context$ps, context$cex)
       if(is.na(id)) {
          fonts <<- addFont(fonts, font, context$fontface, context$ps, context$cex)
          id = lookupFontName(fonts, context$fontfamily, context$fontface, context$ps, context$cex)
       }
    }

    
    if(length(grep("^http", txt)))
       cmd = c(cmd, sprintf('txt.txt.htmlText = "<a href=\'%s\'>%s</a>"', txt, txt))    
    
    add(cmd, context, "text", "plot.addChild(txt.txt);")

    if(rot != 0.0) {
              # rotation seems to go the other way around so subtract from 360.
      cmd = paste("txt.txt.rotation =", 360 - rot, ";", "txt.txt.embedFonts = true;")
      cmd = c(cmd, textFormat(context$ps, fontVariableName(font)))
      commands <<- c(commands, cmd, "")
    }
  }

  funs@strWidth = function(str, gcontext, dev) {
     nchar(str) * max(10, gcontext$ps) * gcontext$cex
  }

  funs@newPage = function(gcontext, dev) {
     endPage()
     plotNum = length(pages) + 1

     sz = sizes[  plotNum %% nrow(sizes) + 1, ]
     dev$right = sz[1]
     dev$bottom = sz[2]     
  }


  funs@close = function(dev) {
      endPage()
      if(!is.language(file)) {
        ans = wrapup(pages, file, fonts = fonts, ...)

        if(is.na(file))
          xmlDoc <<- ans
        ans
      }
  }



  funs@initDevice = function(dev) {

       # The all important parameter to set ipr to get the plot region with adequate margins

cat("FlashMXML initDevice\n")

    dev$ipr = rep(1/72.27, 2)
    dev$cra = rep(c(6, 13)/12) * 10
    dev$startps = 10
    dev$canClip = FALSE
    dev$canChangeGamma = TRUE
    dev$startgamma = 1
    dev$startcol = as(col, "RGBInt")
    dev$top = top
    dev$left = left
print(as(dev, "DevDesc"))
  }

  dev = graphicsDevice(funs, dim, col, fill, ps)
}

# These functions and methods are for taking the character vector of action script commands
# and breaking them into groups of code that correspond to an individual element in the plot.
# We could have done this in the add() function in our object (flash()) and not concatenated
# the elements into a single character vector, but rather a list of elements.
# If we do this, these can go away.
setGeneric("groupCommands", function(x, ...) standardGeneric("groupCommands"))
setMethod("groupCommands", "character",
             function(x, ...) {
                 i = names(x) != ""
                 structure(split(x, cumsum(i)), names = names(x)[i])
             })
setMethod("groupCommands", "DevDescPtr",
             function(x, ...) {
                groupCommands(x$deviceSpecific$state)
             })

setMethod("groupCommands", "FlashDeviceMethods",
             function(x, ...) {
                e = environment(x@doc)
                groupCommands(e$commands)
             })
