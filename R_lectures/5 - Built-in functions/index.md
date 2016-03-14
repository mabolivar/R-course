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

## Useful fuctions

+ `summary()`
+ `table()`
+ `apply()` family functions


--- .class #id 

## `summary()`



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
+ `mapply()`: A multivariate version of `sapply`.
+ `apply`: To apply functions over array margins.
+ `tapply`: To apply a function to each cell of a ranged array. 


---

## `lapply()` function

+ 

---

## References

+ Koduvely, D. H. M. (2015). *Learning Bayesian Models with R*. Packt Publishing Limited.
+ Ross, N. (2013). *FasteR! HigheR! StrongeR! - A Guide to Speeding Up R Code for Busy People*. http://www.noamross.net/blog/2013/4/25/faster-talk.html