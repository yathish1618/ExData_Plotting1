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

#Open a png device, plot the graph and close the device
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg=NA)
with(sub_df,plot(DateTime, as.numeric(Global_active_power), type = "l", xlab = "",ylab = "Global Active Power (kilowatts)", main = ""))
dev.off()
