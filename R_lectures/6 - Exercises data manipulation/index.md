---
title       : R programming
subtitle    : Exercises. Data manipulation
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


## Guide

This slide deck presents a set of exercises to practice the concepts seen in the manipulate lecture.

To solve this exercises you will need the following files:
  1. Database: [muevete_baseline.xls](https://github.com/mabolivar/R-course/blob/master/data/muevete_baseline.xls)
  2. Codebook: [Codebook_Muevete_T0.xlsx](https://github.com/mabolivar/R-course/blob/master/data/Codebook_Muevete_T0.xlsx)
  3. [Data manipulation cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

Additionally, you will requiere to install the packages `dplyr` and `readr` and use the `read_excel()` function to import the data to R.

--- .class #id 

## Exercises I

For all the exercises print your results in the appropriate manner, i.e., title, relevant observations. All exercises should be solved using a continous pipeline (`%>%`).

1. What is the socio-economic level with the lowest participant weight average? How many participants are in each socio-economic level? 



2. What is the proportion of participants who assits at least two times per month to the ciclovia?

3. What is the mean of the difference in the weight of the participants between the first and second measurement?
What is the mean of the difference in the body fat of the participants between the first and second measurement? Does it make sense? 

---

## Exercises II

4. You as, a research, have decided to build a regression model to understand the variables related with the weight of the participant in the study. Previous studies have suggested that age, gender and the parent study level are significant variables to explain the weight in a child. Are all of this variables are statically signicant to explain the weight of a child? Use the `lm()` function.

---

## Exercises III

5. You want to know if the childs born in the first half of the years then to be more active than the childs born in the second half. You are doing some exploratory analysis and want to know if the mean of mvpa in midweek is higher in the first group. Conclude.
  + To solve this question download the data of [PA](https://github.com/mabolivar/R-course/blob/master/data/COL%20PA%20MARA.csv) - [codebook](https://github.com/mabolivar/R-course/blob/master/data/codebook_MARA.txt).
  + Use the appropiate two table verb to combine both tables.
  + Use the `mdy()` function from the `lubridate` package to transform characters into dates. Hint: `?lubridate`
  + Present your results.






