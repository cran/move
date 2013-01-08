### Using fast Earth Movers Distance with rasters and DBBMM objects
# if (!isGeneric("emd")) {
	setGeneric("emd", function(x, y,xValue, yValue, threshold, integer, greatcircle) {standardGeneric("emd")})
# }

##DBBMM for emd
#NOTE: only works with integer=F (otherwise values maybe so small that all are rounded to 0 if not multiplied with a huge number!)
# setMethod(f="emd", 
# 	  #signature=c(x="RasterLayer", y="RasterLayer", threshold="numeric", integer="logical", greatcircle="logical"),
# 	  signature=c(x=".UD", y=".UD",xValue='missing',yValue='missing' , threshold="numeric", integer="logical", greatcircle="logical"), 
# 	  definition = function(x,y,xValue,yValue,threshold=NA,integer,greatcircle=FALSE){
# 		  r1 <- as.data.frame(rasterToPoints(x))
# 		  r2 <- as.data.frame(rasterToPoints(y))
# 		  stop('have to fix this' )
# 	  })


setMethod(f="emd", 
	  signature=c(x="SpatialPoints", y="SpatialPoints", xValue="numeric", yValue="numeric", threshold="numeric", integer="logical", greatcircle="logical"), 
	  definition = function(x,y,xValue,yValue,threshold=NA,integer,greatcircle=FALSE){
		  if(round(sum(xValue))!=round(sum(yValue))) ##bart I round here because differences from our rasters are somewhat like delta: -5.55111512312578e-16
			  warning(paste("Bart: Rasters dont have equal mass, delta:",sum(xValue)-sum(yValue)))
		  if(identical(all.equal(sum(xValue),1), FALSE))
			  warning("Bart: Raster does not represent probability surface")
		  r1<-coordinates(x)
		  r2<-coordinates(y)

# 		  if(!all(r1==r2))
# 			  stop("Rasters unequal not sure if that works")
		  res <- 1
		  if (integer==FALSE){
			  if (is.na(threshold)){
				  fun <- "emdR"                
			  }
			  if (!is.na(greatcircle)){
				  fun <- "emdR_gd"
			  }
			  a<-.C(fun,
				Pn=as.integer(nrow(r1)),
				Qn=as.integer(nrow(r2)),
				Px=as.double(r1[,1]),
				Py=as.double(r1[,2]),
				Pw=as.double(xValue),
				Qx=as.double(r2[,1]),
				Qy=as.double(r2[,2]),
				Qw=as.double(yValue),
				res=as.double(res),
				th=as.double(threshold),
				greatcircle=as.integer(greatcircle))
		  }else{
			  if (is.na(threshold)){
				  fun <- "emdRint"                
			  }
			  if (!is.na(greatcircle)){
				  fun <- "emdR_gdint"
			  }
			  a<-.C(fun,
				Pn=as.integer(nrow(r1)),
				Qn=as.integer(nrow(r2)),
				Px=as.double(r1[,1]),
				Py=as.double(r1[,2]),
				Pw=as.integer(xValue),
				Qx=as.double(r2[,1]),
				Qy=as.double(r2[,2]),
				Qw=as.integer(yValue),
				res=as.double(res),
				th=as.integer(threshold),
				greatcircle=as.integer(greatcircle))
		  }
		  return(a$res)
	  }
	  )
