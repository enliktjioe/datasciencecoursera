d1 <- date()
d1

# Date class
d2 = Sys.Date()
d2
class(d2)

# Formmating dates
# %d = day as number(0-31) 
# %a = abbreviated weekday
# %A = unabbreviated weekday
# %m = month(00-12)
# %b = abbreviated month
# %B = unabbreviated month
# %y = 2 digit year
# %Y = 4 digit year
format(d2, "%a %b %d")

# Creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z = as.Date(x, "%d%b%Y")
z # "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"
z[1] - z[2]
# Time difference of -1 days
as.numeric(z[1] - z[2])


# Converting to Julian
weekdays(d2)
months(d2)
julian(d2)


# Lubridate
library(lubridate); ymd("20140108")
mdy("08/04/2013") # "2013-08-04"
dmy("03-04-2013") # "2013-04-03"

# Dealing with times
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")
?Sys.timezone
?POSIXlt

