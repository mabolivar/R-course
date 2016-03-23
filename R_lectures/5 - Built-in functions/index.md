---
title       : R programming
subtitle    : Lecture 5. R built-in functions
author      : Manuel A. Bolivar
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn       # 
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

## Basic fuctions

+ `apply()`: Family of looping functions
+ `length()`: Return the number of elements in vector x.
+ `paste()` or `paste0()`: Concatenate vectors after converting to character.
+ `rep(1,5)`: Repeat the number 1 five times
+ `seq(1,10,0.4)`: Generate a sequence (1 -> 10, spaced by 0.4)
+ `sort()`: Sort the vector x
+ `order()`: List sorted element numbers of x
+ `summary()`: Returns a summary of a given object (e.g., data frame, lm, etc.).
+ `table()`: Returns a contigency table for each combination of factors.
+ `tolower()`, `toupper()`: Convert string to lower/upper case letters.
+ `unique()`: Remove duplicate entries from vector

--- .class #id 

## Basic fuctions

+ **`apply()`: Family of looping functions**
+ `length()`: Return the number of elements in vector x.
+ `paste()` or `paste0()`: Concatenate vectors after converting to character.
+ `rep(1,5)`: Repeat the number 1 five times
+ `seq(1,10,0.4)`: Generate a sequence (1 -> 10, spaced by 0.4)
+ `sort()`: Sort the vector x
+ `order()`: List sorted element numbers of x
+ **`summary()`: Returns a summary of a given object (e.g., data frame, lm, etc.).**
+ **`table()`: Returns a contigency table for each combination of factors.**
+ `tolower()`, `toupper()`: Convert string to lower/upper case letters.
+ `unique()`: Remove duplicate entries from vector.

---

## `table()`

The `table()` uses the cross-classifiying factors to build a contigency table of the count at each combination of factor levels.

---

## `table()`

The `table()` uses the cross-classifiying factors to build a contigency table of the count at each combination of factor levels.


```r
table(mtcars$cyl)
```

```
## 
##  4  6  8 
## 11  7 14
```


```r
table(mtcars$cyl,mtcars$am)
```

```
##    
##      0  1
##   4  3  8
##   6  4  3
##   8 12  2
```

--- .segue .dark .nobackground

## apply family functions

---

## `apply` family functions

+ Using looping control structure as `for` and `while` are not that much efficient by themselfs. However, pre-allocating memory improves their performace.

+ `apply` functions use efficiently the resources by doing pre-allocation automatically.

+ Using `apply` functions make easy to parallelize your code.

---

## `apply` family functions

+ `lapply()`: To loop over a list and evaluate on each element.
+ `sapply()`: the same as `lapply`, but with the output in a more simpler form.
+ `apply`: To apply functions over array margins.
+ `tapply`: To apply a function to each cell of a ranged array. 


---

## `lapply()` function


```r
args(lapply)
```

```
## function (X, FUN, ...) 
## NULL
```

`lapply` takes three arguments: 
  + `X` a list
  + `FUN` a function
  + `...` additional arguments of the function `FUN`

If `X` is not a list, it will be coerced to a list using `as.list()` function.

`lapply` returns a list.

---

## `lapply()` example


```r
lapply(mtcars,mean) #Returns the mean for each variable in a list
```

```
## $mpg
## [1] 20.09062
## 
## $cyl
## [1] 6.1875
## 
## $disp
## [1] 230.7219
## 
## $hp
## [1] 146.6875
## 
## $drat
## [1] 3.596563
## 
## $wt
## [1] 3.21725
## 
## $qsec
## [1] 17.84875
## 
## $vs
## [1] 0.4375
## 
## $am
## [1] 0.40625
## 
## $gear
## [1] 3.6875
## 
## $carb
## [1] 2.8125
```

---

## `sapply()` function


```r
args(sapply)
```

```
## function (X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) 
## NULL
```

`sapply` takes various arguments: 
  + `X` a list
  + `FUN` a function
  + `...` additional arguments of the function `FUN`
  + `simplify` a logical value. If `TRUE`, should return a simplified version of `lapply` function results. (e.g, vector, matrix or array) 

If `X` is not a list, it will be coerced to a list using `as.list()` function.

---

## `sapply()` example


```r
sapply(mtcars,mean) #Returns the mean for each variable in a vector
```

