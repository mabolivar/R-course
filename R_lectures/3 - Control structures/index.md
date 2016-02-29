---
title       : R programming
subtitle    : Lecture 3. Control structures
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


## Motivation

+ The statements in R are executed sequentially (normally).
+ But sometimes you might:
  - Execute some statemets repetitively (`for`, `while`)
  - Execute statements only if certain conditions are met (`if-else`)
  
**e.g.**
  + Read multiple files at once (.agd).
  + Identify valid participants given their MVPA minutes.

--- .segue .dark .nobackground

## Repetition and looping

--- .class #id 



## Repetition and looping

Looping constructs repetitively execute a statement or series of statements until a condition is not true.

 + `for`
 + `while`
 + `repeat`*

---

## For

The `for` loop executes a statement repetitively until a variable’s value is no longer contained in the sequence `seq`. The syntaxis is:


```r
> for(var in seq){
+   statement
+ }
```

where,
+ *var* is a variable name,
+ *seq* is a vector of any type, and
+ *statement* is the statement you want to execute repetitively.

---

## For - Example 1

Print the numbers from 1 to 10

```r
> nums <- 1:10
```


```r
>   for(i in nums){
+     print(i)
+   }
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 9
## [1] 10
```


---

## For - Example 2

The for loop can also iterate other data type vectors.


```r
>   weekdays <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
```


```r
>   for(day in weekdays){
+     print(day)
+   }
## [1] "Monday"
## [1] "Tuesday"
## [1] "Wednesday"
## [1] "Thursday"
## [1] "Friday"
```

---

## For - Example 3

`seq_along(x)` function returns a numeric vector of the form `1:length(x)`. It can be used as argument for the for loop.


```r
>   weekdays <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
```


```r
>   for(i in seq_along(weekdays)){
+     day <- weekdays[i]
+     print(day)
+   }
## [1] "Monday"
## [1] "Tuesday"
## [1] "Wednesday"
## [1] "Thursday"
## [1] "Friday"
```

---

## For - Exercises

1. Write a program which sums the integers from 1 to 10 using a `for` loop (and prints the total at the end).
2. Write a program which finds the factorial of a given number. E.g. 3 factorial, or $3!$ is equal to 3 x 2 x 1; 5! is equal to 5 x 4 x 3 x 2 x 1, etc.. Your program should only contain a single loop.



---

## While

A `while` loop executes a statement repetitively until the condition is no longer true. The sintaxys is: 


```r
> while(cond){
+   statement
+ }
```

--- .segue .dark .nobackground

## Conditional execution

---

## Conditional execution

In conditional execution, a statement or statements are executed only if a specified condition is met. 

These constructs include:
  + `if-else`
  + `ifelse`

---

## if-else

The `if-else` control structure executes a statement if a given condition is true.


```r
> # Option 1
> if(cond){
+   statement #do something
+ }
```


```r
> # Option 2
> if(cond){
+   statement1 # do something
+ } else{
+   statement2 # do somenthing else
+ }
```

---

## if-else


```r
> # Option 3
> if(cond1){
+   statement1 # do something
+ } else if(cond2){
+   statement2 # do somenthing different
+ } else{
+   statement3 # do something else
+ }
```


---

## ifelse

The `ifelse` construct is a compact and vectorized version of the `if-else` construct.
The syntax is:


```r
> ifelse(cond,statement1,statement2)
```

+ The first statement is executed if *cond* is `TRUE`. If *cond* is `FALSE`, the second statement is executed.

+ Use `ifelse` when you want to take a binary action or when you want to input and output
vectors from the construct.

---

## Exercises

1. 
2. 
3.






---

## Remarks

+ Looping in R can be inefficient and time consuming when you’re processing the rows or columns of large datasets.
+ Whenever possible, it’s better to use R’s built-in numerical and character functions in conjunction with the apply family of functions.

---

## References

+ Kabacoff, R. (2015). *R in action: data analysis and graphics with R*. Manning Publications Co.

--- .segue .dark .nobackground

## Birthday Problem
