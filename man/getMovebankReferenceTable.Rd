\name{getMovebankReferenceTable}

\alias{getMovebankReferenceTable}
\alias{getMovebankReferenceTable,ANY,MovebankLogin-method}
\alias{getMovebankReferenceTable,numeric,MovebankLogin-method}
\alias{getMovebankReferenceTable,character,MovebankLogin-method}
\alias{getMovebankReferenceTable,ANY,missing-method}

\docType{methods}

\title{Download all reference data of a Movebank study}

\description{This function returns the information of the animals, tags, deployments and sensors from a Movebank study}
\usage{
getMovebankReferenceTable(study, login)
}

\arguments{
   \item{study}{character or numeric. Character: full name of the study, as stored on Movebank. Numeric: \emph{Movebank ID} of the study which can be obtained on the \emph{Study Details} page on Movebank or with \code{\link{getMovebankID}}.}
  \item{login}{a \code{\link[=MovebankLogin-class]{MovebankLogin}} object, if empty you'll be asked to enter your username and password}
}
\details{
\code{getMovebankReferenceTable} belongs to the Movebank browsing functions and returns a \code{data.frame} from the requested study, including all data provided by the user referring to the animals, tags and deployments. It also includes \code{animal_id, tag_id, deployment_id, sensor_type_id, study_id} which are the internal ids of Movebank. This table is equivalent to the table obtained on the Movebank webpage trough the option "Download Reference Data" of the study.
}

\note{
See the 'browseMovebank' vignette for more information about security and how to use Movebank from within R.
}

\value{
'\code{data.frame}'
}

\author{
Anne Scharf
}

\seealso{\code{\link{movebankLogin}}}
\examples{
\dontrun{

# obtain a login
login <- movebankLogin()
getMovebankReferenceTable(study=74496970, login=login)[1:6,]
}
}