```
##        mpg        cyl       disp         hp       drat         wt 
##  20.090625   6.187500 230.721875 146.687500   3.596563   3.217250 
##       qsec         vs         am       gear       carb 
##  17.848750   0.437500   0.406250   3.687500   2.812500
```

---

## Exercise 

1. What is the maximum value in each of the variables in `mtcars` data set?

---
## `apply()` function


```r
args(apply)
```

```
## function (X, MARGIN, FUN, ...) 
## NULL
```

`apply` takes four arguments: 
  + `X` an array, including matrix
  + `MARGIN` a vector giving the subscripts which the function will be applied over. e.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. 
  + `FUN` a function
  + `...` additional arguments of the function `FUN`

It is most often used to apply a function to the rows or columns of a matrix.

---

## `apply()` example


```r
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
```

```
##      x1 x2
## [1,]  3  4
## [2,]  3  3
## [3,]  3  2
## [4,]  3  1
## [5,]  3  2
## [6,]  3  3
## [7,]  3  4
## [8,]  3  5
```

---

## `apply()` example



```r
#col sums
apply(x, 2, sum) 
```

```
## x1 x2 
## 24 24
```


```r
#row sums
apply(x, 1, sum) 
```

```
## [1] 7 6 5 4 5 6 7 8
```

---

## `tapply()` function


```r
args(tapply)
```

```
## function (X, INDEX, FUN = NULL, ..., simplify = TRUE) 
## NULL
```

`apply` takes four arguments: 
  + `X` a vector (typically)
  + `INDEX` list of one or more factors, each of same length as `X`. The elements are coerced to factors by `as.factor()`
  + `FUN` a function
  + `...` additional arguments of the function `FUN`

Useful to summarise information across groups

---

## `tapply` example


```r
tapply(mtcars$wt, mtcars$cyl, mean)
```

```
##        4        6        8 
## 2.285727 3.117143 3.999214
```


```r
tapply(mtcars$wt, mtcars$cyl, sd)
```

```
##         4         6         8 
## 0.5695637 0.3563455 0.7594047
```

---
## `tapply` example


```r
weightbycyl <- tapply(mtcars$wt, mtcars$cyl, mean)
barplot(weightbycyl)
```

![plot of chunk unnamed-chunk-14](assets/fig/unnamed-chunk-14-1.png)

---

## `tapply` example 2


```r
#tapply with multiple factors
tapply(mtcars$wt, list(mtcars$cyl,mtcars$carb), mean)
```

```
##        1     2    3        4    6    8
## 4 2.1510 2.398   NA       NA   NA   NA
## 6 3.3375    NA   NA 3.093750 2.77   NA
## 8     NA 3.560 3.86 4.433167   NA 3.57
```

---

## Exercise 

1. Are, in average, cars with automatic transmission (`?mtcars`) heavier that those with manual transmission?
2. Compare `tapply()` and `table()` functions. How are they similar? How are they different?


--- .segue .dark .nobackground

## summary function

---

## `summary()`

`summary` is a generic function used to produce result summaries of the results of various model fitting functions.


```r
data(mtcars) #Load mtcars data to environment
summary(mtcars)
```

```
##       mpg             cyl             disp             hp       
##  Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
##  1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
##  Median :19.20   Median :6.000   Median :196.3   Median :123.0  
##  Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
##  3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
##  Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
##       drat             wt             qsec             vs        
##  Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
##  1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
##  Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
##  Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
##  3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
##  Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
##        am              gear            carb      
##  Min.   :0.0000   Min.   :3.000   Min.   :1.000  
##  1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
##  Median :0.0000   Median :4.000   Median :2.000  
##  Mean   :0.4062   Mean   :3.688   Mean   :2.812  
##  3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
##  Max.   :1.0000   Max.   :5.000   Max.   :8.000
```

---

## Exercises

1. Design a function that receive as argument a numeric vector and returns the descriptive statistics of the vector in a data frame. (`mean`, `sd`, `median`, `minimum`, and `maximum`)
2. Report the descriptive statistics for all the variables in `mtcars` using only one code line.
3. Report the descriptive statistics for the weigth variable (`wt`) group by the transmission type.(`?mtcars`). Use only one code line.

---

## Homework

**PENDING**

---
## References

+ Koduvely, D. H. M. (2015). *Learning Bayesian Models with R*. Packt Publishing Limited.
+ Ross, N. (2013). *FasteR! HigheR! StrongeR! - A Guide to Speeding Up R Code for Busy People*. http://www.noamross.net/blog/2013/4/25/faster-talk.html
