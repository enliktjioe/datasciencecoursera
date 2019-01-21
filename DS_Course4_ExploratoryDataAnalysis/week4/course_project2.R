## Set my working directory
setwd("/Users/enlik/GitRepo/datasciencecoursera/DS_Course4_ExploratoryDataAnalysis/week4")

## Load required R Library
library(dplyr)

## Read required datasets
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.
totalEmissions <- summarise(group_by(NEI, year), Emissions = sum(Emissions))
usedColors <- c("blue", "yellow", "green", "orange")
plot1 <- barplot(height = totalEmissions$Emissions/1000, names.arg = totalEmissions$year,
                 xlab = "years", ylab = expression('total PM2.5 emission in kilotons'),
                 ylim = c(0, 8000),
                 main = expression('Total PM'[2.5]*' emissions at various years in kilotons'),
                 col = usedColors)


# Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == “24510”) from 1999 to 2008? Use the base plotting system to make a plot answering this question.
