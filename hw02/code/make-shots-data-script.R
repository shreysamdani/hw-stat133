###############################################################################
# Title: Make shots-data script
# description: This script generates the shot data based on inputs and outputs
# inputs: data files of statistics of shots made by NBA players
# output: csv spreadsheet that summarizes the data
###############################################################################

# packages
library(dplyr)

# read files
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)

# add name column and minutes column
curry <- mutate(curry, name = 'Stephen Curry', minute = 12*period - minutes_remaining)
iguodala <- mutate(iguodala, name = 'Andre Iguodala', minute = 12*period - minutes_remaining)
durant <- mutate(durant, name = 'Kevin Durant', minute = 12*period - minutes_remaining)
thompson <- mutate(thompson, name = 'Klay Thompson', minute = 12*period - minutes_remaining)
green <- mutate(green, name = 'Draymond Green', minute = 12*period - minutes_remaining)

# change values of shot made flag
curry$shot_made_flag[curry$shot_made_flag == 'y'] = 'made shot'
curry$shot_made_flag[curry$shot_made_flag == 'n'] = 'missed shot'

iguodala$shot_made_flag[iguodala$shot_made_flag == 'y'] = 'made shot'
iguodala$shot_made_flag[iguodala$shot_made_flag == 'n'] = 'missed shot'

durant$shot_made_flag[durant$shot_made_flag == 'y'] = 'made shot'
durant$shot_made_flag[durant$shot_made_flag == 'n'] = 'missed shot'

thompson$shot_made_flag[thompson$shot_made_flag == 'y'] = 'made shot'
thompson$shot_made_flag[thompson$shot_made_flag == 'n'] = 'missed shot'

green$shot_made_flag[green$shot_made_flag == 'y'] = 'made shot'
green$shot_made_flag[green$shot_made_flag == 'n'] = 'missed shot'

# sink files
sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()

sink(file = '../output/klay-thompson-summary.txt')
summary(thompson)
sink()

# combine tables and export
data = rbind(iguodala, green, curry, durant, thompson)
write.csv(data, file = '../data/shots-data.csv', row.names = F)

sink(file = '../output/shots-data-summary.txt')
summary(data)
sink()



