## NOTE: Set your working directory where you have the rds files and
## the "processData.R"

source("processData.R")

# Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in 
# motor vehicle emissions?

png(filename = "plot6.png", width = 480, height = 480)
ggplot(MotorByCountry, aes(x=year, y=Emissions)) + 
    geom_bar(stat = "identity", position = "dodge") + 
    facet_wrap( ~ country) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1), 
          text = element_text(family="mono", face="bold")) +
    theme(axis.ticks = element_blank(), axis.text.x = element_blank()) +
    geom_text(aes(label = year, vjust = -0.4), size = 3) +
    labs(title = "Total PM2.5 emissions in Los Angeles & Baltimore \nfrom motor vehicle by year",
         x = "Year", 
         y = "Emissions")
dev.off()
