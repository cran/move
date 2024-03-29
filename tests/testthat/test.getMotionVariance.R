context("getMotionVariance")
test_that("dbgb vs dbbmm variance", {
  x <- c(1, 1.5, 3, 3.5, 5, 5.5, 7, 7.5, 9)
  y <- c(0, .5, 0, .5, 0, .5, 0, .5, 0)
  yy <- move(x, y, Sys.time() + 1:9 * 60)
  dbgb <- dynBGBvariance(yy, rep(.1, 9), 3, 9)
  dbgbUD <- dynBGB(yy, rep(.1, 9), margin = 3, wind = 9, ext = 5, raster = .1)
  dbbmm <- brownian.motion.variance.dyn(yy, rep(.1, 9), 9, 3)
  yyb <- burst(yy, gl(2, 4))
  dbb <- brownian.motion.variance.dyn(yyb, rep(.1, 9), 9, 3)
  dbbud <- brownian.bridge.dyn(dbb, location.error = rep(.1, n.locs(dbb)), margin = 3, windo = 9, raster = .100, ext = 4)
  expect_message(dbbmmUD <- brownian.bridge.dyn(yy, locat = rep(.1, 9), win = 9, m = 3, raster = .1, ext = 4), "Computational size:")
  expect_equal(getMotionVariance(dbbmm), getMotionVariance(dbgb)[, 1], check.names = F, tolerance = 2e-5)
  expect_equal(getMotionVariance(dbbmm), getMotionVariance(dbgb)[, 2], check.names = F, tolerance = 2e-5)
  expect_equal(getMotionVariance(dbgbUD), getMotionVariance(dbgb))
  expect_equal(getMotionVariance(dbbmmUD), getMotionVariance(dbbmm))
  expect_equal(getMotionVariance(dbbmmUD), getMotionVariance(dbbud))
  expect_equal(getMotionVariance(dbb), getMotionVariance(dbbud))
  x <- c(1, 1.5, 3, 3.5, 5, 5.5, 7, 7.5, 9, 9.5, 11)
  y <- c(0, .5, 0, .5, 0, .5, 0, .5, 0, .5, 0)
  yy <- move(x, y, Sys.time() + 1:11 * 60)
  expect_warning(p <- moveStack(list(yy, yy)))
  expect_message(pp <- brownian.bridge.dyn(p, win = 7, mar = 3, raster = .1, ext = 3, lo = .1))
  expect_is(getMotionVariance(pp), "list")
})
