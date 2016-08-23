context('Burst')
test_that('burst',{
data(leroy)
  b<-burst(leroy, f<-(strftime(timestamps(leroy),'%m')[-1]))
  expect_true(validObject(b))
  expect_equivalent(unlist(lapply(s<-split(b), n.locs))-1, as.numeric(table(f)))
  l<-factor(f);levels(l)<- validNames(levels(l))
  expect_equal(l, burstId(b))
  })
test_that("burstId",{
  b<-burst(leroy, f<-(strftime(timestamps(leroy),'%m')[-1]))
  burstId(b)<-(i<-rep("a", n.locs(b)-1))
  expect_identical(as.factor(i), burstId(b))
  })