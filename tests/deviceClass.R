library(FlashMXML)

dev = mxmlDevice(NA, compile = FALSE)

class(dev)

class(dev$deviceSpecific$state)
dev$deviceSpecific$state@doc

plot(1:10)

 # If we don't grab the object, it _seems_
 # to be gc'ed.
ss = dev$deviceSpecific$state

dev.off()

  # Crashes for now unless we grab the state. 
  # Perhaps grab the state object before
  # the dev.off().
dev$deviceSpecific$state@doc()


