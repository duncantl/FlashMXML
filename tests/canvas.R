library(FlashMXML)
dev = mxmlDevice("canvas", baseUIType = "mx.containers.Canvas", compile = FALSE)
plot(1:10)
dev.off()


library(FlashMXML)
dev = mxmlDevice("canvasng", baseUIType = "mx.containers.Canvas", compile = FALSE, noGlobals = TRUE)
plot(1:10)
dev.off()


