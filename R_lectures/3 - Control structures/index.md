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
2. Write a program which finds the factorial of a given number. E.g. 3 factorial, or 3! is equal to 3 x 2 x 1; 5! is equal to 5 x 4 x 3 x 2 x 1, etc.. Your program should only contain a single loop.

---

## While

A `while` loop executes a statement repetitively until the condition is no longer true. The sintaxys is: 


```r
> while(cond){
+   statement
+ }
```

where,
  + *cond* is the condition that should be TRUE for keep iterating in the loop.

---

## While
<center><img src = "http://python-textbok.readthedocs.org/en/latest/_images/blockdiag-f3a27d8f6b0baede43d98ee8746bc4ed43aa58c8.png" style="width: 500px;"></center>

**Source**: http://python-textbok.readthedocs.org/en/latest/Loop_Control_Statements.html

---

## While - Example 1

Add the numbers from 1 to 10 together.


```r
> sum <- 0
> i <- 1
> while(i<=10){
+   sum <- i + sum
+   i <- i + 1
+ }
```



```r
> sum
## [1] 55
```

---

## While - Exercises

1. Write a program which uses a while loop to sum the squares of integers (starting from 1) until the total exceeds 200. Print the final total and the last number to be squared and added.

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

## if-else

The conditions can be a compound conditions, e.g.
  + `if(cond1 & cond2) {statement}`: `&` is an *and* operator. 
  + `if(cond1 | cond2) {statement}`: `|` is an *or* operator. 

---

## if-else - Example 1

A participant with more than 600 minutes of moderate-to-vigorous physical activity (MVPA) in average is considered valid.


```r
> minutes <- 750
> if(minutes > 600){
+   print("Valid participant")
+ }
## [1] "Valid participant"
```

---

## if-else - Example 2

A participant with more than 600 minutes of moderate-to-vigorous physical activity (MVPA) in average is considered valid. **Otherwise, they are invalid participants.**


```r
> minutes <- 450
> if(minutes > 600){
+   print("Valid participant")
+ } else{
+   print("Invalid participant")
+ }
## [1] "Invalid participant"
```

---

## if-else - Example 3

A participant with more than 600 minutes of moderate-to-vigorous physical activity (MVPA) in average **and more than 4 valid days of wear time** is considered valid. Otherwise, they are invalid participants.


```r
> minutes <- 750
> valdays <- 3
> if(minutes > 600 & valdays > 4){
+   print("Valid participant")
+ } else{
+   print("Invalid participant")
+ }
## [1] "Invalid participant"
```


---

## if-else - Exercises

1. Run the following code chunk.
  
  ```r
  > set.seed(123) #Set the seed for the random number generation
  > x <- rnorm(n = 1000, mean = 1, sd = 3)
  ```
  + How many numbers in `x` are less or equal than 0. Use a `for` or `while` loop.
  + How many numbers in `x` are more than 0 and less or equal than 1. Use a `for` or `while` loop.



---

## ifelse

The `ifelse` construct is a compact and vectorized version of the `if-else` construct.
The syntax is:


```r
> ifelse(cond,statement1,statement2)
```

+ The first statement is executed if *cond* is `TRUE`. If *cond* is `FALSE`, the second statement is executed.

+ Use `ifelse` when you want to take a binary action or when you want to input and output vectors from the construct.

---

## Exercises

1. Read the database *COL PA MARA.csv*
  
  ```r
  > acdata <- read.csv("COL PA MARA.csv")
  ```
  A valid participant is the one who wear the accelerometer for more than 4 valid days and at least one valid weekend day. However, if a person wear the accelerometry for more than 2000 minutes in midweek, he is also considered a valid participant.
  + Create a new logical variable named `valid` which indicates if a particiant is valid or not. Bind your new variable to `df` data frame. (Use loops and conditional statements)
  + How many participants are valid?
  
2. Using the `ifelse()` function, create a new logical variable named `valid` which indicates if a particiant is valid or not.
  + Compare the code used in numerals 1 and 2, which one of them is more efficient?







---

## Remarks

+ Looping in R can be inefficient and time consuming when you’re processing the rows or columns of large datasets.
+ Whenever possible, it’s better to use R’s built-in numerical and character functions in conjunction with the apply family of functions.

---

## References

+ Kabacoff, R. (2015). *R in action: data analysis and graphics with R*. Manning Publications Co.

--- .segue .dark .nobackground

## Birthday Problem
