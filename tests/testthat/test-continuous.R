### Test continuous / sparse
test_that("continuous", {
  set.seed(24101968)
  library("tramvs")

  N <- 1e2
  P <- 5
  nz <- 3
  beta <- rep(c(3, 0), c(nz, P - nz))
  X <- matrix(rnorm(N * P), nrow = N, ncol = P)
  Y <- 1 + X %*% beta + rnorm(N)

  dat <- data.frame(y = Y, x = X)
  res <- tramvs(y ~ ., data = dat, modFUN = Lm)
  as(as.matrix(coef(res, as.lm = TRUE)), "sparseMatrix")

  # S3 methods
  print(res)
  summary(res)
  plot(res, type = "b")
  plot(res, which = "path")
  logLik(res)
  SIC(res)
  coef(res)
  predict(res, which = "distribution", type = "trafo")
  residuals(res)

  # Active set
  expect_equal(support(res), c("x.1", "x.2", "x.3"))

  # Compare with abess ------------------------------------------------------

  if (require("abess")) {
    res_abess <- abess(y ~ ., data = dat, family = "gaussian")
    coef(res_abess)[,-1]
  }
})
