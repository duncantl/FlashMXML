library(FlashMXML)
z = mxmlDevice('link.mxml', compile = FALSE)
z$deviceSpecific$circle
z$deviceSpecific$activate
z$deviceSpecific$mode
z$deviceSpecific[["mode"]]

as(z$deviceSpecific, "RDevDescMethods")

