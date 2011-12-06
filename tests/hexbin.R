library(FlashMXML)
if(require(hexbin)) {
   mxmlDevice("hexbin.mxml", compile = !is.null(getOption("mxmlc")))
     x <- rnorm(10000)
     y <- rnorm(10000)
     plot(hexbin(x, y + x*(x+1)/4)) #          main = "(X, X(X+1)/4 + Y)  where X,Y ~ rnorm(10000)")
   dev.off()
}
