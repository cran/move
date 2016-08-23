\name{emd}

\alias{emd}
\alias{emd,RasterLayer,RasterLayer-method}
\alias{emd,RasterStackBrick,missing-method}
\alias{emd,RasterStackBrick,RasterStackBrick-method}
\alias{emd,SpatialPoints,SpatialPoints-method}

\docType{methods}

\title{Earth movers distance}

\description{Calculates the disimilairty, measured as the earth movers distance.}

\usage{
  \S4method{emd}{SpatialPoints,SpatialPoints}(x,y, gc = FALSE, threshold = NULL,...)
  \S4method{emd}{RasterLayer,RasterLayer}(x,y, ...)
}

\arguments{
  \item{x}{A Raster, Raster stack/brick or SpatialPoints object, it is also possible to provide UD objects. In case of spatial points data frame the first columns of data is used as weights. In case of SpatialPoints all points are weighted equally.}
  \item{y}{A Raster or SpatialPoints.}
  \item{gc}{True if great circle distances should be used.}
  \item{threshold}{The maximal distance over which locations are compaired.}
  \item{...}{Currently not used}
}

\value{An \code{dist} object is returned}

\author{Bart Kranstauber}
\references{Kranstauber, B., Smolla, M., Safi,K., Similarity in spatial utilization distributions measured by the Earth Mover's Distance.}

\examples{
  data(dbbmmstack)
  values(dbbmmstack)[values(getVolumeUD(dbbmmstack))>.999999]<-0
  stk<-(dbbmmstack/cellStats(dbbmmstack,sum))
  emd(stk[[1]],stk[[2]])
  emd(stk)
  emd(stk, threshold=10000)
  x<-SpatialPointsDataFrame(cbind(c(1:3,5),2), data=data.frame(rep(.25,4)))
  y<-SpatialPointsDataFrame(coordinates(x), data.frame(c(0,.5,.5,0)))
  emd(x,y)
  emd(x,y,threshold=.1)
}
