setwd("/Users/jim/_mymods/tmb/Feb2016/examples/wt/")
data <- list()
data$wtage <- read.table("wtmb.dat")
data$wtcv  <- read.table("wtmbcv.dat")
data
names(data)
# Load library
library(TMB)

compile("wtmb.cpp","-O0 -g")
# Load compiled model
dyn.load(dynlib("wtmb"))

# Define parameters
parameters <- list(a=0,b=0,logSigma=0)
parameters
obj <- MakeADFun(data,parameters,DLL="wtmb")

# Indicate if Hessian to be computed
obj$hessian <- TRUE
# Do estimation 
opt <- do.call("optim",obj)

opt
opt$hessian ## <-- FD hessian from optim
obj$he()    ## <-- Analytical hessian
sdreport(obj)

   = mnwt*exp(sigma_yr*yr_eff(i));