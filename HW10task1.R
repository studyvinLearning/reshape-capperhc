## Hannah Capper
## Data Wrangling HW 9

## Task 1:
# Use data(federalistPapers, package='syllogi') to get the federalist paper data
# Create a data frame that paper number, author, journal, date
# Determine the day of the week that each paper was published.
# Get the count of papers by day of the week and author
# create a new data frame that has authors as column names and dates of publication as the values

data(federalistPapers, package='syllogi')
str(federalistPapers)

n <- length(federalistPapers) # 86 papers

# grab the first element of each thing in the list
out <- sapply(federalistPapers, function(x) x[[1]])

paperNum <- unlist(out["number",1:n])
author <- unlist(out["author",1:n])
journal <- unlist(out["journal",1:n])
date <- do.call("c",out["date",1:n]) # unlist turns dates into numeric so use do.call

#data frame that paper number, author, journal, date
mydf <- data.frame(paperNum,author,journal,date)

class(mydf$date) # check that date is of data type "Date"
day <- weekdays(mydf$date) # get day of the week from the date

mydfWithDay <- cbind(mydf,day)

# Get the count of papers by day of the week and author
aggregate(paperNum ~ author + day, data=mydfWithDay, FUN=length)


# create new ID by author
towide <- mydf[c('author','date')]
towide <- towide[order(towide$author),]
mytable <- table(towide$author)
towide$ID <- c(1:mytable[[1]],1:mytable[[2]],1:mytable[[3]],1:mytable[[4]],1:mytable[[5]])

# data frame that has authors as column names and dates of publication as the values
reshape(data=towide,
        direction = "wide",
        timevar = 'author', # categorical column name
        idvar = 'ID', #
        v.names = 'date' # values col name (data that is getting moved)
        ,varying = c('HAMILTON','JAY','MADISON','HAMILTON AND MADISON','HAMILTON OR MADISON')
        )

pivot_wider(data = towide, id_cols = 'ID',
            names_from = 'author', values_from = 'date')


