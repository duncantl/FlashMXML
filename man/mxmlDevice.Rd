\name{mxmlDevice}
\Rdversion{1.1}
\alias{mxmlDevice}
\title{Create a graphics device which renders via Flash}
\description{
 This is a high-level graphics device for R that renders
 the display using compiled Flash generated from 
 commands that this device emits to describe the R plot(s).
}
\usage{
mxmlDevice(file, dim = c(1000, 1000), col = "black", fill = "transparent", ps = 10, 
           top = 0, left = 0,
           template = system.file("RFlash", "template.mxml", package = "FlashMXML"),
           compile = length(file) && !is.na(file),
           wrapup = mxmlWrapup, ...)
}
\arguments{
  \item{file}{the name of a file or a connection object to which the MXML code and ActionScript code is written.
    If this is \code{NULL}, \code{NA} or \code{character}, the actual MXML document is returned and can be further processed
   before being serialized}
  \item{dim}{a numeric vector of length 2 giving the width and height of the graphics device.}
  \item{col}{the "initial" color to use for drawing.}
  \item{fill}{the initial color to use for filling rectangles, circles, polygons, etc.}
  \item{ps}{the initial point size for fonts.}
  \item{top}{the offset (an integer) for the top of the plot relative to
    the Flash application. This can be used to leave space at the top of
    the application for other components.}
  \item{left}{the offset (an integer) for the left side of the plot relative to
    the Flash application. This can be used to leave space at the left side of
    the application for other components.}  
  \item{template}{the template MXML file which will be modified.}
  \item{compile}{a logical value indicating whether to compile the resulting MXML file into a SWF file.
   One might want to defer this step in order to post-process the document.
   If \code{file} is \code{NULL}, \code{NA} or \code{character}, we do
   not compile the MXML document.}
  \item{wrapup}{a function that is called when the device is
    closed. This is responsible for serializing the contents of the
    plot(s) to a file. It can also do further post-processing of the
    plot contents, e.g. add interactivity and animation.
    We can use this parameter to specify a different function that
    creates, for example, an ActionScript file rather than an MXML file.}
  \item{\dots}{additional arguments that are passed on to \code{\link{flash}}.}
}
\value{
 If \code{file} is not \code{NULL}, \code{NA} or \code{character}, the result is an
 \code{XMLInternalDocument} object.

 Otherwise, we return the name of the generated MXML  file if \code{compile} is \code{FALSE}
 and the output from the compiler if \code{compile} is \code{TRUE}.
}
\references{http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/}
\author{Duncan Temple Lang}

\seealso{
 \code{\link{flash}}
 \code{\link{mxmlc}}
}
\examples{
    # don't bother compiling the code
    #  for these examples so we specify compile = FALSE
    # Ordinarily, we wouldn't and the code would also be compiled.

  mxmlDevice("bob.mxml", compile = FALSE)
    plot(1:10)
  dev.off()

   # We can omit the mxml extension.
  mxmlDevice("bob", compile = FALSE) 
    plot(1:10)
    abline(h = c(2, 4, 6))
    abline(v = c(3, 5, 7), col = "lightgrey")
  dev.off()
}
\keyword{device}

