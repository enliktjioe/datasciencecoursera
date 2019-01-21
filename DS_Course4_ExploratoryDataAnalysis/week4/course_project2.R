## Set my working directory
setwd("/Users/enlik/GitRepo/datasciencecoursera/DS_Course4_ExploratoryDataAnalysis/week4")

## Load required R Library
library(dplyr)
library(ggplot2)

## Read required datasets
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.
q1 <- summarise(group_by(NEI, year), Emissions = sum(Emissions))
usedColors <- c("blue", "yellow", "green", "orange")
plot1 <- barplot(height = q1$Emissions/1000, names.arg = q1$year,
                 xlab = "years", ylab = expression('total PM2.5 emission in kilotons'),
                 ylim = c(0, 8000),
                 main = expression('Total PM'[2.5]*' emissions at various years in kilotons'),
                 col = usedColors)

## Add text on the top of bars
text(x = plot1, y = round(q1$Emissions/1000,2),
      label = round(q1$Emissions/1000,2), pos = 3,
      cex = 0.8, col = "black")


# Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == “24510”) 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.
q2 <- summarise(group_by(filter(NEI, fips == "24510"),
                                    year), Emissions = sum(Emissions))
usedColors <- c("blue", "yellow", "green", "orange")
plot2 <- barplot(height = q2$Emissions/1000, names.arg = q2$year,
                  xlab = "years", ylab = expression('Total PM'[2.5]*' emissions in kilotons'),
                  ylim =  c(0,4), main = expression('Total PM'[2.5]*' emissions in Baltimore City,
                                                    Maryland in kilotons'),
                  col = usedColors)

## add text on the top of bars
text(x = plot2, y = round(q2$Emissions/1000, 2),
     label = round(q2$Emissions/1000,2), pos = 3,
     cex = 0.8, col = "black")



# Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
q3 <- summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))

ggplot(q3, aes(x = factor(year), y = q3$Emissions, fill = type, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emission in tons")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))+
  geom_label(aes(fill = type), colour = "white", fontface = "bold")



