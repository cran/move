setMethod("[", signature(x = ".unUsedRecords"), function(x, i, j, ...) {
  x@timestampsUnUsedRecords <- x@timestampsUnUsedRecords[i]
  x@sensorUnUsedRecords <- x@sensorUnUsedRecords[i]
  if (length(j)) {
    x@dataUnUsedRecords <- x@dataUnUsedRecords[i, j, drop = F]
  } else {
    x@dataUnUsedRecords <- x@dataUnUsedRecords[i, , drop = F]
  }
  return(x)
})
setMethod("[", signature(x = ".unUsedRecordsStack"), function(x, i, j, ...) {
  if (!missing(i)) {
    x@trackIdUnUsedRecords <- x@trackIdUnUsedRecords[i]
  } else {
    if (length(x@trackIdUnUsedRecords) == 0) {
      i <- logical(0L)
    } else {
      i <- T
    }
  }
  if (missing(j)) {
    j <- rep(T, ncol(x@dataUnUsedRecords))
  }
  callNextMethod(x = x, i = i, j = j, ...)
})
setMethod("[", signature(x = ".MoveTrack"), function(x, i, j, ...) {
  if (!missing(i)) {
    x@timestamps <- x@timestamps[i]
    x@sensor <- x@sensor[i]
  } else {
    i <- T
  }
  if (missing(j)) {
    j <- T
  }
  if (is.character(i)) {
    stop("Not sure if these methods work for class character")
  }
  callNextMethod(x = x, i = i, j = j, ...)
})

setMethod("[",
  signature(x = ".MoveTrackStack"),
  definition = function(x, i, j, ...) {
    if (!missing(i)) {
      x@trackId <- droplevels(x@trackId[i])
      x@idData <- x@idData[as.character(unique(x@trackId)), , drop = F]
    } else {
      i <- T
    }
    if (missing(j)) {
      j <- T
    }
    x <- callNextMethod(x = x, i = i, j = j, ...)
    u <- unUsedRecords(x)
    u <- u[u@trackIdUnUsedRecords %in% levels(x@trackId), ]
    u@trackIdUnUsedRecords <- factor(as.character(u@trackIdUnUsedRecords), levels = levels(x@trackId))
    new(class(x), u, x)
  }
)

setMethod("[", signature(x = "dBMvarianceStack"), function(x, i, j, ...) {
  if (!missing(i)) {
    x@means <- x@means[i]
    x@interest <- x@interest[i]
    x@in.windows <- x@in.windows[i]
  } else {
    i <- T
  }
  if (missing(j)) {
    j <- T
  }
  callNextMethod(x = x, i = i, j = j, ...)
})
setMethod("[", signature(x = "dBMvariance"), function(x, i, j, ...) {
  if (!missing(i)) {
    x@means <- x@means[i]
    x@interest <- x@interest[i]
    if (!all(diff(ifelse(is.logical(i), which(i), i)) == 1)) {
      warning("Omitting intermediate segments of a dBMvar object probably renders variance estimates invalid")
    }
    x@interest[length(x@interest)] <- F
    x@in.windows <- x@in.windows[i]
  } else {
    i <- T
  }
  if (missing(j)) {
    j <- T
  }
  callNextMethod(x = x, i = i, j = j, ...)
})
setMethod("[", signature(x = "dBMvarianceBurst"), function(x, i, j, ...) {
  if (!missing(i)) {
    x@means <- x@means[i]
    x@interest <- x@interest[i]
    if (!all(diff(ifelse(is.logical(i), which(i), i)) == 1)) {
      warning("Omitting intermediate segments of a dBMvar object probably renders variance estimates invalid")
    }
    x@interest[length(x@interest)] <- F
    x@in.windows <- x@in.windows[i]
  } else {
    i <- T
  }
  if (missing(j)) {
    j <- T
  }
  callNextMethod(x = x, i = i, j = j, ...)
})
setMethod("[",
  signature(x = ".MoveTrackSingleBurst"),
  definition = function(x, i, j, ...) {
    if (!missing(i)) {
      tmp <- x@burstId
      tmp1 <- tmp[c(1, 1:length(tmp))][i][-1]
      tmp2 <- head(tmp[c(1:length(tmp), length(tmp))][i], -1)
      if (any(tmp1 != tmp2)) {
        stop("Subsetting the burst object leads to ambiguities what the new bursting should be (specific segments can't be assigned to one burst type)")
      }
      x@burstId <- tmp1
    } else {
      i <- T
    }
    if (missing(j)) {
      j <- T
    }
    if (is.character(i)) {
      stop("Not sure if these methods work for class character")
    }
    #            if (class(j) == "character")
    #              stop("Not sure if these methods work for class character")
    callNextMethod(x = x, i = i, j = j, ...)
  }
)

setMethod("[[",
  signature(x = ".MoveTrackStack", i = "logical", j = "missing"),
  definition = function(x, i, j, ...) {
    i <- rownames(idData(x, i, drop = F))
    callGeneric(x = x, i = i, ...)
  }
)
setMethod("[[",
  signature(x = ".MoveTrackStack", i = "numeric", j = "missing"),
  definition = function(x, i, j, ...) {
    i <- rownames(idData(x, i, drop = F))
    callGeneric(x = x, i = i, ...)
  }
)
setMethod("[[",
  signature(x = ".MoveTrackStack", i = "character", j = "missing"),
  definition = function(x, i, j, ...) { # does not work
    if (!all(i %in% levels(trackId(x)))) {
      stop("Not all individuals are in stack")
    }
    s <- trackId(x) %in% i
    # 		spdf <- SpatialPointsDataFrame(coords = matrix(x@coords[s,], ncol=2),
    # 		      			 data=x@data[s,],
    # 		      			 proj4string=x@proj4string)
    # 		mt <- new(Class=".MoveTrack",
    # 		          spdf,
    # 		          timestamps=x@timestamps[s],
    # 		          sensor=x@sensor[s])
    mt <- x[s, ]
    unUsed <- as(x, ".unUsedRecordsStack")
    if (length(unUsed@sensorUnUsedRecords) == 0) {
      unUsedSub <- unUsed
      unUsedSub@trackIdUnUsedRecords <- factor(unUsedSub@trackIdUnUsedRecords, levels = i)
    } else {
      unUsedSub <- unUsed[unUsed@trackIdUnUsedRecords %in% i, T]
      unUsedSub@trackIdUnUsedRecords <- droplevels(unUsedSub@trackIdUnUsedRecords)
    }
    if (length(i) == 1) {
      x <- new(
        Class = "Move", as(mt, ".MoveTrack"),
        idData = idData(x, i, drop = F), # @idData[row.names(idData(x, drop=F))%in%i, ,drop=F],
        as(x, ".MoveGeneral"), as(unUsedSub, ".unUsedRecords")
      )
    } else {
      x <- new(
        Class = "MoveStack",
        mt,
        idData = idData(x, i, drop = F), # @idData[row.names(idData(x, drop=F))%in%i, ,drop=F],
        trackId = droplevels(x@trackId[s]),
        as(x, ".MoveGeneral"),
        unUsedSub
      )
    }
    #            if(!missing(i)){
    #              x@trackId=droplevels(x@trackId[i])
    #              x@idData=x@idData[as.character(unique(x@trackId[i])),]}else{i<-T}
    return(x)
  }
)


setMethod("[<-", signature(x = ".MoveTrack"), function(x, i, j, ..., value) {
  d <- slot(x, name = "data")
  d[i, j, ...] <- value
  slot(x, "data") <- d
  return(x)
})
