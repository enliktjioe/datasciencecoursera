# read .txt in normal method using read.csv()
household_power_consumption <- read.csv("week1/course_project_1/household_power_consumption.txt",
                                        sep = ";")
str(household_power_consumption)

# Convert variable Date and Time using as.Date() and strptime()
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
household_power_consumption$Time <- strptime(household_power_consumption$Time, "%H:%M:%S")

head(household_power_consumption$Date, n = 3)
head(household_power_consumption$Time, n = 3)

# Subset data from the dates 2007-02-01 and 2007-02-02
data_used <- subset(household_power_consumption, 
                    household_power_consumption$Date == "2007-02-01" |
                      household_power_consumption$Date == "2007-02-02")
str(data_used)

# Save memory used by removing unused data
rm(household_power_consumption)

## Plot 2
data_used$Global_active_power <- as.numeric(data_used$Global_active_power)
png("week1/course_project_1/plot2.png", width = 480, height = 480)
plot(data_used$Time, data_used$Global_active_power, type = "l",
        xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()