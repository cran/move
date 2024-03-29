setGeneric("getMotionVariance", function(x, ...) {
  standardGeneric("getMotionVariance")
})
setMethod("getMotionVariance",
  signature = "dBMvarianceTmp",
  definition = function(x, ...) {
    x@means
  }
)
setMethod("getMotionVariance",
  signature = "dBMvarianceStack",
  definition = function(x, ...) {
    split(x@means, x@trackId)
  }
)
setMethod("getMotionVariance",
  signature = "dBGBvarianceTmp",
  definition = function(x, ...) {
    cbind(para = x@paraSd^2, orth = x@orthSd^2)
  }
)
setMethod("getMotionVariance",
  signature = "dBMvarianceBurst",
  definition = function(x, ...) {
    x <- as(x, "dBMvarianceTmp")
    callGeneric()
  }
)
setMethod("getMotionVariance",
  signature = "DBBMM",
  definition = function(x, ...) {
    x <- slot(x, "DBMvar")
    callGeneric()
  }
)
setMethod("getMotionVariance",
  signature = "DBBMMStack",
  definition = function(x, ...) {
    x <- slot(x, "DBMvar")
    callGeneric()
  }
)
setMethod("getMotionVariance",
  signature = "DBBMMBurstStack",
  definition = function(x, ...) {
    x <- slot(x, "DBMvar")
    callGeneric()
  }
)
setMethod("getMotionVariance",
  signature = "dynBGB",
  definition = function(x, ...) {
    x <- slot(x, "var")
    callGeneric()
  }
)
