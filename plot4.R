## NOTE: Set your working directory where you have the rds files and
## the "processData.R"

source("processData.R")

# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

png(filename = "plot4.png", width = 480, height = 480)
with(summByCoalByYear, text(barplot(emissions, 
                                    names.arg = year,
                                    main = "Total PM2.5 emission from coal \ncombustion-related by year",
                                    xlab = "Year",
                                    ylab = "Emissions",
                                    family = "mono",
                                    font.lab = 2), 0, 
                            round(emissions, 2), 
                            cex = 1, pos = 3, font = 4))
dev.off()
