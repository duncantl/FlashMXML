####################

mxmlDevice =
  #
  #
  #  if file is NULL, NA, or character(), we return the modified XML document based on template.
  #
function(file, dim = c(1000, 1000), col = "black", fill = "transparent", ps = 10,
          top = 0, left = 0,
          template = system.file("RFlash", "template.mxml", package = "FlashMXML"),
          compile = length(file) && !is.na(file),  wrapup = mxmlWrapup, ...)
{
  flash(file, dim, col, fill, ps, top = top, left = left,  wrapup = wrapup,
          template = template, dims = dim, compile = compile, ...)
}


mxmlWrapup =
  #
  # This function can be used as the value for the wrapup parameter in flashDevice()
  #
  # Arrange for the code to be written to a text connection.
  #
function(pages, file, scripts = character(), dims = c(1000, 1000), 
         template = system.file("RFlash", "template.mxml", package = "FlashMXML"),
         compile = !is.na(file),
         init = character(),
         fonts = list(),
         ...)  
{
    # Write the code for creating the plot to a local text connection.
  con = textConnection(NULL, "w", local = TRUE)
  funNames = writeCode(pages, con, preamble = embedFonts(fonts), ...)
  code = textConnectionValue(con)

    # Read the XML template document into R and update its width and height of the canvas.
  doc = xmlParse(template)
  app = xmlRoot(doc)
  if(missing(init))
     init = funNames
  xmlAttrs(app) = c(initialize = init, width = dims[1], height = dims[2])

  addActionScript(I(code), doc)
  if(length(scripts))
     sapply(scripts, addActionScript)

  if(length(file) == 0 || is.na(file))
     return(doc)

    # If the user didn't specify an extension on the name of the file, then
    # we add .mxml
  if(!inherits(file, "AsIs"))
      file = fixMXMLFileName(file)  

  if(is.na(file))
    return(file)
  
  saveXML(doc, file)
  if(compile)
     mxmlc(file)
  else
     file
}

addActionScript =
  #
  #  add <mx:Script source = 'filename'/> or <mx:Script><![CDATA[ ... ]]></mx:Script>
  # replacing/reusing any empty <mx:Script source=""/> if present.
function(code, doc)
{
  src = getNodeSet(doc, "//mx:Script[@source='']", MXMLns)
  if(length(src) == 0) 
     src = newXMLNode("mx:Script", namespaceDefinitions = MXMLns, parent = xmlRoot(doc))
  else {
     src = src[[1]]
     removeAttributes(src, "source")
  }

  if(inherits(code, "AsIs") || !file.exists(src)) 
     newXMLCDataNode(code, parent = src)
  else
     xmlAttrs(src) = c(source = code)
  src
}


########################
# Compile the mxml to swf.
#

Default.MXMLC.Flags = list("show-actionscript-warnings" = TRUE, "strict" = TRUE)

makeMXMLCFlags =
  #
  # turn a character vector of named values into a set of MXML compiler flags
  #
function(args)
{
   ids = paste("--", names(args), sep = "")
   i = sapply(args, is.logical)
   args[i] = sapply(args[i], function(x) if(x) "true" else "false")
   paste(ids, unlist(args), sep = "=", collapse = " ")
}


makeMXMLCLibs =
  # build the library-path and compiler.source-path options for the MXML compiler
function(src = RFlashDir,
         libs = character(), defaultLibs = paste(FlexInstallation, "lib", sep = .Platform$file.sep))
{
  paste(paste("-library-path", path.expand(c(libs, defaultLibs)), sep = "+="),
        paste("-compiler.source-path", path.expand(src), sep = "+="))
}


compileFlash = mxmlc =
  #
  # Compile an mxml file to a swf file.
  #
function(file, src = RFlashDir, flags = Default.MXMLC.Flags, libs = character(),  mxmlc = mxmlcCommand)
{
  if(!missing(mxmlc) && is.null(mxmlc))
    mxmlc = getOption("mxmlc")
  
  if(is.null(mxmlc))
     stop("you must specify the name of the mxmlc compiler on your system.")
  
  flags = makeMXMLCFlags(flags)
  libs = makeMXMLCLibs(src, libs)
  cmd = paste(mxmlc, flags, libs, "-file-specs", file)

  val = system(cmd, intern = TRUE)
}
