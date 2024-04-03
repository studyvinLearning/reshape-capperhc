## Hannah Capper
## Data Wrangling HW 9

## Task 2:
# Download and read in the bloodPressure.RDS file
# each row is a person
# blood pressure is measure with two values: systolic and diastolic
# each persons blood pressure was measured every day for a month
# reshape the data to only have 4 columns: person, date, systolic/diastolic, and the value
# fix the date to be in the nice format for R
# calculate the mean diastolic and the mean systolic by the days of the week

blood <- readRDS("bloodPressure.RDS")
head(blood)

# change dataframe from wide to long
long <- pivot_longer(blood,cols = colnames(blood)[-1],
                     names_to = "type",values_to = "bloodPressure")

# break up the type and date strings
split <- strsplit(long$type," ")

type <- sapply(split, function(x) x[[1]])
date <- sapply(split, function(x) x[[2]])

date <- as.Date(date,format = '%Y-%b-%d') # fix the date to be in the nice format for R

# dataframe w/ 4 columns: person, date, systolic/diastolic, and the value
new <- data.frame(person=long$person,type,date,bloodPressure=long$bloodPressure)

# mean diastolic and the mean systolic by the days of the week
aggregate(bloodPressure ~ type + weekdays(date), data = new, FUN = mean)
