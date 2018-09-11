setGeneric("thinTrackTime", function(x,interval=NA, tolerance=NA, criteria=c('closest','first','all'), ...){standardGeneric("thinTrackTime")})
setMethod(f = "thinTrackTime",
          signature=c(x=".MoveTrackSingle"),
          definition=function(x, interval=NA, tolerance=NA, criteria=c('closest','first','all'), ...){
            if(class(interval)=="difftime")
            {
              interval<-as.numeric(interval,units="secs")
            }
            if(class(tolerance)=="difftime")
            {
              tolerance<-as.numeric(tolerance,units="secs")
            }
            criteria<-match.arg(criteria)
            stopifnot(is.numeric(interval))
            stopifnot(is.numeric(tolerance))
            stopifnot(length(interval)==1)
            stopifnot(length(tolerance)==1)
            filt<-filterThinFun(as.numeric(timestamps(x)), interval, tolerance, criteria,...)
            res<-lapply(attr(filt,'t'), function(t,x){
              x<-x[timestamps(x)%in%t,]
              j<-c("notSelected","selected")[1+(timeLag(x,units="secs") <=interval +tolerance & timeLag(x,units="secs") >=interval -tolerance)]
              burst(x,factor(j, levels=c("notSelected","selected")))
            },x=x)
            stopifnot(all(unlist(lapply(lapply(lapply(res, burst), table),'[',"selected"))==filt))
            if(criteria!="all")
              res<-res[[1]]
            return(res)
})

setGeneric("thinDistanceAlongTrack", function(x,interval=NA, tolerance=NA, criteria=c('closest','first','all'), ...){standardGeneric("thinDistanceAlongTrack")})
setMethod(f = "thinDistanceAlongTrack",
          signature=c(x=".MoveTrackSingle"),
          definition=function(x,interval=NA, tolerance=NA, criteria=c('closest','first','all'), ...){
            criteria<-match.arg(criteria)
            stopifnot(is.numeric(interval))
            stopifnot(is.numeric(tolerance))
            stopifnot(length(interval)==1)
            stopifnot(length(tolerance)==1)
            filt<-filterThinFun(c(0,cumsum(distance(x))), interval, tolerance, criteria,...)
            res<-lapply(attr(filt,'t'), function(t,x){
                a<-unlist(lapply(split(distance(x),head(cumsum(c(T,cumsum(distance(x)))%in%t),-1)),sum))
              x<-x[c(0,cumsum(distance(x)))%in%t,]
              j<-c("notSelected","selected")[1+(a <=interval +tolerance & a >=interval -tolerance)]
              burst(x,factor(j, levels=c("notSelected","selected")))
            },x=x)
            stopifnot(all(unlist(lapply(lapply(lapply(res, burst), table),'[',"selected"))==filt))
            if(criteria!="all")
              res<-res[[1]]
            return(res)
          })


filterThinFun<-memoise(function(x, d, t, selType=c('closest','first','all')){
		if(length(x)> 100)
		filterThinFun(tail(x, 100*((length(x)-1)%/%100)),d=d,t=t,selType=selType) # first run sub sections to prevent stack overflow
		if(length(x)==1)
		return(structure(0,t=list(x))) # return 0 at end
		s<-2:Position(function(xx,v=x[1]+d+t) {xx > v},x, nomatch=length(x)) # only investigate intervals upto rounded up interval length (these are the guesses of possible solutions
			int<-abs(x[s]-x[1]-d)<=t # find what intervals are good
			r<-lapply(lapply(length(x)+1-(s), tail, x=x), filterThinFun, d=d,t=t,selType=selType) # get the intervals for the trailing bits
			wm<-max(v<-unlist(m<-mapply('+', int, r, SIMPLIFY = F))) # combine intervals  and find max
			m<-m[v==wm]# select all those that have maximal number of intervals
			mm<-m[[1]]# the max number of ints
			m<-m[switch(selType[1], # select solutions
				closest=which.min(unlist(lapply(unlist(recursive=F,lapply(m, attr, 't')), function(xx){a<-abs(diff(c(x[1],xx))-d); sum(a[a<=t])}))), # check if there is a way to do this without adding an n^2 not sure how bad this problem is first=1,
				all=T
				)]
			tm<-unique(lapply(lapply(lapply(unlist(lapply(m,attr,'t'),recursive=F),c,x[1]), sort), function(x){
					if(length(x)<3)
					return(x)
					if(all(abs(diff(head(x,3))-d)>t))
					return(x[-2])
					return(x)
					})) # omit time values that do not add valid intervals
			attr(mm,'t')<-tm
			mm
			})
#filterThinFun(z<-c(1, 6:9, 16:19+(-1:2)/10, 22),10,1,'closest')
#require(testthat)
#require(memoise)
