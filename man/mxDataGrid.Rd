\name{mxDataGrid}
\Rdversion{1.1}
\alias{mxDataGrid}
\alias{XMLList}
\alias{coerce,vector,XMLArrayCollection}
\alias{coerce,data.frame,XMLList-method}
\alias{coerce,vector,XMLArrayCollection-method}
\title{Represent R objects in MXML}
\description{
 This the start of a collection of functions that 
 convert R objects to a representation in MXML so that
 the data can be used with Flash applications.
}
\usage{
mxDataGrid(val, attrs = character(), rownames = "id")
}
\arguments{
  \item{val}{a data frame (or matrix with column names) which is
    serialized as a data provider.}
  \item{attrs}{a vector of attributes to place in the new XML
    mx:DataGrid node. These might specify an id for the new component,
   the width or height,  an ActionScript code segment for an event
   handler, and so on.}
  \item{rownames}{either a character string giving the name of the
    variable to use in the data frame to represent the row names
    or an empty character vector to indicate that the row names should
    not be displayed.
    This can also be a logical value with \code{TRUE} indicating that
    they should be displayed and we use the variable name "id",
    or \code{FALSE} indicating to not display the row names.
  }
}
\details{
}
\value{
   An invisible XMLInternalNode which can be added to an MXML document.
}
\references{
 \url{http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/fl/controls/DataGrid.html}  
}
\author{Duncan Temple Lang}

\seealso{}
\examples{
  print(mxDataGrid(mtcars))
}
\keyword{data}
