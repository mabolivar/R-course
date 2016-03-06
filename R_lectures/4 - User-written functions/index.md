---
title       : R programming
subtitle    : Lecture 4. User-defined functions
author      : Manuel A. Bolivar
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



## R functions

Functions are created using `fuction()` and are stored as R objects and are considered *first class objects*, i.e.,

  + Functions can be assigned to variables.
  + Functions can be stored in lists.
  + Functions can be nested (functions inside fuctions).
  + Functions can be passed as argumments of other functions.

--- .class #id 

## Syntaxis

The functions are R objects of class *function*.


```r
> f <- function(args){
+   body #Do something interesting
+ }
```

where 
+ *args* is a set of symbol names.
+ *body* is an R expression.

---

## Arguments

Function arguments might include default values.
  + Arguments with default values are optional.
  + The *formal arguments* are the arguments included in the function definition.
  + The `args()` functions returns the function arguments.
  + A function call might not use all formal arguments.

---

## My first function

Desing a function that returns the mean of numeric vector.

---

## My first function

Desing a function that returns the mean of numeric vector.


```r
> f <- function(x) {
+   m <- sum(x)/length(x)
+   return(m)
+ }
```

---

## My first function

Desing a function that returns the mean of numeric vector.


```r
> f <- function(x) {
+   m <- sum(x)/length(x)
+   return(m)
+ }
```


```r
> a <- c(2,4,6,8,10)
> f(a)
## [1] 6
```

---

## Argument matching

Arguments can be matched by position and name.


```r
> args(plot) #argument names of plot function
## function (x, y, ...) 
## NULL
```

All the following calls to the `plot()` function are equivalent.


```r
> plot(1:20,log(1:20))
> plot(1:20,y = log(1:20))
> plot(x = 1:20, y = log(1:20))
> plot(y = log(1:20),x = 1:20)
```

---

## Return values

The `return()` function specifies the value (vector, list, data.frame, function) returned by the function. For example,


```r
> f <- function(x){
+   return(x^2+5)
+ }
```

However, if the `return()` function is not used, R returns the last expression in the *body* evaluated.


```r
> f <- function(x){
+   x^2+5
+ }
```

---

## Lazy evaluation

Arguments to functions are evaluated only as needed (*lazily*). For example,


```r
> f <- function(a,b){
+   a^3
+ }
```


```r
> f(2) #Equivalent to f(a=2)
## [1] 8
```

---

## Lazy evaluation

R executed the function's body statements sequentially.


```r
> f <- function(a, b) {
+ print(a)
+ print(b)
+ }
```


```r
> f(30)
## [1] 30
## Error in print(b): el argumento "b" está ausente, sin valor por omisión
```

---

## The `...` argument

The `...` arguments indicates a variable number of arguments. It is used when:
  + The number of arguments passed to the function is not known it advanced (e.g. `paste()`).
  
  ```r
  > args(paste)
  ## function (..., sep = " ", collapse = NULL) 
  ## NULL
  ```
  + The functions is extending another function and uses the same arguments (e.g. `plot()`).
  
  ```r
  > args(plot)
  ## function (x, y, ...) 
  ## NULL
  ```
  + Take into acount that any argument after `...` must be named explicitly. 

---

## Exercises

1. Design a function that receive as argument a numeric vector and returns the descriptive statistics of the vector in a data frame. (`mean`, `sd`, `median`, `kurtosis`, `skewness`, `NAs`). 
Test your results using the `allmean_mv_EV` variable in the *COL PA MARA.csv* database.

2. Evenson`s cut points for PA are presented in the following table. The counts are presented using an epoch = 60 sec.

  <!-- html table generated in R 3.2.3 by xtable 1.8-2 package -->
  <!-- Sun Mar 06 18:12:52 2016 -->
  <table border=1>
  <tr> <th>  </th> <th> counts </th> <th> PA_Intensity </th>  </tr>
    <tr> <td align="right"> 1 </td> <td> &lt;=100 </td> <td> sedentary </td> </tr>
    <tr> <td align="right"> 2 </td> <td> &lt;=2292 </td> <td> light </td> </tr>
    <tr> <td align="right"> 3 </td> <td> &lt;=4008 </td> <td> moderate </td> </tr>
    <tr> <td align="right"> 4 </td> <td> &gt;4008 </td> <td> vigorous </td> </tr>
     </table>
  Create a function that receive as argument the count number in an epoch and returns the PA intensity level for that epoch.

---
  
## References

+ Adler, J. (2010). *R in a nutshell: A desktop quick reference*. O'Reilly Media, Inc.
+ Leek, J. (2014). *R programming (MOOC)*. Johns Hopkins University, Coursera.
