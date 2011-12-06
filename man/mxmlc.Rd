\name{mxmlc}
\Rdversion{1.1}
\alias{mxmlc}
\alias{compileFlash}
\title{Compile an MXML file to a SWF file}
\description{
 This is an R function that allows us to call the installed Flash/Flex/MXML compiler.
 We can specify various different compiler options, including where to look for 
 ActionScript code and libraries.
 
 \code{compileFlash} and \code{mxmlc} are just different names for the same function.
}
\usage{
mxmlc(file, src = RFlashDir, flags = Default.MXMLC.Flags, libs = character(), mxmlc = mxmlcCommand)
compileFlash(file, src = RFlashDir, flags = Default.MXMLC.Flags, libs = character(), mxmlc = mxmlcCommand)
}
\arguments{
  \item{file}{the name of the file to compile. This should be an .mxml file}
  \item{src}{a character vector giving the names of directories which should be added to where the compiler searches for 
   ActionScript code referenced in the MXML code and scripts.}
  \item{flags}{flags for the Flash compiler}
  \item{libs}{a character vector of directory names specifying where to find already compiled Flash/Flex/ActionScript libraries}
  \item{mxmlc}{the command to invoke the Flash compiler. We try to
    determine this at installation time when installing the package from
    source.  You can also set the value via an option
    \code{options(mxmlc = "/path/to/mxmlc").}
    }
}
\value{
 A character vector giving the output from the compilation.
}
\references{}
\author{Duncan Temple Lang}
\note{}

\seealso{
 \code{\link{mxmlDevice}}
 \code{\link{flash}}
}
\examples{


}
\keyword{hplot}
\keyword{device}
