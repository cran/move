\name{burstId}

\alias{burstId}
\alias{burstId<-}
\alias{burstId,MoveBurst-method}
\alias{burstId,.MoveTrackSingleBurst-method}
\alias{burstId<-,.MoveTrackSingleBurst,factor-method}
\alias{burstId<-,.MoveTrackSingleBurst,character-method}

\docType{methods}

\title{Returns burstId}

\description{Obtain a factor returning the ids of behavioral categorization per segment}

\usage{
  \S4method{burstId}{MoveBurst}(x)
  \S4method{burstId}{.MoveTrackSingleBurst,factor}(x)<-value

}

\arguments{
  \item{x}{a MoveBurst object}
  \item{value}{Replacement values for the burst factor, either a factor or a character}
}

\value{
	Returns a factor indicating the categorization
}

\author{Bart Kranstauber}

\examples{
data(leroy)
burstTrack <- burst(leroy,months(timestamps(leroy))[-1])
burstId(burstTrack)
}
