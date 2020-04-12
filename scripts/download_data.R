

# data URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# check if the data directory exists
# create it if not found
if (!dir.exists("data")) {
        dir.create("data")
}


# download the zip file to the data folder
download.file(url, file.path("data", "data.zip"))

message("data.zip downloaded to ./data folder")

# unzip the data
unzip("./data/data.zip", exdir="./data")