## NOTE: Set your working directory where you have the rds files
# Loading the required libraries
library(ggplot2)
library(data.table)
library(scales)

#####################       Loading the data       #####################
SummSCC <- readRDS("summarySCC_PM25.rds")
source_class <- readRDS("Source_Classification_Code.rds")
# Process the data a little faster
SummSCC <- data.table(SummSCC)
# SummSCC:      Contains a data frame with all of the PM2.5 emissions 
#               data for 1999, 2002, 2005, and 2008. For each year, the 
#               table contains number of tons of PM2.5 emitted from a 
#               specific type of source for the entire year.
# source_class: Provides a mapping from the SCC digit strings int he 
#               Emissions table to the actual name of the PM2.5 source

####################       Processing the Data      ####################

##### PART 1
# Group the amount of Emissions data by year
SCCByYear <- SummSCC[, sum(Emissions), by = year]
setnames(SCCByYear, names(SCCByYear), c("year", "emissions"))


##### PART 2
# Subset the data of Baltimore (fips == "24510")
Baltimore <- SummSCC[SummSCC$fips == "24510", ]
# Group the amount of Emissions data by year
BaltimoreByYear <- Baltimore[, sum(Emissions), by = year]
setnames(BaltimoreByYear, names(BaltimoreByYear), c("year", "emissions"))


### PART 3
# Group the data of Baltirmore by type, we obtain a list with each type 
BaltimoreByType <- lapply(split(Baltimore, Baltimore$type), 
                          function(x) 
                              cbind(aggregate(Emissions ~ year, x, sum),
                                    type = x$type[1]))
# Combine the list in a single data frame
BaltimoreByType <- Reduce(rbind, BaltimoreByType)
levels(BaltimoreByType$type) <- c("NON-ROAD", "NONPOINT", 
                                  "ON-ROAD", "POINT")


##### PART 4
# We are looking for coal combustion-related sources, then we consider
# the cases where:
# SCC.Level.One contains "combustion" & 
# SCC.Level.Three contains "coal" |
# SCC.Level.Three contains "lignite"
coalSCC <- source_class[grepl("combustion", 
                              source_class$SCC.Level.One, 
                              ignore.case=TRUE) & 
                            (grepl("coal", 
                                   source_class$SCC.Level.Three, 
                                   ignore.case=TRUE) | 
                                 grepl("lignite", 
                                       source_class$SCC.Level.Three, 
                                       ignore.case=TRUE)), ]
# Match 'coalSCC' with the 'SummSCC' data
summByCoal <- SummSCC[SCC %in% coalSCC$SCC, ]
# Group by year
summByCoalByYear <- summByCoal[, sum(Emissions), by = year]
setnames(summByCoalByYear, names(summByCoalByYear), 
         c("year", "emissions"))


##### PART 5
# We are looking for motor vehicle sources, then we consider the cases 
# where:
# Short.Name contains "motor"
motorSCC <- source_class[grepl("motor", source_class$Short.Name, 
                               ignore.case = TRUE), ]
# Match 'motorSCC' with the 'SummSCC' data
summByMotor <- SummSCC[SCC %in% motorSCC$SCC, ]
# Using the 'summByCoal' subset the Baltimore data
BaltimoreMotor <- summByMotor[summByMotor$fips == "24510", ]
# Group by year
BaltimoreMotorByYear <- BaltimoreMotor[, sum(Emissions), by = year]
setnames(BaltimoreMotorByYear, names(BaltimoreMotorByYear), 
         c("year", "emissions"))


##### PART 6
# Subset the data of Baltimore and Los Angeles (fips == "06037")
MotorByCountry <- summByMotor[summByMotor$fips == "06037" | 
                                  summByMotor$fips == "24510", ]
# Group by year with a label ("Baltimore" or "Los Angeles"), we obtain 
# a list with each city
MotorByCountry <- lapply(split(MotorByCountry, MotorByCountry$fips), 
                         function(x) 
                             cbind(aggregate(Emissions ~ year, x, sum),
                                   country = 
                                       if (x$fips[1] == "06037") "Los Angeles" 
                                   else "Baltimore"))
# Combine the list in a single data frame
MotorByCountry <- Reduce(rbind, MotorByCountry)
levels(MotorByCountry$country) <- c("Los Angeles", "Baltimore")

