\name{UDStack}
\alias{UDStack}
\alias{UDStack,RasterBrick-method}
\alias{UDStack,list-method}
\alias{UDStack,RasterStack-method}
\alias{UDStack,.UDBurstStack-method}

\title{Creating UDStack objects}
\description{The function enables the easy generation of .UDStacks, which is forexample useful for using other UD function such as \code{getVolumeUD}.}
\usage{
UDStack(x,...)
}
\arguments{
  \item{x}{A list or raster brick/stack that needs to be converted to a .UDStack object. Alternative a burst stack, in this case the layers are standardized.}
  \item{...}{Currently not used}
}
\value{An UDStack}
\author{Bart Kranstauber}

\examples{
data(dbbmmstack)
stk<-as(dbbmmstack,"RasterStack")
UDStack(stk)
lst<-split(dbbmmstack)
UDStack(lst)
}
