\name{move}

\alias{move}
\alias{move,character,missing,missing,missing,missing-method}
\alias{move,connection,missing,missing,missing,missing-method}
\alias{move,ltraj,missing,missing,missing,missing-method}
\alias{move,numeric,numeric,POSIXct,data.frame,character-method}
\alias{move,numeric,numeric,POSIXct,data.frame,CRS-method}
\alias{move,numeric,numeric,POSIXct,data.frame,missing-method}
\alias{move,numeric,numeric,POSIXct,missing,ANY-method}

\docType{methods}

\title{
Create a Move object
}

\description{
This function creates \code{Move} or \code{MoveStack} object from a .csv file with location data downloaded from a Movebank study, from a zip file downloaded from the EnvData (environmental annotation tool) of a Movebank study, from a \code{\link[adehabitatLT]{ltraj}} object or from own data. If you use your own data you need to set the projection method with the 'proj' argument and specify which columns of your data contain the coordinates and timestamps. 
}

\usage{
\S4method{move}{connection,missing,missing,missing,missing}(x, removeDuplicatedTimestamps=F, ...)

\S4method{move}{ltraj,missing,missing,missing,missing}(x, y, time, data, proj,...)

\S4method{move}{numeric,numeric,POSIXct,data.frame,CRS}(x, y, time, data, proj, sensor='unknown',animal='unnamed',...)

}

\arguments{
\item{x}{full path to the csv (or compressed) file location downloaded from a Movebank study, OR to the zip file location downloaded from the EnvData tool in Movebank. \cr
a \code{\link[adehabitatLT]{ltraj}} object from adehabitatLT.\cr
numeric vector with x coordinates if non-Movebank data are provided (e.g. \code{data$x}).}
\item{y}{numeric vector with y coordinates if non-Movebank data are provided (e.g. \code{data$y}).}
\item{time}{vector of time stamps with POSIXct conversion if non-Movebank data are provided, i.e. \code{as.POSIXct(data$timestamp, format="\%Y-\%m-\%d \%H:\%M:\%S", tz="UTC")}}
\item{data}{extra data associated with the relocations, if empty it is filled with the coordinates and timestamps. Optional.}
\item{proj}{projection method for non-Movebank data; requires a valid CRS (see \code{\link{CRS-class}}) object, e.g. CRS("+proj=longlat +ellps=WGS84"); default is NA. Optional.}
\item{sensor}{Sensor name(s), either single character or a vector with length of the number of coordinates. If multiple sensors are provided this has to be done as a vector with the same length as the number of coordinates. Optional.}
\item{animal}{animal ID(s) or name(s), either single character or a vector with length of the number of coordinates. If multiple individuals are provided this has to be done as a vector with the same length as the number of coordinates. Optional.}
\item{removeDuplicatedTimestamps}{logical; if TRUE duplicated timestamps values will be removed. It is strongly advised not to use this option because there is no control over which records are removed. We recommend to manually edit the duplicated timestamps with \code{\link{getDuplicatedTimestamps}} or edit the records in Movebank.}
\item{...}{Additional arguments}  
}

\details{
The easiest way to import data is to download the study you are interested in from \url{www.movebank.org} and set the file path as the x argument of the move function. The function detects whether there are single or multiple individuals in this file and automatically creates either a \code{\link[=Move-class]{Move}}, \code{\link[=MoveStack-class]{MoveStack}} object. See the 'browseMovebank' vignette for more information on how to directly download data from Movebank from within R.\cr 

Another way is to read in your data using \code{\link{read.csv}}. Then specify the arguments "x" and "y" the columns of your data containing the x and y coordinates, in the argument "time" the column containing the timestamp, optionally the columns containing the information of the sensor(s) used, the animal name(s) and the projection, as well as the whole \code{data.frame} of the imported data. If the argument "animal" is left empty or contains only the name of one animal the function will return a \code{\link[=Move-class]{Move}} object. If the data contains multiple animal names the function will return a \code{\link[=MoveStack-class]{MoveStack}} object.
}

