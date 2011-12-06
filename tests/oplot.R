library(FlashMXML)
mxmlDevice("plot.mxml", compile = !is.null(getOption("mxmlc")))
  plot(1:10)
dev.off()

