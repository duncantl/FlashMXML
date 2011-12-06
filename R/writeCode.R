
setClass("FlashPlotsCode", contains = "list")
setClass("FlashObjectsPlotsCode", contains = "list")

setClass("FlashPlotCode", contains = "character")
setClass("FlashObjectsPlotCode", contains = "character")


fixMXMLFileName =
function(filename)
{
  if(length(grep("\\.", filename)) == 0)
     sprintf("%s.mxml", filename)
  else
     gsub("\\.(xml|swf)", "\\.mxml", filename)
}

setGeneric("createActionScriptPlotFunction",
function(cmds, id = "rdraw", plotVar = "plot")
  standardGeneric("createActionScriptPlotFunction"))

setGeneric("createActionScriptPlotFunction", 
            function(cmds, id = "rdraw", plotVar = "plot")
               standardGeneric("createActionScriptPlotFunction"))           


setGeneric("writeCode",
function(pages, file, imports = FlashImports, funcName = "rdraw", plotVariable = "plot",
           preamble = character(), baseUIType = "UIComponent", noGlobals = is.na(baseUIType), dims = matrix(c(1000, 1000), , 2), ...)
{
  if(length(pages) == 0)
    return(character())
  standardGeneric("writeCode")
})

setMethod("writeCode",  "FlashObjectsPlotsCode",
function(pages, file, imports = FlashImports, funcName = "rdraw", plotVariable = "plot",
          preamble = character(), baseUIType = "UIComponent", noGlobals = is.na(baseUIType),
          dims = matrix(c(1000, 1000), , 2), ...)  
{
    #
    #  The generated ActionScript function returns the array of plot objects.
    #

  if(length(pages) > 1) {
     baseName = funcName
     if(length(funcName) == 1)
         funcName = sprintf("%s%d", funcName, seq(along = pages))

     if(length(plotVariable) == 1 && !is.na(plotVariable))
         plotVariable = sprintf("%s%d", plotVariable, seq(along = pages))     

     initFunc = c(sprintf("public function %s() : void {", baseName),
                  sprintf("   %s(%s);", funcName, plotVariable),
                  "}")
     call = sprintf("%s();", baseName);
  } else {
     initFunc = character()
     baseName = funcName
     call = sprintf("%s(%s);", baseName, plotVariable);
  }
  

  funcDefs = mapply(makePlotFunction, pages, funcName, plotVariable, lapply(1:nrow(dims), function(i) dims[i,]),
                    MoreArgs = list(baseUIType = baseUIType, noGlobals = noGlobals))

  
  tmp=
    c(paste("import", FlashImports, ";"),
      "",
      preamble,
      "", 
      if(!noGlobals && !any(is.na(plotVariable)))
         sprintf("public var %s : %s= new %s();", plotVariable,  baseUIType, baseUIType),
      "",
      funcDefs,
      "",
      initFunc, "")

   writeCode(tmp, file, funcName = funcName, baseUIType = baseUIType, noGlobals = noGlobals, dims = dims, ...)
   call
})


makePlotFunction =
function(code, funcName = "rdraw", plotVariable = "plot", dims = c(1000, 1000), baseUIType = "UIComponent",
           noGlobals = is.na(baseUIType))
{
   c(sprintf("public function %s(plot : %s) : Array {", funcName, baseUIType),
      paste("   ",
            
            c("var ctx : Graphics;",
              "var txt : RText;",  # TextField for the basic device.
              "var tmp : RSprite;",  # Sprite for the basic device
              "var fmt : TextFormat;",
              "var i : int = 0;",
              "var plotObjects : Array = new Array();",
              "var xscale : Number = 1.0;",
              "var yscale : Number = 1.0;",
              sprintf("var originalDims : Array = [%d, %d];", as.integer(dims[1]), as.integer(dims[2])),

               #XXX if only one plot, plotVariable = "plot" and so conflicts with this local one.
               # Get the global variable
              sprintf("if(plot == null) %s", if(noGlobals || plotVariable == "plot")
                                               'Alert.show("Need a UIComponent of some sort on which to plot")'
                                             else
                                               paste("plot =", plotVariable)),
              "",
              "if(plot.width > 0)",
              "   xscale = plot.width/originalDims[0];",
              "if(plot.height > 0)",
              "   yscale = plot.height/originalDims[1];",
              'Alert.show("new scales: " + xscale + ", " + yscale);',
              "",
              code,
              "addChild(plot);",
              "return(plotObjects);"),
            collapse = "\n"),
      "}", "")
}

setMethod("writeCode",  "FlashPlotsCode",
function(pages, file, imports = FlashImports, funcName = "rdraw", plotVariable = "plot", preamble = character(), baseUIType = "UIComponent", noGlobals = is.na(baseUIType), dims = matrix(c(1000, 1000), , 2), ...)  
{
    #
    #  The generated ActionScript function returns the array of plot objects.
    #
  tmp=
    c(paste("import", FlashImports, ";"),
      "",
      preamble,
      "",
      sprintf("public var plot : %s = new %s();", baseUIType, baseUIType),
      "",
      sprintf("public function %s() : Array {", funcName),
      paste("   ",
            
            c("var ctx : Graphics;",
              "var txt : TextField;",  # TextField for the basic device.
              "var tmp : Sprite;",  # Sprite for the basic device
              "var i : int = 0;",
              "var plotObjects : Array = new Array();",              
              pages[[1]],
              "addChild(plot);",
              "return(plotObjects);"),
            collapse = "\n"),
      "}", collapse = "\n")

   writeCode(tmp, file, funcName = funcName, baseUIType = baseUIType, noGlobals = noGlobals, dims = dims, ...)

   funcName  
})



setMethod("writeCode",  "character",
          function(pages, file, imports = FlashImports, funcName = "rdraw", plotVariable = "plot", preamble = character(), baseUIType = "UIComponent", noGlobals = is.na(baseUIType), dims = matrix(c(1000, 1000), , 2), ...) {

            if(is.character(file) && !inherits(file, "AsIs"))
                file = fixMXMLFileName(file)
             cat(pages, sep = "\n", file = file)
             funcName
          })