\note{

It is checked whether the imported data set (via file path) is in a Movebank format. If your data isn't in a Movebank format, you have to use the alternative import for non-Movebank data reading in your data using \code{\link{read.csv}} and specifying which columns contain the needed information (see 'Details'). 

\emph{Locations with "NA":} \cr
Because the \code{SpatialPointsDataFrame} function that creates the spatial data frame of the \code{Move} object can not process NA location values, all rows with NA locations are stored as unused records in the Move object. 

\emph{Duplicated timestamps:}\cr
If the data include double timestamps you can use the \code{\link{getDuplicatedTimestamps}} function to identify them and then decide which one to keep before creating the Move object. When you are importing data from movebank (via path to .csv or .zip file) you can also set the argument "\code{removeDuplicatedTimestamps=TRUE}", but this does no attempt to retain the most likely location.

\emph{Naming:}\cr
Due to convention all names are turned into 'good names' which means, without spaces ('Ricky T' becomes 'Ricky.T'), if names are numbers a "X" will be prepended ('12345' becomes 'X12345') and most symbols will be replaced by "." ('Ricky-T' becomes 'Ricky.T').

\emph{Outliers:}\cr
In Movebank outliers can be marked manually. When the move object is created by providing the path to the file downloaded from Movebank, these records are automatically placed in the UnusedRecords slots. If these marked outliers want to be included in the move object, read in the data from the downloaded csv file from movebank with \code{read.csv}, and create the move object providing the columns with the coordinates, timestamp, data.frame, projection, sensor and animal name. This way the marked outliers are ignored and all data are included in the move object.

\emph{Multiple sensors:}\cr
If a move/moveStack object contains multiple sensors, this object can be separated into a move/moveStack object per sensor type: \cr
\code{ x[x@sensor=="z"]} where "x" is a Move or a MoveStack object, and "z" is the name of the sensor e.g. "GPS", "Radio Transmitter", etc.
}

\value{returns an object of class '\code{\link[=Move-class]{move}}' or '\code{\link[=MoveStack-class]{moveStack}}'.

If data of Movebank are used, the definitions of the content of the columns within the @idData, @sensor, @data slots of the move or moveStack object is detailed in the \href{http://www.movebank.org/node/2381}{Attribute Dictionary on Movebank}

When the move or moveStack is created providing a path to a .csv or .zip file downloaded from Movebank the coordinates in the @coords slot are named "location.long" and "location.lat". When the move or moveStack is created by providing a \code{data.frame}, the coordinates in the @coords slot are named "coords.x1" and "coords.x2".
}


\author{Marco Smolla, Bart Kranstauber & Anne Scharf}

\examples{
## create a move object from a Movebank csv file
filePath<-system.file("extdata","leroy.csv.gz",package="move")
data <- move(filePath)

## create a move object from non-Movebank data
file <- read.table(filePath, header=TRUE, sep=",", dec=".")
data <- move(x=file$location.long, y=file$location.lat, 
	     time=as.POSIXct(file$timestamp, format="\%Y-\%m-\%d \%H:\%M:\%S", tz="UTC"), 
	     data=file, proj=CRS("+proj=longlat +ellps=WGS84"), 
	     animal="Leroy", sensor="GPS")
plot(data, type="b", pch=20)

## if the data contain multiple individuals a moveStack will be created
fishersPath<-system.file("extdata","fishersSubset.csv.gz",package="move")
fishersSubset <- read.table(fishersPath, header=TRUE, sep=",", dec=".")
data2 <- move(x=fishersSubset$location.long, y=fishersSubset$location.lat, 
             time=as.POSIXct(fishersSubset$timestamp,format="\%Y-\%m-\%d \%H:\%M:\%S", tz="UTC"), 
             data=fishersSubset, proj=CRS("+proj=longlat +ellps=WGS84"),
             animal=fishersSubset$individual.local.identifier,
             sensor=fishersSubset$sensor)
plot(data2, type="b", pch=20, col=c("green","blue")[data2@idData$individual.local.identifier])
plot(data2[[2]], type="l")

\dontshow{
move(x=1:10,y=1:10,time=as.POSIXct(1:10, origin='1970-1-1'),proj=CRS('+proj=longlat +ellps=WGS84'))
move(x=1:10,y=1:10,time=as.POSIXct(c(1:5,1:5), origin='1970-1-1'),proj=CRS('+proj=longlat +ellps=WGS84'), animal=c(rep('a',5),rep('b',5)))}
}
