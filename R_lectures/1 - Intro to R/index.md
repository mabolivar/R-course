---
title       : R programming
subtitle    : Lecture 1. Data types & structures
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

## Course outline
1. Introduction to R
2. Control structures 
3. R functions 
4. Reading and writing data 
5. Dates & times 
6. Plotting in R 
7. Manipulating & tidying data 
8. Processing acelerometry data

---

## Session 1 - Outline

1. Introduction to R
  - What is R?
  - Data structures
  - Subsetting


--- .class #id 


## What is R?

<center><img src="https://www.r-project.org/logo/Rlogo.png" alt="Drawing" style="width: 250px;"/></center>

+ R is a language and environment for statistical computing and graphics. 
+ R provides a wide variety of statistical (linear and nonlinear modelling, classical statistical tests, time-series analysis, classification, clustering, ...) and graphical techniques.


--- 

## Why should we learn R?


+ Open source
+ Cross-platform compatible
+ Advance statistical language
+ Outstanding graphs
+ Built-in modules
+ Extensible
+ Vast community 
+ Short program length
+ Widely supported (Books, web pages, etc)

---

## R vs. SAS vs. SPSS

[link](https://www.google.com/trends/explore#q=%2Fm%2F0212jm%2C%20%2Fm%2F02l0yf8%2C%20%2Fm%2F018fh1&cmpt=q&tz=Etc%2FGMT%2B5)

<script type="text/javascript" src="//www.google.com/trends/embed.js?hl=es&q=/m/0212jm,+/m/02l0yf8,+/m/018fh1&cmpt=q&tz=Etc/GMT%2B5&tz=Etc/GMT%2B5&content=1&cid=TIMESERIES_GRAPH_0&export=5&w=500&h=330"></script>


---
## RStudio

RStudio is an Integrated Development Environment (IDE) that makes R easier to use.

<center><img src="https://www.rstudio.com/wp-content/uploads/2014/04/rstudio-windows.png" alt="RStudio" style="width: 600px;"/></center>

--- .segue .dark .nobackground

## Data types & data structures

---

## Data types & data structures

**R** has a wide variety of **data types**:

+ Numeric / Integer
+ Character
+ Logical (True/False)
+ Date

And **data structures**:

+ Vectors
+ Lists
+ Factors
+ Matrices
+ Data frames


---

## Vector

The basic data structure in R is the vector.
  + All elements must be the same type.
  + Created with `c()` (combine).


```r
# numeric vector
a <- c(1,2,3,6,-2,4)

# character vector
b <- c("one","two","three")

# logical vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)
```

---

## Vector

Vectors have three common properties
 + `typeof()`: what it is.
 + `length()`: how many elements contains.
 + `attributes()`: additionally arbitrary data.


```r
a
```

```
## [1]  1  2  3  6 -2  4
```

```r
typeof(a)
```

```
## [1] "double"
```

```r
length(a)
```

```
## [1] 6
```

```r
attributes(a)
```

```
## NULL
```

---

## Vector

Given a vector, you can ask if correspond to certain type:
 + `is.numeric()`
 + `is.integer()`
 + `is.character()`
 + `is.logical()`
 

```r
is.character(a)
```

```
## [1] FALSE
```

```r
is.numeric(a)
```

```
## [1] TRUE
```

---

## Vector coercion

**Q:** What happend if you attempt to combine different elements types in one vector?


```r
 c(FALSE,1,2)
```


```r
 c(1,2,"three")
```


```r
 c(FALSE,3,"two")
```

---

## Vector coercion

**A:** They will be coerced to the most **flexible type**.

<center>logical `<` integer `<` double `<` character
</center>


```r
 c(FALSE,1,2)
```

```
## [1] 0 1 2
```


```r
 c(1,2,"three")
```

```
## [1] "1"     "2"     "three"
```


```r
 c(FALSE,3,"two")
```

```
## [1] "FALSE" "3"     "two"
```

---

## Bonus: The `str()` function

+ `str()` is short for structure.
+ `str()` provides a human readable description of any R data structure.


```r
 str(c(FALSE,1,2))
```

```
##  num [1:3] 0 1 2
```


```r
 str(c(1,2,"three"))
```

```
##  chr [1:3] "1" "2" "three"
```


```r
 str(c(FALSE,3,"two"))
```

```
##  chr [1:3] "FALSE" "3" "two"
```

---

## Lists

List can contain elements of any type, including lists.
  + Use `list()` to construct lists.
  + Some built-in functions returns lists as output.
  

```r
x <- list(5:9,a,b,c, list("four","five"))
```

What is going to return the command `str(x)`?

---

## Lists

List can contain elements of any type, including lists.
  + Use `list()` to construct lists.
  + Some built-in functions returns lists as output.
  

```r
x <- list(5:9,a,b,c, list("four","five"))
```

What is going to return the command `str(x)`?


```
## List of 5
##  $ : int [1:5] 5 6 7 8 9
##  $ : num [1:6] 1 2 3 6 -2 4
##  $ : chr [1:3] "one" "two" "three"
##  $ : logi [1:6] TRUE TRUE TRUE FALSE TRUE FALSE
##  $ :List of 2
##   ..$ : chr "four"
##   ..$ : chr "five"
```

---

## Factors

A factor is a vector that can contain only predefined values, and is used to store categorical data (Wickham, 2014).


```r
x <- factor(c("a", "b", "b", "a"))
x
```

```
## [1] a b b a
## Levels: a b
```

---

## Factors

A factor is a vector that can contain only predefined values, and is used to store categorical data (Wickham, 2014).


```r
x <- factor(c("a", "b", "b", "a"))
x
```

```
## [1] a b b a
## Levels: a b
```


```r
class(x)
```

```
## [1] "factor"
```

```r
levels(x)
```

```
## [1] "a" "b"
```

---

## Factors

A factor is a vector that can contain only predefined values, and is used to store categorical data (Wickham, 2014).


```r
x <- factor(c("a", "b", "b", "a"))
x
```

```
## [1] a b b a
## Levels: a b
```


```r
class(x)
```

```
## [1] "factor"
```

```r
levels(x)
```

```
## [1] "a" "b"
```


```r
str(x)
```

```
##  Factor w/ 2 levels "a","b": 1 2 2 1
```

---

## Matrices

+ Adding a `dim()` attribute to a vector allows it to behave like a multi-dimensional array (matrix).
+ Matrices are created with `matrix()`.


```r
#A matrix of 3x4 dimensions
a <- matrix(1:12,ncol=4, nrow=3)
a
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
```

---

## Matrices

+ Adding a `dim()` attribute to a vector allows it to behave like a multi-dimensional array (matrix).
+ Matrices are created with `matrix()`.


```r
#A matrix of 3x4 dimensions
a <- matrix(1:12,ncol=4, nrow=3)
a
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
```


```r
#A second matrix
b <- 1:12
dim(b) <- c(3,4)
```

Are matrices `a` and `b` equal?

---


## Arrays

+ An array is matrix of more than two dimensions.
+ Arrays are created with `array()`.


```r
c <- array(1:12, c(2, 3, 2))
c
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    7    9   11
## [2,]    8   10   12
```

---

## Names and dimensions

+ `nrow()` and `ncol()` return the number of rows and columns for a matrix respectively.
+ `dim()` "returns" the dimensions of an array.


```r
nrow(a)
```

```
## [1] 3
```

```r
ncol(a)
```

```
## [1] 4
```

```r
dim(c)
```

```
## [1] 2 3 2
```

What do `length()` and `dim()` return when they are applied to a matrix?

---

## Names and dimensions

+ `nrow()` and `ncol()` return the number of rows and columns for a matrix respectively.
+ `dim()` "returns" the dimensions of an array (including matrices)


```r
nrow(a)
```

```
## [1] 3
```

```r
ncol(a)
```

```
## [1] 4
```

```r
dim(c)
```

```
## [1] 2 3 2
```

What do `length()` and `dim()` return when they are applied to a matrix?

```r
length(a)
```

```
## [1] 12
```

```r
dim(a)
```

```
## [1] 3 4
```

---

## Names and dimensions

+ `rownames()` and `colnames()` "return" row an column names.
+ `dimnames()` "returns" a list of character vectors for arrays.


```r
rownames(a)
```


```r
colnames(a)
```

---

## Names and dimensions

+ `rownames()` and `colnames()` "return" row an column names.
+ `dimnames()` "returns" a list of character vectors for arrays.


```r
rownames(a)
```

```
## NULL
```


```r
colnames(a)
```

```
## NULL
```

---

## Names and dimensions

+ `rownames()` and `colnames()` "return" row an column names.
+ `dimnames()` "returns" a list of character vectors for arrays.


```r
rownames(a) <- c("A","B","C")
colnames(a) <- c("a","b","c","d")
```


```r
a
```

---

## Names and dimensions

+ `rownames()` and `colnames()` "return" row an column names.
+ `dimnames()` "returns" a list of character vectors for arrays.


```r
rownames(a) <- c("A","B","C")
colnames(a) <- c("a","b","c","d")
```


```r
a
```

```
##   a b c  d
## A 1 4 7 10
## B 2 5 8 11
## C 3 6 9 12
```


```r
str(a)
```

---

## Names and dimensions

+ `rownames()` and `colnames()` "return" row an column names.
+ `dimnames()` "returns" a list of character vectors for arrays.


```r
rownames(a) <- c("A","B","C")
colnames(a) <- c("a","b","c","d")
```


```r
a
```

```
##   a b c  d
## A 1 4 7 10
## B 2 5 8 11
## C 3 6 9 12
```


```r
str(a)
```

```
##  int [1:3, 1:4] 1 2 3 4 5 6 7 8 9 10 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:3] "A" "B" "C"
##   ..$ : chr [1:4] "a" "b" "c" "d"
```

---

## Data frames

A data frame is the most common way of storing data in R, and if used systematically makes data analysis easier.

 + A data frame is a list of equal-length vectors.
 + This makes it a 2-dimensional structure, so it shares properties of matrices and lists.
 + The data frames have `names()`, `colnames()`, `rownames()`, `ncol()`, and `nrow()`. 

---

## Data frames

`data.frame()` takes vectors as input and creates data.frames.


```r
df <- data.frame(x = 1:3, y = c("a", "b", "c"))
```

+ How are data frames similar to matrices?
+ How are data frames similar to lists? 
  (Hint: `str()`)

---

## Data frames

`data.frame()` takes vectors as input and creates data.frames.


```r
df <- data.frame(x = 1:3, y = c("a", "b", "c"))
```

+ How are data frames similar to matrices?
+ How are data frames similar to lists? 
  (Hint: `str()`)
  

```r
df
```

```
##   x y
## 1 1 a
## 2 2 b
## 3 3 c
```


--- 

## Data frames with factors

+ `data.frame` convert character vectors into factors by default.
+ To avoid this, you can use `stringAsFactors = FALSE`.



```r
df <- data.frame(
  x = 1:3, y = c("a", "b", "c"))
str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ x: int  1 2 3
##  $ y: Factor w/ 3 levels "a","b","c": 1 2 3
```


```r
df <- data.frame(
  x = 1:3, y = c("a", "b", "c"),
  stringsAsFactors = FALSE)
str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ x: int  1 2 3
##  $ y: chr  "a" "b" "c"
```

---

## Coersion

You can coerce an object to a data frame with `as.data.frame()`:

+ A vector will create a one-column data frame.
+ A list will create one column for each element; it’s an error if they’re not all the same length.
+ A matrix will create a data frame with the same number of columns and rows as the matrix.

Lets try:


```r
x <- as.data.frame(a)
```

---

## Coersion

You can coerce an object to a data frame with `as.data.frame()`:

+ A vector will create a one-column data frame.
+ A list will create one column for each element; it’s an error if they’re not all the same length.
+ A matrix will create a data frame with the same number of columns and rows as the matrix.

Lets try:


```r
x <- as.data.frame(a)
```


```r
x
```

```
##   a b c  d
## A 1 4 7 10
## B 2 5 8 11
## C 3 6 9 12
```

---

## Combining data frames

Data frames con be combined using `cbind()` or `rbind()`.


```r
cbind(df, data.frame(z = 3:1))
```


```r
rbind(df, data.frame(x=10,y = "z"))
```

---

## Combining data frames

Data frames con be combined using `cbind()` or `rbind`.


```r
cbind(df, data.frame(z = 3:1))
```

```
##   x y z
## 1 1 a 3
## 2 2 b 2
## 3 3 c 1
```


```r
rbind(df, data.frame(x=10,y = "z"))
```

```
##    x y
## 1  1 a
## 2  2 b
## 3  3 c
## 4 10 z
```

---

## Exercises

1. If `is.matrix(x)` is TRUE, what will `is.array(x)` return?
2. What does `as.matrix()` do when applied to a data frame with columns of different types?
3. Given two vectors `a <- c(1:3)` and `b <- c("a","b","c")`, if I want to build a data.frame maintaining the vectors' original data types, should I combine them first (`cbind`) and them turn them as data.frame or visceversa?


