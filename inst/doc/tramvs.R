## ----setup, echo = FALSE, results = "hide", message = FALSE-------------------
set.seed(241068)

knitr::opts_chunk$set(echo = TRUE, results = 'markup', error = FALSE,
                      warning = FALSE, message = FALSE,
                      tidy = FALSE, cache = TRUE, size = "small",
                      fig.width = 5, fig.height = 4, fig.align = "center",
                      out.width = NULL, ###'.6\\linewidth',
                      out.height = NULL,
                      fig.scap = NA)
## R settings
options(width = 80, digits = 3)

library("tramvs")

abess_available <- require("abess")
tramnet_available <- require("tramnet")

# Colors
if (require("colorspace")) {
  col <- diverge_hcl(2, h = c(246, 40), c = 96, l = c(65, 90))
  fill <- diverge_hcl(2, h = c(246, 40), c = 96, l = c(65, 90), alpha = .3)
}

## ----args---------------------------------------------------------------------
args(abess_tram)

## ----args2--------------------------------------------------------------------
args(tramvs)

## ----tram1, results='hide'----------------------------------------------------
N <- 1e2; P <- 10; nz <- 3
beta <- rep(c(3, 0), c(nz, P - nz))
X <- matrix(rnorm(N * P), nrow = N, ncol = P)
Y <- 1 + X %*% beta + rnorm(N)

dat <- data.frame(y = Y, x = X)
cont_res <- tramvs(y ~ ., data = dat, modFUN = Lm)

## ----tram11, results='hide', eval=abess_available-----------------------------
res_abess <- abess(y ~ ., data = dat, family = "gaussian")

## ----tram2--------------------------------------------------------------------
support(cont_res)

## ----tram21, eval=abess_available---------------------------------------------
extract(res_abess, support.size = res_abess$best.size)$support.vars

## ----tram3, eval=FALSE--------------------------------------------------------
#  BoxCoxVS(y ~ ., data = dat)

## ----tram4, eval=FALSE--------------------------------------------------------
#  BoxCoxVS(y ~ ., data = dat, order = 3, extrapolate = TRUE)

## ----mandatory, eval=FALSE----------------------------------------------------
#  BoxCoxVS(y ~ ., data = dat, mandatory = y ~ x.1)

## ----cotram, results="hide"---------------------------------------------------
library(cotram)

data("birds", package = "TH.data")
birds$noise <- rnorm(nrow(birds), sd = 10)

# Estimate support sice via HBIC
count_res <- tramvs(SG5 ~ AOT + AFS + GST + DBH + DWC + LOG + noise, data = birds,
                       modFUN = cotram)

## ----pcotram, out.width="49%", echo=FALSE, fig.show='hold'--------------------
plot(count_res, type = "b")
plot(count_res, which = "path")

## ----profile, eval=tramnet_available------------------------------------------
m0 <- Lm(y ~ 1, data = dat)
X <- model.matrix(y ~ 0 + ., data = dat)
mt <- tramnet(m0, X, lambda = 0, alpha = 1)
pfl <- prof_lambda(mt, nprof = 5)

## ----pprofile, out.width="49%", fig.show='hold', echo=FALSE, eval=tramnet_available----
plot(cont_res, which = "path")
opar <- par(no.readonly = TRUE)
par(mar = c(5.1, 5.1, 4.1, 2.1), las = 1)
matplot(pfl$lambdas, pfl$cfx, type = "l", xlab = expression(lambda),
        ylab = expression(hat(beta)[j]), xlim = rev(range(pfl$lambdas)))
text(min(pfl$lambdas) - 0.25, pfl$cfx[1, ], colnames(pfl$cfx),
     cex = 0.8)
par(opar)

## ----methods1-----------------------------------------------------------------
# More elaborate summary
summary(cont_res)

## ----methods2-----------------------------------------------------------------
# logLik of best model
logLik(cont_res)
nparm <- coef(cont_res, with_baseline = TRUE, best_only = TRUE)
logLik(cont_res, newdata = dat[1:5, ], parm = nparm)

## ----methods3-----------------------------------------------------------------
# High-dimensional information criterion
SIC(cont_res)
SIC(cont_res, best_only = TRUE)

## ----methods4-----------------------------------------------------------------
coef(cont_res)
coef(cont_res, best_only = TRUE)
coef(cont_res, as.lm = TRUE)

## ----methods5, eval=FALSE-----------------------------------------------------
#  head(predict(cont_res, which = "distribution", type = "trafo"))
#  simulate(cont_res)[1:5]
#  head(residuals(cont_res))

## ----sesinf, echo=FALSE-------------------------------------------------------
sessionInfo()

