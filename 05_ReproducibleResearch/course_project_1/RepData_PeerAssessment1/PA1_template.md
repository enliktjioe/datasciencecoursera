---
title: "Reproducible Research: Peer Assessment 1"
author: "Enlik Tjioe"
output: 
  html_document:
    keep_md: true
---


## Library

```r
library(ggplot2)
library(lubridate)
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following object is masked from 'package:base':
## 
##     date
```


## Loading and preprocessing the data

```r
data1 <- read.csv(unz("activity.zip", "activity.csv"))
str(data1)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

```r
data1$date <- ymd(data1$date)
```


## What is mean total number of steps taken per day?

```r
totalSteps <- aggregate (steps ~ date, data = data1, FUN = sum, na.rm=TRUE)
head(totalSteps)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

1. Make a histogram of the total number of steps taken each day

```r
hist(totalSteps$steps, xlab = "Steps", main = "Steps / Day", breaks = 10, col = "blue")
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

2. Calculate and report the mean and median total number of steps taken per day


```r
mean(totalSteps$steps)
```

```
## [1] 10766.19
```

```r
median(totalSteps$steps)
```

```
## [1] 10765
```

## What is the average daily activity pattern?
1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
stepsInterval <- aggregate(steps ~ interval, data1, mean)
plot(stepsInterval$interval, stepsInterval$steps, type = "l", xlab = "5-minutes Interval", ylab = "Average Steps", main = "Average Daily Activity Pattern", col = "orange")
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

2.Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
stepsInterval$interval[which.max(stepsInterval$steps)]
```

```
## [1] 835
```


## Imputing missing values
1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
nas <- sum(is.na(data1$steps))
nas
```

```
## [1] 2304
```

2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
3. Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
data2 <- data1
data2[is.na(data2$steps), "steps"] <- 0
```

4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

```r
stepsWithoutNAs <- aggregate(steps ~ date, data2, sum)
hist(stepsWithoutNAs$steps, main = "Steps per Day", xlab = "Steps", col = "green", breaks = 8)
```

![](PA1_template_files/figure-html/unnamed-chunk-10-1.png)<!-- -->


```r
mean(stepsWithoutNAs$steps) # 9354.23
```

```
## [1] 9354.23
```

```r
median(stepsWithoutNAs$steps) # 10395
```

```
## [1] 10395
```
These values are differ from the estimates from the first part of the assignment.

## Are there differences in activity patterns between weekdays and weekends?
1. Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.

```r
data2$day <- weekdays(data2$date)
data2$dayType <- as.factor(ifelse(data2$day == "Saturday" | data2$day == "Sunday", "weekend", "weekday")) 
data2 <- subset(data2, select = -c(day))

head(data2)
```

```
##   steps       date interval dayType
## 1     0 2012-10-01        0 weekday
## 2     0 2012-10-01        5 weekday
## 3     0 2012-10-01       10 weekday
## 4     0 2012-10-01       15 weekday
## 5     0 2012-10-01       20 weekday
## 6     0 2012-10-01       25 weekday
```

2. Make a panel plot containing a time series plot (i.e. type = "l"\color{red}{\verb|type = "l"|}type="l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).

```r
weekdaysData <- data2[data2$dayType == "weekday",]
weekendsData <- data2[data2$dayType == "weekend",]
stepsIntervalWeekdays <- aggregate(steps ~ interval, weekdaysData, mean)
stepsIntervalWeekends <- aggregate(steps ~ interval, weekendsData, mean)

par(mfrow = c(2, 1))

plot(stepsIntervalWeekdays, type = "l", col = "green", main = "Weekdays")
plot(stepsIntervalWeekends, type = "l", col = "red", main = "Weekends")
```

![](PA1_template_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

