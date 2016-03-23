---
title       : R programming
subtitle    : Lecture 6. Data manipulation
author      : Manuel A. Bolivar (Adapted from slides by Hadley Wickham)
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---






<style>
em {
  font-style: italic
}
strong {
  font-weight: bold;
}
</style>

## Outline

1. `dplyr` package
2. One table verbs
3. Data pipelines


--- .class #id 

## `dplyr` package

+ Provides a flexible grammar of data manipulation.
+ Provide blazing fast performance for in-memory data by writing key pieces in C++.
+ Use the same interface to work with data no matter where it's stored, whether in a data frame, a data table or database.


```r
> library(dplyr)
## 
## Attaching package: 'dplyr'
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

---

## `tbl_df()` function

+ Provides a compact view of a data frame


```r
> data(mtcars)
> cars <- tbl_df(mtcars)
> cars
## Source: local data frame [32 x 11]
## 
##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
##    (dbl) (dbl) (dbl) (dbl) (dbl) (dbl) (dbl) (dbl) (dbl) (dbl) (dbl)
## 1   21.0     6   160   110  3.90  2.62  16.5     0     1     4     4
## 2   21.0     6   160   110  3.90  2.88  17.0     0     1     4     4
## 3   22.8     4   108    93  3.85  2.32  18.6     1     1     4     1
## 4   21.4     6   258   110  3.08  3.21  19.4     1     0     3     1
## 5   18.7     8   360   175  3.15  3.44  17.0     0     0     3     2
## 6   18.1     6   225   105  2.76  3.46  20.2     1     0     3     1
## 7   14.3     8   360   245  3.21  3.57  15.8     0     0     3     4
## 8   24.4     4   147    62  3.69  3.19  20.0     1     0     4     2
## 9   22.8     4   141    95  3.92  3.15  22.9     1     0     4     2
## 10  19.2     6   168   123  3.92  3.44  18.3     1     0     4     4
## ..   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...
```

---

## One table verbs

+ **`filter`**: keep rows with matching condition.
+ **`select`**: select columns by name.
+ **`arrange`**: reorder rows.
+ **`mutate`**: add new variables.
+ **`summarise`**: reduce variables to values.

---

## Structure

+ First argument is a data frame.
+ Subsequent arguments say what to do with the data frame.
+ Always return a data frame.

---

## The `filter` verb


```r
> df <- data.frame(
+ color = c("blue", "black", "blue", "blue", "black"),
+ value = 1:5)
> df
##   color value
## 1  blue     1
## 2 black     2
## 3  blue     3
## 4  blue     4
## 5 black     5
```


```r
> filter(df,color == "blue")
```

---

## The `filter` verb


```r
> df <- data.frame(
+ color = c("blue", "black", "blue", "blue", "black"),
+ value = 1:5)
> df
##   color value
## 1  blue     1
## 2 black     2
## 3  blue     3
## 4  blue     4
## 5 black     5
```


```r
> filter(df,color == "blue")
##   color value
## 1  blue     1
## 2  blue     3
## 3  blue     4
```

---

## The `filter` verb


```r
> df <- data.frame(
+ color = c("blue", "black", "blue", "blue", "black"),
+ value = 1:5)
> df
##   color value
## 1  blue     1
## 2 black     2
## 3  blue     3
## 4  blue     4
## 5 black     5
```


```r
> filter(df,value %in% c(2,4))
```

--- .segue .dark .nobackground

## nycflights13 data

---


## nycflights13 data


```r
> library(nycflights13)
> data(flights) #every flight departing NYC in 2013
> dim(flights)
## [1] 336776     16
```

```r
> data(weather)
> dim(weather)
## [1] 8719   14
```


```r
> data(planes)
> dim(planes)
## [1] 3322    9
```



```r
> data(airports)
> dim(airports)
## [1] 1397    7
```

---

## flights data frame


```r
> str(flights)
## Classes 'tbl_df', 'tbl' and 'data.frame':	336776 obs. of  16 variables:
##  $ year     : int  2013 2013 2013 2013 2013 2013 2013 2013 2013 2013 ...
##  $ month    : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ day      : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ dep_time : int  517 533 542 544 554 554 555 557 557 558 ...
##  $ dep_delay: num  2 4 2 -1 -6 -4 -5 -3 -3 -2 ...
##  $ arr_time : int  830 850 923 1004 812 740 913 709 838 753 ...
##  $ arr_delay: num  11 20 33 -18 -25 12 19 -14 -8 8 ...
##  $ carrier  : chr  "UA" "UA" "AA" "B6" ...
##  $ tailnum  : chr  "N14228" "N24211" "N619AA" "N804JB" ...
##  $ flight   : int  1545 1714 1141 725 461 1696 507 5708 79 301 ...
##  $ origin   : chr  "EWR" "LGA" "JFK" "JFK" ...
##  $ dest     : chr  "IAH" "IAH" "MIA" "BQN" ...
##  $ air_time : num  227 227 160 183 116 150 158 53 140 138 ...
##  $ distance : num  1400 1416 1089 1576 762 ...
##  $ hour     : num  5 5 5 5 5 5 5 5 5 5 ...
##  $ minute   : num  17 33 42 44 54 54 55 57 57 58 ...
```

---

## Exercises

Find all flights:

+ To SFO or OAK
+ In January
+ Delayed more than an hour
+ That departed between midnight and five am.
+ That departed before 5am or after 10pm.

---

## The `select` verb


```r
> select(df, color)
##   color
## 1  blue
## 2 black
## 3  blue
## 4  blue
## 5 black
```

---

## The `select` verb


```r
> select(df, color)
##   color
## 1  blue
## 2 black
## 3  blue
## 4  blue
## 5 black
```


```r
> select(df, -color)
##   value
## 1     1
## 2     2
## 3     3
## 4     4
## 5     5
```

---

## The `select` verb

Exist different ways to select columns using the `select` verb.

e.g. How to select the two delay variables in the flights data frame?

---

## The `select` verb

Exist different ways to select columns using the `select` verb.

e.g. How to select the two delay variables in the flights data frame?


```r
> select(flights, arr_delay, dep_delay)
> select(flights, dep_delay, dep_delay + 2)
> select(flights, ends_with("delay"))
> select(flights, contains("delay"))
> select(flights, one_of(c(arr_delay, dep_delay)))
> select(flights, arr_delay:dep_delay) # Returns every thinkg between the vars
```

---

## The `arrange` verb


```r
> arrange(df, color)
##   color value
## 1 black     2
## 2 black     5
## 3  blue     1
## 4  blue     3
## 5  blue     4
```

---

## The `arrange` verb


```r
> arrange(df, color)
##   color value
## 1 black     2
## 2 black     5
## 3  blue     1
## 4  blue     3
## 5  blue     4
```


```r
> arrange(df, desc(value))
##   color value
## 1 black     5
## 2  blue     4
## 3  blue     3
## 4 black     2
## 5  blue     1
```

---

## The `arrange` verb


```r
> arrange(df, color, desc(value))
##   color value
## 1 black     5
## 2 black     2
## 3  blue     4
## 4  blue     3
## 5  blue     1
```

---

## Exercises

+ Order the flights by departure date and time.
+ Which flights were most delayed?
+ Which flights caught up the most time
+ during the flight?

---

## The `mutate` verb


```r
> mutate(df, double = 2 * value)
##   color value double
## 1  blue     1      2
## 2 black     2      4
## 3  blue     3      6
## 4  blue     4      8
## 5 black     5     10
```

---

## The `mutate` verb


```r
> mutate(df, double = 2 * value,
+        quadruple = 2*double)
##   color value double quadruple
## 1  blue     1      2         4
## 2 black     2      4         8
## 3  blue     3      6        12
## 4  blue     4      8        16
## 5 black     5     10        20
```

---

## Exercises

1. Compute speed in mph from time (in minutes) and distance (in miles). Which flight flew the fastest?
2. Add a new variable that shows how much time was made up or lost in flight.
3. Create a new variable `date` that agregates year, month and day variables. Hint: try `ISOdate(year, month, day)`

---

## The `summarise` verb


```r
> df
##   color value
## 1  blue     1
## 2 black     2
## 3  blue     3
## 4  blue     4
## 5 black     5
```



```r
> summarise(df, total = sum(value))
##   total
## 1    15
```

---

## The `summarise` verb 

+ Most data operations are useful done on groups defined by variables in the the dataset.
+ The `group_by` function takes an existing tbl and converts it into a grouped tbl where operations are performed "by group".

---

## The `summarise` verb 

+ Most data operations are useful done on groups defined by variables in the the dataset.
+ The `group_by` function takes an existing tbl and converts it into a grouped tbl where operations are performed "by group".


```r
> by_color <- group_by(df, color)
> summarise(by_color, total = sum(value))
## Source: local data frame [2 x 2]
## 
##    color total
##   (fctr) (int)
## 1  black     7
## 2   blue     8
```

---

## The `summarise` verb 


```r
> by_date <- group_by(flights, month, day)
> by_hour <- group_by(flights, month, day, hour)
> by_plane <- group_by(flights, tailnum)
> by_dest <- group_by(flights, dest)
```

---

## Summary functions

+ `min(x)`, `max(x)`, `median(x)`, `mean(x)`
+ `n()`, `n_distinct()`, `sum(x)`
+ `sum(x>15)`, `mean(x>15)`

---

## Exercises

1. What is the plane with most flights along 2013?
2. Create a new data frame with the mean, median and standard deviation of departure delay by date.

--- .segue .dark .nobackground

## Data pipelines (%>%)

---

## Data pipelines (`%>%`)

The verbs and functions in R are really useful however it is hard t read multiple oprations.




```r
> hourly_delay <- filter(
+   summarise(
+     group_by(
+       filter(
+         flights,
+         !is.na(dep_delay)
+       ),
+       date, hour
+     ),
+     delay = mean(dep_delay),
+     n = n()
+   ),
+   n > 10
+ )
```

---

## Data pipelines (`%>%`)

**Solution**: The pipeline operator from `magrit` package


```r
> hourly_delay <- flights %>%
+   filter(!is.na(dep_delay)) %>%
+   group_by(date, hour) %>%
+   summarise(delay = mean(dep_delay), n = n())  %>%
+   filter(n > 10)
```

---

## Exercises

Create data pipelines to answer the following
questions:

1. Which destinations have the highest average
delays?
2. Which flights operate every day of the year?

---

## References

+ RStudio. *Data wrangling with dplyr and tidyr*. https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

