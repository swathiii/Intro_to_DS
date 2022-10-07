# **************************************************************#
# R/Rstudio Practical Week 2
# **************************************************************#

# **************************************************************#
# Lists
# **************************************************************#

a<-list("a", 1, c(4,5,6)) # this creates a new list
a[[1]] # access the first element of the list (by index position)
a[[3]] # access the third element of the list (by index position)
a[c(1,3)] # access the first and third elements of the list (by index position)
names(a)=c("One", "Two", "Three") # give names to the index positions 

# we could have also done this when we created the list using the following:
# a<-list(One="a", Two=1, Three=c(4,5,6))

a[["One"]] # access the first element by its name
a$One # this does the same as the previous command

# Exercise: Can you select the first and third elements using their name?

a[c("One", "Three")]

a<-list(One="a", Two=1, Three=c(4,5,6)) # a new list example

b<-list(text="Data Science is cool", sequence=1:10, data=iris) # another list example

str(b)
# **************************************************************#
# Data frames
# **************************************************************#

medals<-data.frame(Country=c("USA", "GBR", "CHN"), 
                   Gold=c(46,27,26), 
                   Silver=c(37,23,18), 
                   Bronze=c(38,17,26))

medals # display the contents of the data frame
medals$Gold # select the elements of the column called Gold - returns vector
medals[[2]] # select the second column (called Gold) - returns vector

medals["Gold"] # the single [] returns a data frame - test below
class(medals["Gold"]) 

medals[c("Country", "Gold")] # select the columns called Country and Gold - returns data frams
medals[c(1,2)] # same as above buting using index positions

medals[1,]  # select the first row - returns data frame

# Exercise: Can you select the first and third rows (and return as data frame)? 
medals[c(1,3)]

# Exercise: Can you select the first and third rows and the first and third columns (and return as data frame)?
subset(medals, select = c(Country, Silver), subset = (Country == "GBR"))

medals$Country # select the column called Country - returns vector
class(medals$Country)

# Selecting data that matches conditions
medals[medals$Country=="GBR",] # return the rows where Country is Japan (as data frame)
medals[medals$Country=="CHN" | medals$Country=="GBR",] # return the rows where Country is Japan OR Great Britian (as data frame)
medals[medals$Gold>=27,] # return the rows where Gold medals won were >= 20 (as data frame)


# Use of subset to select rows and columns - first select columns
subset(medals, select=Gold) # return a subset of the data frame - just the Gold column
subset(medals, select=c(Country, Gold)) # the same as this command: medals[c("Country", "Gold")]

# Use of subset - select rows matching expression
subset(medals, subset=(Country=="USA"))
subset(medals, subset=(Country=="USA" | Country=="GBR"))

# Use of subset and select together - return specific rows and columns
subset(medals, select=c(Country, Gold), subset=(Country=="USA"))

# Select just the countries who won 27 or more gold medals using the subset command and return Country and Gold columns
subset(medals, select=c(Country, Gold), subset=(Gold >= 27))

# adding single row
newCountry<-data.frame(Country="RUS", Gold=19, Silver=18, Bronze=19)
medals<-rbind(medals, newCountry)

# Exercise: Add rows to medals for Germany and Japan (you can overwrite the newCountry data with the new values)

View(medals)
  
newCountry<-data.frame(Country="GER", Gold=17, Silver=10, Bronze=15)
medals<-rbind(medals, newCountry)

newCountry<-data.frame(Country="JPN", Gold=12, Silver=8, Bronze=21)
medals<-rbind(medals, newCountry)

?mapply

# Adding column totals
ncol(medals)

# Add new column for totals of the Gold, Silver and Bronze medals
medals$Total<-medals$Gold + medals$Silver + medals$Bronze

# If you want to remove the Total column you could do this
medals<-subset(medals, select=c(Country, Gold, Silver, Bronze))

# There's other ways to compute totals etc. over data frames, for example:
# https://www.computerworld.com/article/2486425/business-intelligence/business-intelligence-4-data-wrangling-tasks-in-r-for-advanced-beginners.html?page=2
medals<-transform(medals, Total=Gold+Silver+Bronze)
medals$Total<-mapply(sum, medals$Gold, medals$Silver, medals$Bronze)

medals$Total<-rowSums(medals[c(2,3,4)]) # or using Column names
medals$Total<-rowSums(medals[c("Gold","Silver","Bronze")])

medals[order(medals$Bronze),] # Sort the medals by Bronze (ascending)
medals[order(-medals$Bronze),] # Sort the medals by Bronze (descending)

# Compute the totals of all medals for Gold, Silver and Bronze and Total columns
colSums(medals[c("Gold","Silver","Bronze","Total")])


# **************************************************************#
# Loading in data from CSV file
# **************************************************************#

# load in complete medal table from file (csv file).
# You will have to replace the file name with the correct path on your computer
getwd()
setwd("\\studata08\home\LI\Lir22sc\ManW10\Downloads")

rio2016Medals<-read.csv("Rio2016(2).csv", header=TRUE)
head(rio2016Medals)

getwd()
# Exercise: compute total number of gold, silver and bronze medals scored
total_medals<-transform(rio2016Medals, Total=Gold+Silver+Bronze)
total_medals
total_medals[c("Country", "Total")]
# Exercise: order the rows by the total of medals won
total_medals[order(-total_medals$Total), c("Country", "Total")]

# Exercise: compute total number of gold, silver and bronze medals scored

colSums(rio2016Medals[c("Gold","Silver","Bronze","Total")])

colSums(rio2016Medals[ c( "Gold","Silver","Bronze")])

rio2016Medals

# Now have a go at this tutorial: 
# http://www.r-tutor.com/r-introduction/data-frame


# **************************************************************#
# Optional
# **************************************************************#

?library(MASS)


# That's all folks!

