\name{ricky}

\alias{ricky}

\docType{data}

\title{GPS track data from a fisher}

\description{This file includes spatial data from a fisher (\emph{Martes pennanti}). It can be used to test the different functions from the move package. \cr 
These location data were collected via a GPS tracking collar (manufactured by E-obs GmbH) and programmed to record locations depending on the animal's behavior (up to a one location every two minutes). The collar was deployed on an adult, resident, male fisher, in New York, USA (see References). The data usage is permitted for exploratory purposes. For other purposes please get in contact.}

\usage{data("ricky")}
\format{An object of the class move
}
\source{
https://www.datarepository.movebank.org/handle/10255/move.330
}
\references{
For more information, contact Scott LaPoint \email{sdlapoint@gmail.com}
}

\examples{
## get Move object and plot the track
data(ricky)
plot(ricky)

}

\author{Scott LaPoint}
