---
title       : DiamondEstim  
subtitle    : Developing Data Products - course project
author      : Yoni DAHAN
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
 

## DiamondEstim   
Allows you to estimate the value of your diamond.
Given your stone's characteristics :   
- weight (carat)
- clarity (I1, SI2, SI1, VS2, VS1, VVS2, VVS1, IF)   
- color (D, E, F, G, H)
- cut (fair, good, very good, premium, ideal),

DiamondEstim produces an estimated value in USD.

---

## Algorithm   
DiamondEstim uses the *diamonds* data that comes with the R package "ggplot2".   

This data contains the prices and other characteristics of no less than 54,000 round cut diamonds.   

A regression model is built with :   
- price as response   
- weight, color, clarity and cut as predictors

It has a root mean squared error of about USD14.

---
## Model Selection   


```r
library(caret);library(ggplot2);data(diamonds)   
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
intrain<-createDataPartition(y=diamonds$price,p=0.7,list=F)
training<-diamonds[intrain,];testing<-diamonds[-intrain,]   
   
##Preprocessing
preproc<-preProcess(x=training[,-c(2,3,4,7)],
                    method=c("BoxCox","center","scale")) 
training1<-predict(preproc,training[,-c(2,3,4,7)])
testing1<-predict(preproc,testing[,-c(2,3,4,7)])

training1<-cbind(training1,training[,c(2,3,4,7)])
testing1<-cbind(testing1,testing[,c(2,3,4,7)])
```

--- 
## Model Selection - Continued   

```r
##Models
lm_all<-lm(data=training1,price~.)
lm_simple<-lm(data=training1,price~carat+color+clarity)
lm_yo<-lm(data=training1,price~color+carat+clarity+cut)
lasso<-train(data=training1,price~.,method="lasso")
lm_step<-step(lm_all)
```

```
## Start:  AIC=550812.7
## price ~ carat + depth + table + x + y + z + cut + color + clarity
## 
##           Df  Sum of Sq        RSS    AIC
## <none>                  8.1616e+10 550813
## - z        1 5.0133e+07 8.1666e+10 550834
## - table    1 1.3030e+08 8.1747e+10 550871
## - y        1 2.2004e+08 8.1836e+10 550912
## - cut      4 9.4691e+08 8.2563e+10 551240
## - depth    1 3.3469e+09 8.4963e+10 552328
## - color    6 8.2755e+09 8.9892e+10 554447
## - carat    1 1.4884e+10 9.6500e+10 557136
## - x        1 2.2466e+10 1.0408e+11 559992
## - clarity  7 2.3964e+10 1.0558e+11 560520
```

```r
##Predict on testing set
testing_step<-predict(lm_step,testing1)
testing_yo<-predict(lm_yo,testing1)
testing_simple<-predict(lm_simple,testing1)
testing_lasso<-predict(lasso,testing1)
```

--- 
## Model Selection - Root Mean Squared Errors

```r
##Get the Root Mean Squared Errors on testing set
rmse_step<-trunc((sqrt(sum((testing1$price-testing_step)^2)))/
        (length(testing1$price)))
rmse_yo<-trunc((sqrt(sum((testing1$price-testing_yo)^2)))/
        (length(testing1$price)))
rmse_simple<-trunc((sqrt(sum((testing1$price-testing_simple)^2)))/
        (length(testing1$price)))
rmse_lasso<-trunc((sqrt(sum((testing1$price-testing_lasso)^2)))/
        (length(testing1$price)))

rmse<-data.frame(rmse_step,rmse_yo,rmse_simple,rmse_lasso)

rmse
```

```
##   rmse_step rmse_yo rmse_simple rmse_lasso
## 1        11      14          14         12
```

---

## Front-end
In the left side of the page, DiamondEstim asks you to provide the following :   

- weight (from 0.5 to 5ct) ; using a field to enter numbers   
   
   and:

- color, clarity, cut ; using boxes with choices to select from   


In the right side is showed :   

- a summary of the stone's characteristics   
- an estimated value in USD    

---

![alt text](C:/Users/Sarah/Desktop/Data Science/Data Science Specialization/Developing Data Products/courseproject/diamondestim.png "Diamond Estim")

--- 

## Information  
DiamondEstim is available here : [https://yonidahan.shinyapps.io/courseproject_app/]( https://yonidahan.shinyapps.io/courseproject_app/)   

For any information or documentation :   

- dahan.yoni1@gmail.com   

- [ https://yonidahan.shinyapps.io/courseproject_doc/]( https://yonidahan.shinyapps.io/courseproject_doc/)








