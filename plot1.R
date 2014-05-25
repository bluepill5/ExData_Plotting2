## NOTE: Set your working directory where you have the rds files and
## the "processData.R"

source("processData.R")

# Have total emissions from PM2.5 decreased in the United States from 1999
# to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
# and 2008.

png(filename = "plot1.png", width = 480, height = 480)
with(SCCByYear, text(barplot(emissions, 
                             names.arg = year,
                             main = "Total PM2.5 emission by year",
                             xlab = "Year",
                             ylab = "Emissions",
                             family = "mono",
                             font.lab = 2), 0, round(emissions, 2), 
                     cex = 1, pos = 3, font = 4))
dev.off()
