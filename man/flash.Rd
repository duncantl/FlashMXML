\name{flash}
\Rdversion{1.1}
\alias{flash}
\title{ActionScript Graphics Device}
\description{
 This graphics device is the one responsible for generating
ActionScript code that displays R plots in Flash based on high-level graphics objects
within Flash.  

 We typically use \code{\link{mxmlDevice}} to generate and compile an entire Flash application that can be viewed
directly or in a Web browser.
}
\usage{
flash(file, dim = c(1000, 800), col = "black", fill = "transparent",
      ps = 10, font = Font(findFontFile("arial.ttf"), "arial", 1, ps),
      wrapup = writeCode, top = 0, left = 0, ...,
      funs = dummyDevice( obj = new("FlashDeviceMethods")))
}
\arguments{
  \item{file}{to where the generated code should be written. This can be the name of a local file,
     or a connection.}
  \item{dim}{a numeric vector of length 2 giving the width and height of the graphics device.}
  \item{col}{the "initial" color to use for drawing.}
  \item{fill}{the initial color to use for filling rectangles, circles, polygons, etc.}
  \item{ps}{the initial point size for fonts.}
  \item{font}{a \code{Font} object specifying the default font to use in
     the plot(s).}
  \item{wrapup}{a function that is called when the device is closed. This is invoked with a
   list with an element for each of the generated plots and each element is a character vector containing 
   the generated code. The second argument is \code{file}.  The \dots collection for this 
   function is also  passed to provide additional customization
   parameters.}
  \item{top}{the offset (an integer) for the top of the plot relative to
    the Flash application. This can be used to leave space at the top of
    the application for other components.}
  \item{left}{the offset (an integer) for the left side of the plot relative to
    the Flash application. This can be used to leave space at the left side of
    the application for other components.}
  \item{\dots}{additional parameters passed directly to \code{wrapup}.}
  \item{funs}{a collection of functions that provide implementation for
    the methods of the graphics device for drawing, e.g., circles,
    lines, text, polygons, etc.  This an object of class
    \code{FlasDeviceMethods}, or derived from \code{RDevDescMethods} at least.}
}
\details{
}
\value{
 A reference to the C-level device. This is an object of class
 \code{\link[RGraphicsDevice]{DevDescPtr-class}}.
}
\references{}
\author{Duncan Temple Lang}

\seealso{
 \code{\link{mxmlDevice}}
}
\examples{
 flash("bob.as")
   plot(1:10)
 dev.off()
}
\keyword{device}

