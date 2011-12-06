library(FlashMXML)
mxmlDevice('link.mxml', compile = !is.null(getOption("mxmlc")))
  plot(1:10 , xlab = "http://www.r-project.org", main = "http://www.omegahat.org/FlashMXML")
     # put text on the plot and the device will detect it is a link
     # and make it clickable.
     # If we use cex = 3, the R text handler method is not invoked.
  text(2, 5, "http://www.google.com", col = "red") #, cex = 3)
dev.off()


