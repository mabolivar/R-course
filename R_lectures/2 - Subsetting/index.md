---
title       : R programming
subtitle    : Lecture 2. Subsetting
author      : Manuel A. Bolivar
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn       # tomorrow
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

## Subsetting

+ Subsetting allows you to pull out the pieces that you’re interested in. 
+ R’s subsetting operators are powerful and fast.
+ Subsetting can be applied to vectors, lists, factors, arrays, and data frames. 


--- .class #id 

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Positive integers:` Return elements at the specified positions.

---

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Positive integers:` Return elements at the specified positions.


```r
x[c(2,4)]
```

```
## [1] 4.2 5.4
```


```r
x[order(x)]
```

```
## [1] 2.1 3.3 4.2 5.4
```


```r
x[c(1,1)]
```

```
## [1] 2.1 2.1
```

---

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Negative integers:` omit elements at the specified positions.

---

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Negative integers:` omit elements at the specified positions.


```r
x[-c(2,4)]
```

```
## [1] 2.1 3.3
```

but you can´t mix positive and neative integers.


```r
x[c(-2,4)]
```

```
## Error in x[c(-2, 4)]: solamente 0's pueden ser mezclados con subscritos negativos
```


---

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Logical vectors`: select elements where the corresponding logical value is `TRUE`.

---

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Logical vectors`: select elements where the corresponding logical value is `TRUE`.



```r
x[c(TRUE,FALSE,TRUE,TRUE)]
```

```
## [1] 2.1 3.3 5.4
```


```r
x[x>3]
```

```
## [1] 4.2 3.3 5.4
```


---

## Vectors


```r
x <- c(2.1, 4.2, 3.3, 5.4)
```

`Logical vectors`: select elements where the corresponding logical value is `TRUE`.


```r
x[c(TRUE,FALSE,TRUE,TRUE)]
```

```
## [1] 2.1 3.3 5.4
```


```r
x[x>3]
```

```
## [1] 4.2 3.3 5.4
```

If the logical vector is shorter than the vector being subsetted, it will be recycled to be the same length.


```r
x[c(TRUE, FALSE)]
```

```
## [1] 2.1 3.3
```

```r
x[c(TRUE, FALSE,TRUE, FALSE)]
```

```
## [1] 2.1 3.3
```

---

## Matrices and arrays

The most common way of subsetting matrices (2d) and arrays (>2d) is a simple generalisation of 1d subsetting: 

+ Supply a 1d index for each dimension, separated by a comma. 
+ Blank subsetting is now useful because it lets you keep all rows or all columns.


```r
a <- matrix(1:9, nrow = 3)
a
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

---

## Matrices and arrays - examples


```r
a
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

Write the statements that return each of the following statements for matrix `a`:

 + 3th row
 + 2nd column
 + 1st and 2nd column
 + Element located at the 2nd row and second column
 + The intersection between the 2nd and 3rd rows and the 1st and 3rd columns

---

## Matrices and arrays - examples


```r
a
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```


```r
a[,3] # 3th  column of the matrix
```

```
## [1] 7 8 9
```


```r
a[2,] # 2th row of the matrix
```

```
## [1] 2 5 8
```


```r
a[c(2,3),c(1,3)] # 2nd and 3rd rows and 1st and 3rd columns of the matrix
```

```
##      [,1] [,2]
## [1,]    2    8
## [2,]    3    9
```

---

## Data frames

+ Data frame subsetting works like matrices 
+ Now we have an additional operator `$` besides `[`.


```r
df <- data.frame(ID = 1:4, 
                 Color = c("red","white","red",NA),
                 Passed = c(T,T,T,F),
                 stringsAsFactors = F)
df
```

```
##   ID Color Passed
## 1  1   red   TRUE
## 2  2 white   TRUE
## 3  3   red   TRUE
## 4  4  <NA>  FALSE
```

--- &twocol

## Data frames - examples

Using the `[`, we will obtain a data frame.


```r
str(df)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ ID    : int  1 2 3 4
##  $ Color : chr  "red" "white" "red" NA
##  $ Passed: logi  TRUE TRUE TRUE FALSE
```

*** =left


```r
df[1]
```

```
##   ID
## 1  1
## 2  2
## 3  3
## 4  4
```

```r
class(df[1])
```

```
## [1] "data.frame"
```

*** =right


```r
df["ID"]
```

```
##   ID
## 1  1
## 2  2
## 3  3
## 4  4
```

```r
class(df["ID"])
```

```
## [1] "data.frame"
```

--- &twocol

## Data frames - examples

Using the `[[` or `$`, we obtain a vector.


```r
str(df)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ ID    : int  1 2 3 4
##  $ Color : chr  "red" "white" "red" NA
##  $ Passed: logi  TRUE TRUE TRUE FALSE
```

*** =left


```r
df$ID
```

```
## [1] 1 2 3 4
```

```r
class(df$ID)
```

```
## [1] "integer"
```

*** =right


```r
df[["ID"]]
```

```
## [1] 1 2 3 4
```

```r
class(df[["ID"]])
```

```
## [1] "integer"
```


---

## Lists

Subseting lists works the same than subsetting a vector.

+ `[` returns a list.
+ `[[` and `$` return the components of the list.


```r
x <- list(a=c(5:9),b=c(TRUE,FALSE,FALSE,TRUE), c=list("four","five"))
str(x)
```

```
## List of 3
##  $ a: int [1:5] 5 6 7 8 9
##  $ b: logi [1:4] TRUE FALSE FALSE TRUE
##  $ c:List of 2
##   ..$ : chr "four"
##   ..$ : chr "five"
```

---

## Lists


```r
x <- list(a=c(5:9),b=c(TRUE,FALSE,FALSE,TRUE), c=list("four","five"))
```

For example, `x[1]` and `x["a"]` return a list.


```r
x[1]
```

```
## $a
## [1] 5 6 7 8 9
```

```r
class(x[1])
```

```
## [1] "list"
```


```r
x["a"]
```

```
## $a
## [1] 5 6 7 8 9
```

```r
class(x["a"])
```

```
## [1] "list"
```

---

## Lists


```r
x <- list(a=c(5:9),b=c(TRUE,FALSE,FALSE,TRUE), c=list("four","five"))
```

But `x$a`, `x[[1]]`, and `x[["a"]]` return a vector.


```r
x[[1]]
```

```
## [1] 5 6 7 8 9
```

```r
class(x[[1]])
```

```
## [1] "integer"
```


```r
x$a
```

```
## [1] 5 6 7 8 9
```

```r
class(x$a)
```

```
## [1] "integer"
```

---

## Exercises

1. If a matrix `a` is defined as `a <- matrix(1:9, nrow = 3)`, what would return `a[c(TRUE,TRUE,FALSE),c(-3)]`?
2. Fix each of the following common data frame subsetting errors:
  + `mtcars[mtcars$cyl = 4, ]`
  + `mtcars[-1:4, ]`
  + `mtcars[mtcars$cyl <= 5]`
  + `mtcars[mtcars$cyl == 4 | 6, ]`
  
3. Given a linear model, e.g., `mod <- lm(mpg ~ wt, data = mtcars)`, extract the residual degrees of freedom. Extract the R squared from the model summary (`summary(mod)`)

---

## References

+ Wickham, H. (2014). *Advanced R*. CRC Press.
