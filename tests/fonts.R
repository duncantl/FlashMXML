library(FlashMXML)

dd = mxmlDevice("bob.mxml", compile = FALSE)

plot(1:10)
text(2, 2, "arial string", family = "arial")
text(5, 5, "2x arial string", family = "arial", cex = 2)
text(2, 2, "italic arial string", family = "arial", font = 3)
text(2, 2, "italic-blod arial string", family = "arial", font = 4)

text(2, 2, "rotated arial string", family = "arial", srt = 90)

dev.off()
