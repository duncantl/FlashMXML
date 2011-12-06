\name{flashDevice}
\Rdversion{1.1}
\alias{flashDevice}
\title{A basic Flash Graphics Device for R}
\description{
 This is a simpler, more basic Flash graphics device for R
 than \code{\link{mxmlDevice}}, but identical in how we use it.
 This generates ActionScript code that creates Sprite
 objects and draws the shapes directly.  This is different
 from the \code{\link{mxmlDevice}} which generates objects that
 have the coordinates of the elements to be displayed and 
 draw these themselves.

 See \code{\link{flash}} for details about the parameters.
}
\usage{
flashDevice(file, dim = c(1000, 800), col = "black", fill = "transparent", ps = 10, wrapup = writeCode, ...)
}
\arguments{
  \item{file}{the name of the file to which the generated Flash MXML and
    ActionScript code   should be written}
  \item{dim}{an integer vector of length 2 giving the width and height
    for the drawing canvas, in pixel units}
  \item{col}{the default drawing color}
  \item{fill}{the color for the background of the canvas}
  \item{ps}{the default point size for the fonts}
  \item{wrapup}{a function that is called when the device is
    closed. This performs the final operations to create the code,
    allowing the possibility of post-processing the code}
  \item{\dots}{additional parameters passed in the call to \code{wrapup}.}
}
\value{
  Invisibly returns the new device.
}
\references{}
\author{Duncan Temple Lang}

\seealso{ 
 \code{\link{flash}}
 \code{\link{mxmlDevice}}
}
\examples{
  flashDevice("foo.as")
    plot(1:10)
  dev.off()
}
\keyword{device}

