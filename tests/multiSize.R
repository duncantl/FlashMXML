library(FlashMXML)

mxmlDevice("multiSize.mxml",
           matrix(c(1000, 800, 500, 400, 500, 400), , 2, byrow = TRUE),
           compile = FALSE)

x = rnorm(100)
y = 3 + 10 * x + rnorm(length(x))

plot(x, y)
hist(x)
hist(y)

dev.off()


