setClass("FontTable", contains = "list")
setClass("Font", representation(file = "character",
                                name = "character",
                                face = "character",
                                ps = "integer",
                                nickName = "character"))

faceNames = c("default", "plain", "bold", "italic", "bold italic")

Font =
function(file, family, face, ps, nickName = fontVariableName(obj), obj = new("Font"))
{
   if(is.na(file) || !file.exists(file)) {
     file = findFontFile(if(!is.na(file)) file else family)
   }
   
   obj@file = as.character(file)
   obj@name = as.character(family)
   obj@face = if(is(face, "numeric")) faceNames[ face + 1 ] else as.character(face)
   obj@ps = as.integer(ps)
   obj@nickName = as.character(nickName)
   obj
}

fontVariableName =
function(font)
  paste(font@name, font@face, font@ps, sep = "_")

embedFonts =
function(fonts)
{
 sprintf('[Embed(source="%s", fontName = "%s")]\npublic var %s_font:Class;\n',
          sapply(fonts, slot, "file"),
          sapply(fonts, slot, "nickName"),
          gsub(".", "_", sapply(fonts, fontVariableName), fixed = TRUE))
}

setGeneric("fontId",
              function(family, face, ps, cex = 1L)
                 standardGeneric("fontId"))

setMethod("fontId", "character",
            function(family, face, ps, cex = 1L)
              paste(family, face, floor(ps*cex), sep = ";"))

setMethod("fontId", "Font",
            function(family, face, ps, cex = 1L)
                  fontId(family@name, family@face, family@ps, 1L))


lookupFontName =
function(table, family, face, ps, cex = 1L, id = fontId(family, face, ps, cex))
{
  if(id %in% names(table))
    id
  else
    NA
}


setGeneric("addFont", 
            function(table, family, face, ps, file, cex = 1L, id = fontId(family, face, ps, cex))
                standardGeneric("addFont"))

setMethod("addFont", c("FontTable", "Font"),
function(table, family, face, ps, file, cex = 1L, id = fontId(family))
{
  if(missing(id))
     id = fontId(family)
     
  table[[id]] = family
#  cat("Adding", id, "\n")
  table  
})

setMethod("addFont", c("FontTable", "character", "integer", "numeric"),
function(table, family, face, ps, file, cex = 1L, id = fontId(family, face, ps, cex))
{
  addFont(table, Font(file, family, face, ps), id = id)
})


stripExt =
  # Strip the extension from a file name
  # stripExt(c("arial", "arial.ttf", "arial.ttf.jpg"))
function(name)
{
  gsub("(.*)\\.[^.]+", "\\1", name)
}

findFontFile =
  #
  # Searches for a font file.
  #
  #
function(what, dir = getOption("FontDirectory", system.file("Fonts", package = "RFreetype")))
{
  if(what == stripExt(what))
    what = paste(what, ".", sep = "")
  
  for(i in dir) {
      m = grep(what, list.files(i, full = TRUE), fixed = TRUE, val = TRUE)
      if(length(m))
         return(m[1])
  }
  as.character(NA)
}



textFormat =
  #
  # Create the TextFormat() object for rotating and embedding fonts.
  #
function(ps, fontName, varName = "txt.txt")
{
   c("fmt = new TextFormat();",
     paste("fmt.size =", ps, ";"),
     sprintf('fmt.font = "%s";', fontName),
     sprintf("%s.setTextFormat(fmt);", varName))
}
