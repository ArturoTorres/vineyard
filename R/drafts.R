library(chillR)


# GDD
# Calculation of cumulative heat according to the Growing Degree Day Model

weather   <- fix_weather(KA_weather[which(KA_weather$Year>2006),])
hourtemps <- stack_hourly_temps(weather,latitude=50.4)

class(hourtemps)
str(hourtemps)
summary(hourtemps$hourtemps)

gdd       <- GDD(hourtemps$hourtemps$Temp)
