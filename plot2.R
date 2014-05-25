## NOTE: Set your working directory where you have the rds files and
## the "processData.R"

source("processData.R")

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question.

png(filename = "plot2.png", width = 480, height = 480)
with(BaltimoreByYear, 
     text(barplot(emissions, 
                  names.arg = year, 
                  main = "Total PM2.5 emissions in Baltimore by year",
                  xlab = "Year",
                  ylab = "Emissions",
                  family = "mono",
                  font.lab = 2), 0, round(emissions, 2), cex = 1, 
          pos = 3, font = 4))
dev.off()
