#Download and read the raw data set
if(!file.exists("exdata_data_household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata_data_household_power_consumption.zip")
}
df <- read.table(unz("exdata_data_household_power_consumption.zip","household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE)

#Append an extra column to store Date/Time class object
df[,"DateTime"] <- with(df, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#Subset data containing data between 2007-02-01 and 2007-02-02
strt <- as.POSIXct("2007-02-01", format = "%Y-%m-%d")
end <- as.POSIXct("2007-02-03", format = "%Y-%m-%d")
sub_df <- subset(df, DateTime >= strt & DateTime < end)

#Open a png device, plot the graphs and close the device
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg=NA)
par(mfrow = c(2,2))

#Plot 1
with(sub_df,plot(DateTime, as.numeric(Global_active_power), type = "l", xlab = "",ylab = "Global Active Power", main = ""))

#Plot 2
with(sub_df,plot(DateTime, as.numeric(Voltage), type = "l", xlab = "datetime",ylab = "Voltage", main = ""))

#Plot 3
with(sub_df,plot(DateTime, as.numeric(Sub_metering_1), type = "l", xlab = "",ylab = "Energy sub metering", main = ""))
with(sub_df,points(DateTime, as.numeric(Sub_metering_2), col = "red", type = "l"))
with(sub_df,points(DateTime, as.numeric(Sub_metering_3), col = "blue", type = "l"))
legend("topright",lwd = 1,bty="n", col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Plot4
with(sub_df,plot(DateTime, as.numeric(Global_reactive_power), type = "l", xlab = "datetime",ylab = "Global_reactive_power", main = ""))

dev.off()
