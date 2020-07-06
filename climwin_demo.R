

library(climwin)

Mass
head(MassClimate)
tail(MassClimate)

MassWin <- slidingwin(xvar = list(Temp = MassClimate$Temp),
                      cdate = MassClimate$Date,
                      bdate = Mass$Date,
                      baseline = lm(Mass ~ 1, data = Mass),
                      cinterval = "day",
                      range = c(15, 15),
                      type = "absolute", refday = c(20, 05),
                      stat = "mean",
                      func = "lin")

MassWin <- slidingwin(xvar = list(Temp = MassClimate$Temp),
                      cdate = MassClimate$Date,
                      bdate = Mass$Date,
                      baseline = lm(Mass ~ 1, data = Mass),
                      cinterval = "day",
                      range = c(15, 15),
                      type = "relative",
                      stat = "mean",
                      func = "lin")

MassWin
