library(dplyr)
library(lubridate)

# get the data and unzip
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#if (!file.exists("data")){dir.create("data")}
#download.file(url,"./data/hpc.zip")
#unzip("./data/hpc.zip",overwrite=TRUE,exdir="./data/")


# read into table 
household_power_consumption <- read.csv("./data/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE,na.strings = "?")

# like to use dplyr
hpc <- tbl_df(household_power_consumption)
hpc <- hpc %>% filter(dmy(Date)==ymd("2007-02-01")|dmy(Date)==ymd("2007-02-02")) %>% mutate(Date=dmy_hms(paste(Date,Time))) %>% select(-Time)

# get rid of original 
rm(household_power_consumption)

# plot 3
png(filename="plot3.png",width=480,height=480)

with(hpc,plot(Date,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(hpc,points(Date, Sub_metering_2, type="l", col="red"))
with(hpc,points(Date, Sub_metering_3, type="l", col="blue"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))

dev.off()
