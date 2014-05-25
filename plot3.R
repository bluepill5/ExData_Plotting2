## NOTE: Set your working directory where you have the rds files and
## the "processData.R"

source("processData.R")

# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have 
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting 
# system to make a plot answer this question.

png(filename = "plot3.png", width = 480, height = 480)
ggplot(BaltimoreByType, aes(x=year, y=Emissions)) + 
    geom_bar(stat = "identity", position = "dodge") + 
    facet_wrap( ~ type) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1), 
          text = element_text(family="mono", face="bold")) +
    theme(axis.ticks = element_blank(), axis.text.x = element_blank()) +
    geom_text(aes(label = year, vjust = -0.4), size = 3) +
    labs(title = "Total PM2.5 emissions in Baltimore by type",
         x = "Year", 
         y = "Emissions")
dev.off()
