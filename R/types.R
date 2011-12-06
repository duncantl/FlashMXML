
setClass("FlashLineCaps", contains = "character")
setClass("FlashLineJoin", contains = "character")

setAs("numeric", "FlashLineCaps",
       function(from) {
         new("FlashLineCaps", c("ROUND", "NONE", "SQUARE")[from])
       })

setAs("numeric", "FlashLineJoin",
       function(from) {
         new("FlashLineJoin", c("ROUND", "MITER", "BEVEL")[from])
       })
