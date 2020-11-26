## ---- echo=FALSE, include=FALSE-----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE)

## ---- eval=F------------------------------------------------------------------
#  library("move")
#  loginStored <- movebankLogin(username="user", password="password")

## ---- eval=F------------------------------------------------------------------
#  searchMovebankStudies(x="oose", login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankID("BCI Ocelot",login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankStudy(study="BCI Ocelot",login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankSensors(study="BCI Ocelot",login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankSensors(login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankSensorsAttributes(study="BCI Ocelot",login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankAnimals(study="BCI Ocelot",login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  getMovebankReferenceTable(study="BCI Ocelot",login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  bci_ocelot <- getMovebankData(study="BCI Ocelot", login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  # for one individual
#  bobby <- getMovebankData(study="BCI Ocelot", animalName="Bobby", login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  # for several individuals
#  ocelot2ind <- getMovebankData(study="BCI Ocelot", animalName=c("Bobby","Darlen"), login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  # download all data between "2003-03-22 17:44:00.000" and "2003-04-22 17:44:00.000"
#  bci_ocelot_range1 <- getMovebankData(study="BCI Ocelot", login=loginStored,
#                                       timestamp_start="20030322174400000",
#                                       timestamp_end="20030422174400000")
#  
#  # alternative:
#  t <- strptime("20030322174400",format="%Y%m%d%H%M%S", tz='UTC')
#  bci_ocelot_ranget <- getMovebankData(study="BCI Ocelot", login=loginStored,
#                                       timestamp_start=t,
#                                       timestamp_end=t+as.difftime(31,units='days'))

## ---- eval=F------------------------------------------------------------------
#  # download all data before "2003-07-24 20:00:00.000"
#  bci_ocelot_range2 <- getMovebankData(study="BCI Ocelot", login=loginStored,
#                                       timestamp_end="20030724200000000")
#  

## ---- eval=F------------------------------------------------------------------
#  # download all data after "2003-07-01 20:00:00.000" only for "Bobby"
#  bobby_range <- getMovebankData(study="BCI Ocelot", login=loginStored, animalName="Bobby",
#                                 timestamp_start="20030701200000000")

## ---- eval=F------------------------------------------------------------------
#  bci_ocelot <- getMovebankData(study="BCI Ocelot", login=loginStored,
#                                removeDuplicatedTimestamps=TRUE)

## ---- eval=F------------------------------------------------------------------
#  getMovebankLocationData(study=74496970 , sensorID="GPS",
#                             animalName="DER AR439", login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  # get acceleration data for all individuals of the study between the "2013-08-15 15:00:00.000" and "2013-08-15 15:01:00.000"
#  getMovebankLocationData(study=74496970 , sensorID=653, login=loginStored,
#                             timestamp_start="20130815150000000",
#                             timestamp_end="20130815150100000")

## ---- eval=F------------------------------------------------------------------
#  getMovebankNonLocationData(study=74496970 , sensorID="Acceleration",
#                             animalName="DER AR439", login=loginStored)

## ---- eval=F------------------------------------------------------------------
#  # get acceleration data for all individuals of the study between the "2013-08-15 15:00:00.000" and "2013-08-15 15:01:00.000"
#  getMovebankNonLocationData(study=74496970 , sensorID=2365683, login=loginStored,
#                             timestamp_start="20130815150000000",
#                             timestamp_end="20130815150100000")

## ---- eval=F------------------------------------------------------------------
#  mymove <- getMovebankData(study=74496970, login=loginStored,
#                            animalName="DER AR439",includeExtraSensors=TRUE)

## ---- eval=F------------------------------------------------------------------
#  ## to get a data.frame containing the data for the non-location sensors use the "unUsedRecords" function
#  nonlocation <- as.data.frame(unUsedRecords(mymove))

## ---- eval=F------------------------------------------------------------------
#  getDataRepositoryData("doi:10.5441/001/1.2k536j54")

