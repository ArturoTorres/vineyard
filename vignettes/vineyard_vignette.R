## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(vineyard)

library(knitr)
library(roxygen2)
library(xts)
library(rgdal)
library(spacetime)

timing.ini <- Sys.time()

## ----load_dataset--------------------------------------------------------
data(data_remich)
str(data_remich)

## ----split_years---------------------------------------------------------
# cohercing to data.frame
data.remich <- as.data.frame(data_remich)

# creating xts
data.remich <- xts(x = data.remich, order.by = data.remich$time)

years <- factor(data.remich$Year)
remich.years <- split(data.remich, years)

## ----degree_days---------------------------------------------------------
head(remich.years[[1]])

cdd <- cdd.single.triangle(data = remich.years, t.zero = 0, t.min.col = 16, t.mean.col = 17, t.max.col = 15)
head(cdd[[1]])

cdd.bb <- cdd.single.triangle.budbreak(cdd = cdd, start.date = 59)
head(cdd.bb[[1]])

## ----degree_days_molitor1------------------------------------------------
cdd.lt <- cdd.lThresh(data = remich.years, t.mean.col = 17, a = 0)

head(cdd.lt[[1]])

## ----phenology_molitor1--------------------------------------------------
# mean cumulative heat sum for bud break of 438.7 degree celsius for
# Mueller-Thurgau (Nelder, 2010)
cdd.phen.mthurgau <- cdd.lThresh.phenology(cdd.lt = cdd.lt, chs.mean = 438.7)
head(cdd.phen.mthurgau[[1]])

# mean cumulative heat sum for bud break of 438.7 degree celsius for
# Riesling (Nelder, 2010)
cdd.phen.riesling <- cdd.lThresh.phenology(cdd.lt = cdd.lt, chs.mean = 463.1)
head(cdd.phen.riesling[[1]])

# growth stages
data(GrowthStage_CDD)

GrowthStage_CDD

phen.mthurgau <- phenology.stages(cdd.phen = cdd.phen.mthurgau, ref.data = GrowthStage_CDD[-1,],
                                          stage = GrowthStage_CDD[-1,1])
phen.mthurgau[[1]]


phen.riesling <- phenology.stages(cdd.phen = cdd.phen.mthurgau, ref.data = GrowthStage_CDD[-1,],
                                      stage = GrowthStage_CDD[-1,1])
phen.riesling[[1]]


## ----degree_days_molitor2------------------------------------------------
cdd.lut <- cdd.luThresh(data = remich.years, t.mean.col = 17, a = 0, b = 15)

head(cdd.lut[[1]])

## ----phenology_molitor2--------------------------------------------------
# mean cumulative heat sum for bud break of 438.7 degree celsius for
# Mueller-Thurgau (Nelder, 2010)
cdd.phen.mthurgau.lut <- cdd.luThresh.phenology(cdd.lut = cdd.lut, chs.mean = 438.7)
head(cdd.phen.mthurgau.lut[[1]])

# mean cumulative heat sum for bud break of 438.7 degree celsius for
# Riesling (Nelder, 2010)
cdd.phen.riesling.lut <- cdd.luThresh.phenology(cdd.lut = cdd.lut, chs.mean = 463.1)
head(cdd.phen.riesling.lut[[1]])

# growth stages
phen.mthurgau.lut <- phenology.stages(cdd.phen = cdd.phen.mthurgau.lut, ref.data = GrowthStage_CDD[-1,],
                                  stage = GrowthStage_CDD[-1,1])
phen.mthurgau.lut[[1]]


phen.riesling.lut <- phenology.stages(cdd.phen = cdd.phen.mthurgau.lut, ref.data = GrowthStage_CDD[-1,],
                                  stage = GrowthStage_CDD[-1,1])
phen.riesling.lut[[1]]

## ----degree_days_molitor3------------------------------------------------
cdd.luht <- cdd.luhThresh(data = remich.years, t.mean.col = 17, a = 0, b = 15, c = 20)

head(cdd.luht[[1]])

## ----phenology_molitor3--------------------------------------------------

# mean cumulative heat sum for bud break of 438.7 degree celsius for
# Mueller-Thurgau (Nelder, 2010)
cdd.phen.mthurgau.luht <- cdd.luhThresh.phenology(cdd.luht = cdd.luht, chs.mean = 438.7)
head(cdd.phen.mthurgau.luht[[1]])

# mean cumulative heat sum for bud break of 438.7 degree celsius for
# Riesling (Nelder, 2010)
cdd.phen.riesling.luht <- cdd.luhThresh.phenology(cdd.luht = cdd.luht, chs.mean = 463.1)
head(cdd.phen.riesling.luht[[1]])

# growth stages
phen.mthurgau.luht <- phenology.stages(cdd.phen = cdd.phen.mthurgau.luht, ref.data = GrowthStage_CDD[-1,],
                                      stage = GrowthStage_CDD[-1,1])
phen.mthurgau.luht[[1]]


phen.riesling.luht <- phenology.stages(cdd.phen = cdd.phen.mthurgau.luht, ref.data = GrowthStage_CDD[-1,],
                                      stage = GrowthStage_CDD[-1,1])
phen.riesling.luht[[1]]

## ----timing--------------------------------------------------------------
timing.end <- Sys.time()
(timing.elapsed <- timing.end - timing.ini)

## ----session-------------------------------------------------------------
sessionInfo()

