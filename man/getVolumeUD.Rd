\name{getVolumeUD}

\alias{getVolumeUD}
\alias{getVolumeUD,.UD-method}
\alias{getVolumeUD,.UDStack-method}

\docType{methods}

\title{Modify a UD raster}

\description{Modifies the UD raster: that the cell values of the resulting raster are equal to the percentage of the smallest home range containing this cell.}

\usage{
  \S4method{getVolumeUD}{.UD}(x, ...)
}

\arguments{
  \item{x}{a \code{DBBMM}, \code{DBBMMStack}, \code{dynBGB}, \code{.UD} or \code{.UDStack} object}
  \item{...}{when \code{x} is of class DBBMM or dynBGB, several objects of class DBBMM or dynBGB can be added (see 'Examples')}
}

\note{
To obtain this modified UD raster from a \code{DBBMMBurstStack} object, transform the object with the \link{UDStack} function into a '.UDStack' class, and than use the \code{getVolumeUD} function upon the obtained object.
}

\value{
'\code{raster}' or '\code{rasterStack}' \cr
If several objects are provided, a list of rasters is returned
}

\author{Marco Smolla & Anne Scharf}

\seealso{
\code{\link{raster2contour}}
}

\examples{
data(leroydbbmm)
data(dbbmmstack)
data(leroydbgb)
getVolumeUD(leroydbbmm) # for a DBBMM object
getVolumeUD(dbbmmstack) # for a DBBMMStack object 
getVolumeUD(leroydbgb) # for a dynBGB object 

getVolumeUD(leroydbbmm, leroydbgb) # for several objects 

plot(getVolumeUD(leroydbbmm))

## e.g. select the raster corresponding to the 95\% UD
leroyUD <- getVolumeUD(leroydbbmm)
leroyUD[leroyUD>0.95] <- NA
plot(leroyUD)

}
