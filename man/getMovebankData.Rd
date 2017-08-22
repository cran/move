\name{getMovebankData}

\alias{getMovebankData}
\alias{getMovebankData,ANY,ANY,MovebankLogin-method}
\alias{getMovebankData,ANY,ANY,missing-method}
\alias{getMovebankData,character,ANY,MovebankLogin-method}
\alias{getMovebankData,numeric,character,MovebankLogin-method}
\alias{getMovebankData,numeric,missing,MovebankLogin-method}
\alias{getMovebankData,numeric,numeric,MovebankLogin-method}

\docType{methods}

\title{Download data from Movebank}

\description{This function downloads the location data and timestamp of a study stored in Movebank}

\usage{
\S4method{getMovebankData}{numeric,character,MovebankLogin}(study, animalName, login, ...)

\S4method{getMovebankData}{numeric,numeric,MovebankLogin}(study, animalName, login, 
                removeDuplicatedTimestamps=FALSE,
                includeExtraSensors=FALSE, deploymentAsIndividuals=FALSE, ...)
}

\arguments{
  \item{study}{character or numeric. Character: full name of the study, as stored on Movebank. Numeric: \emph{Movebank ID} of the study which can be obtained on the \emph{Study Details} page on Movebank or with \code{\link{getMovebankID}}.}
  \item{login}{a \code{\link[=MovebankLogin-class]{MovebankLogin}} object, if empty you'll be asked to enter your username and password}
  \item{animalName}{character. Name of the individuals as stored on Movebank. A single individual or a vector of several individuals from the same study can be specified. Optional.}
  \item{includeExtraSensors}{logical; if TRUE data from non location sensors included in the study will be also downloaded, the data will automatically be stored in the unUsedRecords slot as they cannot produce locations. See 'Details'.}
  \item{removeDuplicatedTimestamps}{logical; if TRUE duplicated timestamps values will be removed. See 'Note'.}
  \item{deploymentAsIndividuals}{logical; if TRUE the deployments will be downloaded separately. See 'Details'.}
  \item{...}{Additional arguments passed on to the movebank API through \code{\link{getMovebank}} function: 
  \describe{
  \item{\code{timestamp_start, timestamp_end}}{character or POSIXct. Starting and/or ending timestamp to download the data for a specific time period. Timestamps have to be provided in format 'yyyyMMddHHmmssSSS'. If POSIXct then it is converted to character using UTC as a time zone, note that this can change the time. Optional.}
  }
  }
}

\details{
\code{getMovebankData} belongs to the Movebank browsing functions and returns a \link[=Move-class]{Move} object from studies with only one animal or a \link[=MoveStack-class]{MoveStack} object for studies with multiple animals.\cr
Remember that you need an account on \href{http://www.movebank.org}{Movebank}, see \link{movebankLogin}.

\emph{Attribute names:}\cr
The definitions of the content of the columns within the @idData, @sensor, @data slots of the move or moveStack object is detailed in the \href{http://www.movebank.org/node/2381}{Attribute Dictionary on Movebank}

\code{includeExtraSensors:}\cr
If this \code{includeExtraSensors=TRUE} the data of all non location sensors (e.g. acceleration, magnetometer, etc) available in the study will be downloaded and stored in the unUsedRecords slot. Data from a single or a set of non location sensors can be also downloaded as a \code{data.frame} with the function \link{getMovebankNonLocationData}

\code{deploymentAsIndividuals:}\cr
If single individuals have several deployments, and these are wished to be downloaded separately, this can be done by setting \code{deploymentAsIndividuals=TRUE}. In this case the "@trackId" will contain the names of the deployments.
}

\note{
See the 'browseMovebank' vignette for more information about security and how to use Movebank from within R.

\code{removeDuplicatedTimestamps:}\cr
It is possible to set \code{removeDuplicatedTimestamps=TRUE} which allows you delete the duplicated timestamps in case your data set contains them. It is strongly advised not to use this option because there is no control over which records are removed. It's better to edit the records in movebank and mark the appropriate records as outliers. Another option is to download the data as a .csv file from Movebank, use the \code{\link{getDuplicatedTimestamps}} function to identify the duplicate timestamps, decide which one to keep and than create a move/moveStack object with the function \link{move}.

\emph{Outliers:}\cr
In Movebank outliers can be marked manually. When the move object is creates via \code{getMovebankData} these records are automatically placed in the UnusedRecords slots. If these marked outliers want to be included in the move object, download the data from \href{http://www.movebank.org}{Movebank} (or via \code{\link{getMovebank}}), read in the data from the downloaded .csv file with \code{read.csv}, and create the move object with \link{move} providing the columns with the coordinates, timestamp, data.frame, projection, sensor and animal name. This way the marked outliers are ignored and all data are included in the move object.

\emph{Multiple sensors:}\cr
The \code{getMovebankData} function downloads the data of all location sensors available in the study. If the study contains several location sensors, the resulting move/moveStack object can be separated into a move/moveStack object per sensor type: \cr
\code{ x[x@sensor=="z"]} where "x" is a Move or a MoveStack object, and "z" is the name of the sensor e.g. "GPS", "Radio Transmitter", etc.\cr
}

\value{
Object of class '\link[=Move-class]{Move}' or '\link[=MoveStack-class]{MoveStack}'
     
}

\author{Marco Smolla & Anne Scharf}

\seealso{\link{movebankLogin}, \link{getMovebankNonLocationData}}

\examples{
\dontrun{
# obtain a login
login<-movebankLogin()

# returns a MoveStack object from the specified study
getMovebankData(study="BCI Ocelot", login=login) 

# returns a Move object (there is only one individual in this study)
getMovebankData(study="BCI Agouti", login=login) 

# returns a MoveStack with two individuals
getMovebankData(study=123413, animalName=c("Mancha","Yara"), login=login) 

# Get a specific timerange, eg: all positions untill "2003-05-06 19:45:10.000"
(ocelots <- getMovebankData(study=123413, animalName=c("Mancha","Yara"), 
                            login=login, timestamp_end="20030506194510000"))

timestamps(ocelots)
}
}
