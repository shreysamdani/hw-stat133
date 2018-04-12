Hw04-shrey-samdani
================

Archive of an R Package
-----------------------

``` r
source("../code/archive-functions.R")

raw_data <- read_archive('stringr')
clean_data <- clean_archive(raw_data)
write.csv(clean_data, file = "../data/stringr-archive.csv" )
plot_archive(clean_data)
```

![](../images/unnamed-chunk-1-1.png)

``` r
facetedData = data.frame()
packages = c("ggplot2", "XML", "knitr", "dplyr")
for (package in packages) {
  raw_data <- read_archive(package)
  clean_data <- clean_archive(raw_data)
  write.csv(clean_data, file = paste0("../data/",package,"-archive.csv" ))
  clean_data$type = package
  facetedData <- rbind(facetedData, clean_data)
}
```

``` r
ggplot(data = facetedData, aes(x = date, y = size, color = type)) +
  geom_step() + 
  labs(y = 'Size (KB)')
```

![](../images/unnamed-chunk-2-1.png)

``` r
ggplot(data = facetedData, aes(x = date, y = size, color = type)) +
  geom_step() + 
  labs(y = 'Size (KB)') + 
  facet_wrap(~ type, scales = 'free')
```

![](../images/unnamed-chunk-2-2.png)

Regex Functions
---------------

``` r
source("../code/regex-functions.R")

split_chars('Go Bears!')
```

    ## [1] "G" "o" " " "B" "e" "a" "r" "s" "!"

``` r
split_chars('Expecto Patronum')
```

    ##  [1] "E" "x" "p" "e" "c" "t" "o" " " "P" "a" "t" "r" "o" "n" "u" "m"

``` r
vec <- c('G', 'o', ' ', 'B', 'e', 'a', 'r', 's', '!')
num_vowels(vec)
```

    ## a e i o u 
    ## 1 1 0 1 0

``` r
count_vowels("The quick brown fox jumps over the lazy dog")
```

    ## a e i o u 
    ## 1 3 1 4 2

``` r
count_vowels("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")
```

    ## a e i o u 
    ## 1 3 1 4 2

``` r
reverse_chars("gattaca")
```

    ## [1] "acattag"

``` r
reverse_chars("Lumox Maxima")
```

    ## [1] "amixaM xomuL"

``` r
reverse_words("sentence! this reverse")
```

    ## [1] "reverse this sentence!"

``` r
reverse_words("string")
```

    ## [1] "string"

Data “Emotion in Text”
----------------------

``` r
content = read.csv("../data/text-emotion.csv", stringsAsFactors = F)$content
```

### 3.1) Number of characters per tweet

``` r
counts = nchar(content)
print(summary(counts))
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    1.00   43.00   69.00   73.41  103.00  167.00

``` r
hist(counts, breaks = seq(0, max(counts)+5, by=5))
```

![](../images/unnamed-chunk-9-1.png)

### 3.2) Number of Mentions

``` r
mentions = 1:length(content)
for (i in mentions) {
  mentions[i] = length(grep("@[A-Za-z0-9_]{1,15}$", str_split(content[i], " ")[[1]]))
}

menCounts = table(mentions)

barplot(menCounts)
```

![](../images/unnamed-chunk-10-1.png)

``` r
menCounts
```

    ## mentions
    ##     0     1     2     3     4     5     6     7     8     9    10 
    ## 21373 17935   569    75    27    14     2     1     2     1     1

``` r
content[mentions == 10]
```

    ## [1] "last #ff  @Mel_Diesel @vja4041 @DemonFactory @shawnmcguirt @SEO_Web_Design @ChuckSwanson @agracing @confidentgolf @tluckow @legalblonde31"

### 3.3) Hashtags

``` r
# total hashtags in each tweet
hashtags = 1:length(content)

# lengths of hashtags in each tweet
hashtagLengths = rep(0,max(counts))

for (i in hashtags) {
  
  # split up the tweet into words
  tweetWords = str_split(content[i], " ")[[1]]
  
  # find the hashtags
  whichTags = grep("#[A-Za-z][A-Za-z0-9]*$", tweetWords, value = T)
  
  # find the lengths of the hashtags
  lengthIndices = nchar(whichTags) - 1
  
  # add to the table length
  hashtagLengths[lengthIndices] = hashtagLengths[lengthIndices] + 1
  
  # count how many hashtags there are
  hashtags[i] = length(whichTags)
}

names(hashtagLengths) <- 1:(length(hashtagLengths))

# get the frequencies of the number of hashtags in a tweet
hashCounts = table(hashtags)

#frequencies of counts
hashCounts
```

    ## hashtags
    ##     0     1     2     3     5     7 
    ## 39329   602    55    12     1     1

``` r
barplot(hashCounts)
```

![](../images/unnamed-chunk-11-1.png)

``` r
#avg length of hashtags
sum(hashtagLengths*as.numeric(names(hashtagLengths))/sum(hashtagLengths))
```

    ## [1] 7.628223

``` r
#mode of the length
names(hashtagLengths[hashtagLengths == max(hashtagLengths)])
```

    ## [1] "4"
