## NOTE: Set your working directory where you have the rds files and
## the "processData.R"

source("processData.R")

# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

png(filename = "plot5.png", width = 480, height = 480)
with(BaltimoreMotorByYear, text(barplot(emissions, 
                                        names.arg = year,
                                        main = "Total PM2.5 emission from motor \nvehicle in Baltimore by year",
                                        xlab = "Year",
                                        ylab = "Emissions",
                                        family = "mono",
                                        font.lab = 2), 0, 
                                round(emissions, 5), 
                                cex = 1, pos = 3, font = 4))
dev.off()
