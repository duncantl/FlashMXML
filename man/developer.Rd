\name{writeCode}
\alias{writeCode}
\alias{writeCode,character-method}
\alias{writeCode,FlashObjectsPlotsCode-method}
\alias{writeCode,FlashPlotsCode-method}

\alias{coerce,character,RGBStrict-method}
\alias{coerce,integer,RGBStrict-method}
\alias{coerce,integer,RGBStrict-method}
\alias{coerce,numeric,FlashLineCaps-method}
\alias{coerce,numeric,FlashLineJoin-method}
\alias{coerce,RGB,RGBStrict-method}

\title{Functions, methods and classes for implementing the Flash device}
\description{
 Here we document some of the R functions, methods and classes that
 we use to implement the Flash graphics devices. The aim is to 
 inform others who may want to extend the implementation/prototype.
}
\usage{
writeCode(pages, file, imports = FlashImports, funcName = "rdraw", plotVariable = "plot",
           preamble = character(), baseUIType = "UIComponent",
            noGlobals = is.na(baseUIType), dims = matrix(c(1000, 1000), , 2), ...)
}
\arguments{
 \item{pages}{essentially a list with an element for each separate display.
   Each element is a character vector containing the lines of the ActionScript code.
  }
 \item{file}{a file name or connection to which the generated code will be written}
 \item{imports}{names of flash classes or packages that will be 'import'ed at the beginning of the code}
 \item{funcName}{the name of the function(s) to create}
 \item{plotVariable}{a character string giving the name of the
   ActionScript variable to use for the user interface component
   (mx.core.UIComponent).
   If more than one plot is created, this is used as the prefix and the
   plot number is appended, e.g. "plot1", "plot2", ...}
 \item{preamble}{a character string (or vector) giving ActionScript code
   that is inserted into the generated ActionScript after the
   initial imports and before any of the code for the generated plots.
   This gives the creator an opportunity to add additional code, e.g.
   add callbacks, etc.}
 \item{baseUIType}{a string giving the name of the ActionScript class to
   use in declaring the type of object on which the plot will be drawn.}
 \item{dims}{the dimensions for the canvas on which we draw, in pixel units}
 \item{noGlobals}{a logical value that controls whether we declare
   global (non-local) variables in the ActionScript code that will
   be used as the canvas/component for each of the plots.
   If this is \code{FALSE}, the functions for each plot will create
   their own canvas, or the caller must pass the previously created
   component.
   This leaves the caller to arrange how the plots are created and layed out.
 }
 \item{\dots}{additional parameters for methods}
}
\references{}
\author{Duncan Temple Lang}
\seealso{}
\examples{
}
\keyword{device}
