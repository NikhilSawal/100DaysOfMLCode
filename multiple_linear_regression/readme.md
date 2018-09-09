Multiple Linear Regression
================
Nikhil Sawal
August 21, 2018

Loading libraries
-----------------

``` r
library(MASS)
library(ISLR)
library(caTools)
library(corrplot)
library(car)
library(dplyr)

df <- Boston
attach(df)
```

Test-train split - using `caTools` package
------------------------------------------

``` r
set.seed(102)
split <- sample.split(df$medv, SplitRatio = 0.7)
train <- subset(df, split == T)
test <- subset(df, split == F)
```

Model 0 \[With all predictors\]
-------------------------------

Our first model of choice should be to include all variables and see how the model performs. Following lines of code will help us fit a model and dislplay the summary using the `summary()` function. The summary include estimates for our model coefficients i.e. all the `beta-hat's`, the standard error and the p-value based on t-statistic. It also outputs, values of the training R^2 and (adjusted R^2). We haven't talked about adjusted R^2 yet, but it's another and more reliable measure for checking model accuracy. The reason it is more reliable is that, unlike R^2, (adjusted R^2) penalizes if noise variables are added to the model, whereas R^2 keeps increasing as we add more variables to our model.

``` r
lm.fit <- lm(medv~., data = train)
summary(lm.fit)
```

    ## 
    ## Call:
    ## lm(formula = medv ~ ., data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -16.0023  -2.5950  -0.4634   2.0627  27.2807 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  30.518071   5.877156   5.193 3.51e-07 ***
    ## crim         -0.021169   0.059891  -0.353 0.723960    
    ## zn            0.045997   0.015667   2.936 0.003543 ** 
    ## indus         0.032044   0.069609   0.460 0.645553    
    ## chas          1.910784   1.011363   1.889 0.059669 .  
    ## nox         -18.370764   4.491537  -4.090 5.35e-05 ***
    ## rm            4.473386   0.481915   9.283  < 2e-16 ***
    ## age           0.003602   0.015286   0.236 0.813839    
    ## dis          -1.482459   0.233574  -6.347 6.75e-10 ***
    ## rad           0.258453   0.078086   3.310 0.001030 ** 
    ## tax          -0.012798   0.004257  -3.007 0.002831 ** 
    ## ptratio      -0.863687   0.150515  -5.738 2.06e-08 ***
    ## black         0.011104   0.003118   3.562 0.000419 ***
    ## lstat        -0.522442   0.060765  -8.598 2.68e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.68 on 353 degrees of freedom
    ## Multiple R-squared:  0.7649, Adjusted R-squared:  0.7563 
    ## F-statistic: 88.36 on 13 and 353 DF,  p-value: < 2.2e-16

Looking at the p-values, it seems like variables `crim`, `indus` and `age` are not useful in predicting the response. So, we try to fit our second model excluding these variables.

Model 1 \[With only significant predictors\]
--------------------------------------------

``` r
lm.fit1 <- lm(medv~.-crim-indus-age, data = train)
summary(lm.fit1)
```

    ## 
    ## Call:
    ## lm(formula = medv ~ . - crim - indus - age, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -16.0325  -2.5719  -0.4566   2.0791  27.5287 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  29.868763   5.738718   5.205 3.29e-07 ***
    ## zn            0.044016   0.015287   2.879 0.004226 ** 
    ## chas          1.995515   0.998454   1.999 0.046411 *  
    ## nox         -17.397150   4.138890  -4.203 3.33e-05 ***
    ## rm            4.496211   0.464739   9.675  < 2e-16 ***
    ## dis          -1.503918   0.215886  -6.966 1.58e-11 ***
    ## rad           0.236889   0.069058   3.430 0.000674 ***
    ## tax          -0.011843   0.003815  -3.105 0.002058 ** 
    ## ptratio      -0.847276   0.147582  -5.741 2.02e-08 ***
    ## black         0.011309   0.003035   3.726 0.000226 ***
    ## lstat        -0.519031   0.056545  -9.179  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.663 on 356 degrees of freedom
    ## Multiple R-squared:  0.7647, Adjusted R-squared:  0.758 
    ## F-statistic: 115.7 on 10 and 356 DF,  p-value: < 2.2e-16

There are negligible differences between `R^2` and `(adjusted R^2)` of the two models. These are values for the training set and we really care about the performance of the model on the test set. In the following section, we develop a function that evaluated the model performance.

Model Evaluation Function, `model_eval`
---------------------------------------

This function is written for reusability. Notice that every time we fit a new model, we would need to repeat the following operations over and over again.

-   Make predictions & store them in a data frame with the observed values
-   Replace negatives by zeros, if any in the predictions
-   Compute MSE, R^2 and adjusted R^2.

Wrapping these operations in a function, will save us a lot of time, since all we need to do is call the function, `model_eval` and pass in 2 parameters, `(regression model, number of predictors used to fit the model)` and it will return the test MSE, R^2 and adjusted R^2 in the form of a list.

``` r
model_eval <- function(model, k){
  
  # Prediction
  predictions <- predict(model, test)
  results <- cbind(predictions, test$medv)
  colnames(results) <- c('Predictions', 'Observed')
  results <- as.data.frame(results)
  
  # Function to replace negatives with 0
  make_zero <- function(x){
    if(x<0){
      return(0)
    }else{
      return(x)
    }
  }
  
  results$Predictions <- sapply(results$Predictions, make_zero)
  
  # Mean squared error
  mse <- mean((results$Predictions - results$Observed)^2)

  # R^2
  SSRes <- sum((results$Predictions-results$Observed)^2)
  SST <- sum((results$Observed-mean(results$Observed))^2)
  
  r2 <- 1 - (SSRes/SST) 
  
  #adjusted R^2
  n <- nrow(test)
  
  adj.r2 <- 1 - ((SSRes/(n-k-1))/(SST/(n-1)))
  
  return(list(mse, r2, adj.r2))
  
}
```

Interaction terms
-----------------

The previous two models made a serious assumption, that the relationship between response `Y` and predictor `X` is additive, i.e. the effect of changes in a predictor variable `Xj` on the response `Y`, is independent of the values of other predictors. We relax this assumption by including the interaction terms.

**How do we choose the interaction terms?**

The best way to choose interaction terms is to use domain knowledge. For the sake of simplicity, we check the correlation between the predictor variables and select the variables that have a correlation &gt; 0.7 We use the `corrplot()` library in R to visualize the correlations. Once we identify a set of variables that are highly correlated, we include their interaction terms in our model and refit. The following lines of code and plot will help us visualize.

``` r
M <- cor(df)
corrplot(M, method = "circle")
```

![](readme_files/figure-markdown_github/unnamed-chunk-6-1.png)

From the above plot, we observe strong intractions like `indus*nox, indus*dis, indus*tax, nox*age, noc*dis, ade*dis, rad*tax`. We refit the model using the main effects and interaction and check the summary.

``` r
lm.fit2 <- lm(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + 
                ptratio + black + lstat + indus*nox + indus*dis + indus*tax + nox*age + 
                nox*dis + age*dis + rad*tax, data = train)


summary(lm.fit2)
```

    ## 
    ## Call:
    ## lm(formula = medv ~ crim + zn + indus + chas + nox + rm + age + 
    ##     dis + rad + tax + ptratio + black + lstat + indus * nox + 
    ##     indus * dis + indus * tax + nox * age + nox * dis + age * 
    ##     dis + rad * tax, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -16.5901  -2.6998  -0.3809   2.2084  24.8485 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 15.9655595 13.6400469   1.170 0.242609    
    ## crim        -0.1061540  0.0618653  -1.716 0.087077 .  
    ## zn           0.0076777  0.0189801   0.405 0.686084    
    ## indus        0.7539275  0.5894315   1.279 0.201728    
    ## chas         1.7759809  1.0017846   1.773 0.077139 .  
    ## nox         16.5138216 24.0030084   0.688 0.491920    
    ## rm           4.4388890  0.4739775   9.365  < 2e-16 ***
    ## age          0.0993043  0.1581844   0.628 0.530565    
    ## dis          1.6308762  1.6124034   1.011 0.312505    
    ## rad          0.5764274  0.3323409   1.734 0.083730 .  
    ## tax         -0.0286652  0.0070656  -4.057 6.15e-05 ***
    ## ptratio     -0.9191625  0.1559354  -5.895 8.93e-09 ***
    ## black        0.0110752  0.0030633   3.615 0.000344 ***
    ## lstat       -0.5079528  0.0596777  -8.512 5.29e-16 ***
    ## indus:nox   -1.0617205  0.8795668  -1.207 0.228220    
    ## indus:dis   -0.1522730  0.0546967  -2.784 0.005665 ** 
    ## indus:tax    0.0008444  0.0003457   2.443 0.015084 *  
    ## nox:age     -0.1837942  0.2539926  -0.724 0.469788    
    ## nox:dis     -4.1374845  3.7458113  -1.105 0.270117    
    ## age:dis     -0.0056054  0.0100663  -0.557 0.577995    
    ## rad:tax     -0.0003605  0.0004996  -0.722 0.471042    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.536 on 346 degrees of freedom
    ## Multiple R-squared:  0.7836, Adjusted R-squared:  0.7711 
    ## F-statistic: 62.63 on 20 and 346 DF,  p-value: < 2.2e-16

There is very little difference between the R^2 value of this model and the previous model. Looking at the summary output, we can see that our model has a lot of predictors that are insignificant in predicting the response. We will fit a new model without these predictors and see how it performs.

**Quick coding tip: ** Using `rad*tax` includes the interaction term `rad*tax` **as well as** the main effects `rad` & `tax` separately, but using `rad:tax`, includes **only** the interaction term, `rad:tax`, in the model. So,

-   `rad*tax` includes 3 predictors in the model \[`rad*tax`, `rad` & `tax`\]
-   `rad:tax` includes 1 predictor in the model \[`rad:tax`\]

We should be cautious, while removing any predictor variables from our model. For example:

-   The interaction term `tax*rad` is insignificant in model `lm.fit2`, but the main effects, `rad` & `tax` are significant, so we just want to remove the interaction term, but preserve the main effects.
-   Also, the interaction term, `indus*dis` is significant, but the main effect `indus` & `dis` are insignificant in model `lm.fit2`. But as per the **`hierarchial principle`**, which states that if the we include the interaction terms, we should include the main effects as well, even if the p-value associated with their coefficients is not significant. So, we should add the main effects `indus` & `dis` to our model as well.

Now, we are ready to fit our new model.

``` r
lm.fit3 <- lm(medv ~ rm + ptratio + tax + rad + black + lstat +
                indus*dis + indus*tax, data = train)

summary(lm.fit3)
```

    ## 
    ## Call:
    ## lm(formula = medv ~ rm + ptratio + tax + rad + black + lstat + 
    ##     indus * dis + indus * tax, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -16.2426  -2.7596  -0.6598   1.7523  26.3514 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 21.6435135  5.3924748   4.014 7.29e-05 ***
    ## rm           4.5035024  0.4731810   9.518  < 2e-16 ***
    ## ptratio     -0.7863996  0.1352979  -5.812 1.37e-08 ***
    ## tax         -0.0292965  0.0070414  -4.161 3.98e-05 ***
    ## rad          0.2469959  0.0741489   3.331 0.000956 ***
    ## black        0.0134772  0.0030827   4.372 1.62e-05 ***
    ## lstat       -0.5880768  0.0569585 -10.325  < 2e-16 ***
    ## indus       -0.0483758  0.1661314  -0.291 0.771076    
    ## dis         -0.2572674  0.2220880  -1.158 0.247476    
    ## indus:dis   -0.1004856  0.0299858  -3.351 0.000891 ***
    ## tax:indus    0.0007955  0.0003544   2.245 0.025399 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.736 on 356 degrees of freedom
    ## Multiple R-squared:  0.7572, Adjusted R-squared:  0.7504 
    ## F-statistic:   111 on 10 and 356 DF,  p-value: < 2.2e-16

Notice that all the terms included in our model are significant.

Let's see how each of the model performs on test set, using the `model_eval` function, that we developed in previous section. **Reminder: ** `model_eval` function takes two arguments, (regression model, number of predictors) and returns 3 values. (MSE, R^2, Adjusted R^2).

MSE ,R2 and Adjusted R^2
------------------------

### Model 0

``` r
model_eval(lm.fit, 13)
```

    ## [[1]]
    ## [1] 25.70435
    ## 
    ## [[2]]
    ## [1] 0.626477
    ## 
    ## [[3]]
    ## [1] 0.5876307

### Model 1

``` r
model_eval(lm.fit1, 10)
```

    ## [[1]]
    ## [1] 26.40253
    ## 
    ## [[2]]
    ## [1] 0.6163315
    ## 
    ## [[3]]
    ## [1] 0.5863574

### Model 2

``` r
model_eval(lm.fit2, 20)
```

    ## [[1]]
    ## [1] 23.25251
    ## 
    ## [[2]]
    ## [1] 0.662106
    ## 
    ## [[3]]
    ## [1] 0.6048358

### Model 3

``` r
model_eval(lm.fit3, 10)
```

    ## [[1]]
    ## [1] 27.93388
    ## 
    ## [[2]]
    ## [1] 0.5940786
    ## 
    ## [[3]]
    ## [1] 0.562366

Model 0 & Model 1 are very basic models, since they include only the main effects, which is evident from the values of their accuracy measure. Model 2 & Model 3, on the other hand, include the interaction terms and hence we will evaluate these models in great details.

-   Model 2 has 20 predictor variable and has (MSE, R^2, Adjusted R^2) values of (23.25251, 0.662106, 0.6048358)
-   Model 3 has 10 predictor variable and has (MSE, R^2, Adjusted R^2) values of (27.93388, 0.5940786, 0.562366)
-   Notice that, though Model 2 looks better than Model 3, in terms of values of `(MSE, R^2, Adjusted R^2)`, but for a reduction of 10 predictor variables from Model 2 -&gt; Model 3, there is very little improvement in the values of `(MSE, R^2, Adjusted R^2)`. Infact, the difference between the `Adjusted R^2` values of the two models is just (4%). So Model 3 is better than Model 2, in the sense that, it uses half the predictors as compared to Model 2 and has comparable level of accuracy.

We now move further and check the adequacy of our model.

Model adequacy checks
=====================

We specifically check the adequacy of Model's 2 and 3, since they comes more closer to a real world situation. To check the adequacy of the model, we will plot residuals vs. fitted values, to see if our assumptions about, **linear relationship** betweeen Y & X and **constant variance** of error terms, hold. We will also plot the normal probability plot to check the **normality assumption**.

Model 2
-------

``` r
par(mfrow=c(2,2))
plot(lm.fit2)
```

![](readme_files/figure-markdown_github/unnamed-chunk-13-1.png)

-   The plot in the top left panel is the plot of residuals vs. fitted values. It shows a non-linear relationship, implying that our assumption of the true model being linear is flawed. We can correct this by performing some transformations.

-   The figure in the top right corner suggests that our normality assumption is also violated, since the residuals don't fall along the straight line.

Model 3
-------

``` r
par(mfrow=c(2,2))
plot(lm.fit3)
```

![](readme_files/figure-markdown_github/unnamed-chunk-14-1.png)

The violations look similar. Here we will have to perform some kind of transformations to correct these violations. Notice that all the plots above highlight few observaions as outliers. In the following section, we will go through a technique to deal with outliers.

Outlier treatment
=================

As defined in our infographic of [Day 14](https://github.com/NikhilSawal/100DaysOfMLCode/blob/master/Images/Day_14.png), outliers are observations which are considerably different from the rest of the observations and tend to pull the regression line towards themselves. The **Residuals vs. Fitted values plots & the Normal probability plots** are particularly helpful in identifying outliers. From the plots in the previous section, we see that the observations `365, 369, 373 & 413` appear distinctly different from the rest of the data. So, we will fit our model 2 and model 3, based on a training set that excludes these values. We accomplish this by using the following code. We use a package `dplyr` to use the `%in%` operator and `filter` function.

``` r
train$id <- as.numeric(rownames(train))
outliers <- c(365,369,373,413)
train1 <- filter(train, !(id %in% outliers)) 
```

From the above lines of code, we have a dataset, `train1` that does not include the unusual observations. Now we will fit model 2 and 3 with this new data set, and see if we get different values. We do this analysis, because clearly discarding the outliers can get trickier, since outliers can be unusual but perfectly plausible values. \[\] Deleting these values to improve the fit of the equation can be dangerous as it can give the user a false sense of precision.

Now we fit model 2 & 3 without outliers and call them `lm.fit21` and `lm.fit31` respectively. Later we compare model 2 vs. model 21 & model 3 vs. model 31 and compare the values the coefficient estimates (i.e the betas), MSE, R^2, Adj. R^2 and see if there is a difference.

Model 2 w/o Outliers
--------------------

``` r
lm.fit21 <- lm(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + 
                ptratio + black + lstat + indus*nox + indus*dis + indus*tax + nox*age + 
                nox*dis + age*dis + rad*tax, data = train1)

summary(lm.fit21)
```

    ## 
    ## Call:
    ## lm(formula = medv ~ crim + zn + indus + chas + nox + rm + age + 
    ##     dis + rad + tax + ptratio + black + lstat + indus * nox + 
    ##     indus * dis + indus * tax + nox * age + nox * dis + age * 
    ##     dis + rad * tax, data = train1)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -11.6348  -2.3691  -0.3507   1.7609  18.9269 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  0.7630558 11.9946880   0.064  0.94931    
    ## crim        -0.0471877  0.0537281  -0.878  0.38041    
    ## zn           0.0135196  0.0163817   0.825  0.40978    
    ## indus        0.2222432  0.5117246   0.434  0.66434    
    ## chas         1.5084783  0.8968749   1.682  0.09350 .  
    ## nox         22.5515083 20.9019624   1.079  0.28138    
    ## rm           5.8542940  0.4316915  13.561  < 2e-16 ***
    ## age          0.1659729  0.1363609   1.217  0.22438    
    ## dis          0.9939310  1.4099529   0.705  0.48133    
    ## rad          0.4758268  0.2865858   1.660  0.09776 .  
    ## tax         -0.0256131  0.0060953  -4.202 3.38e-05 ***
    ## ptratio     -0.8614445  0.1355027  -6.357 6.56e-10 ***
    ## black        0.0134506  0.0026755   5.027 8.04e-07 ***
    ## lstat       -0.3882566  0.0539203  -7.201 3.84e-12 ***
    ## indus:nox   -0.3025652  0.7629932  -0.397  0.69195    
    ## indus:dis   -0.0945479  0.0474525  -1.992  0.04711 *  
    ## indus:tax    0.0007762  0.0002979   2.606  0.00957 ** 
    ## nox:age     -0.3383505  0.2192836  -1.543  0.12376    
    ## nox:dis     -2.9128712  3.2773437  -0.889  0.37474    
    ## age:dis     -0.0058680  0.0087053  -0.674  0.50072    
    ## rad:tax     -0.0003711  0.0004308  -0.861  0.38966    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 3.905 on 342 degrees of freedom
    ## Multiple R-squared:  0.8339, Adjusted R-squared:  0.8242 
    ## F-statistic: 85.84 on 20 and 342 DF,  p-value: < 2.2e-16

``` r
model_eval(lm.fit21, 20)
```

    ## [[1]]
    ## [1] 25.89488
    ## 
    ## [[2]]
    ## [1] 0.6237084
    ## 
    ## [[3]]
    ## [1] 0.5599302

Model 3 w/o Outliers
--------------------

``` r
lm.fit31 <- lm(medv ~ rm + ptratio + tax + rad + black + lstat +
                indus*dis + indus*tax, data = train1)

summary(lm.fit31)
```

    ## 
    ## Call:
    ## lm(formula = medv ~ rm + ptratio + tax + rad + black + lstat + 
    ##     indus * dis + indus * tax, data = train1)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -12.1407  -2.3943  -0.4701   1.8378  20.8898 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 10.2892042  4.7538606   2.164  0.03111 *  
    ## rm           5.8180103  0.4245663  13.703  < 2e-16 ***
    ## ptratio     -0.7672372  0.1161206  -6.607 1.45e-10 ***
    ## tax         -0.0266066  0.0060322  -4.411 1.37e-05 ***
    ## rad          0.1750978  0.0639482   2.738  0.00649 ** 
    ## black        0.0145986  0.0026739   5.460 9.02e-08 ***
    ## lstat       -0.4698829  0.0511155  -9.193  < 2e-16 ***
    ## indus       -0.1069248  0.1429759  -0.748  0.45505    
    ## dis         -0.2759046  0.1901620  -1.451  0.14770    
    ## indus:dis   -0.0637656  0.0259823  -2.454  0.01460 *  
    ## tax:indus    0.0007552  0.0003035   2.488  0.01329 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.053 on 352 degrees of freedom
    ## Multiple R-squared:  0.8158, Adjusted R-squared:  0.8106 
    ## F-statistic: 155.9 on 10 and 352 DF,  p-value: < 2.2e-16

``` r
model_eval(lm.fit31, 10)
```

    ## [[1]]
    ## [1] 29.29638
    ## 
    ## [[2]]
    ## [1] 0.5742794
    ## 
    ## [[3]]
    ## [1] 0.54102

Comparing model 21 & 31 with model 2 & 3 resp. we see that there in not much of a change between the coefficient estimates of the models and our measures of model evaluation i.e MSE, R^2 & Adj. R^2 have infact deteriorated when we fit models 21 & 31 using the test set. **If it's too much of a hassle to go back & forth for the result, scroll down to the bottom of the page, where I have summarized all models & their outcomes, we developed till now, in the form of a summary table.** So, we can infer that the observations are not outliers but are a bit unusual and that they donot control the slope of the regression line and hence we donot exclude them during further analysis.

Multicollinearity
=================

As we saw on day 14, we can use VIF to check if multicollinearity exists. Multicollinearity refers to a near-linear dependency between predictor variables and response. If there is multicollinearity in our model, **then there would be a large amount of variance in our predictor varibles and hence our predictions would change drastically for different data sets**. So, it's really important to check for multicollinearity. As noted in the infographic, multicollinearity exists if VIF &gt; 5 or 10. We use the `vif()` function from the `car` library on our model.

Model 2
-------

``` r
vif(lm.fit2)
```

    ##       crim         zn      indus       chas        nox         rm 
    ##   2.764744   3.764731 295.808300   1.136461 135.941520   2.134626 
    ##        age        dis        rad        tax    ptratio      black 
    ## 352.849015 206.165607 144.416078  24.682321   2.184804   1.480060 
    ##      lstat  indus:nox  indus:dis  indus:tax    nox:age    nox:dis 
    ##   3.216296 349.229187  11.457278  48.235136 538.817218 140.063461 
    ##    age:dis    rad:tax 
    ##  16.257305 177.066411

Model 3
-------

``` r
vif(lm.fit3)
```

    ##        rm   ptratio       tax       rad     black     lstat     indus 
    ##  1.951492  1.508729 22.485521  6.594221  1.374937  2.687538 21.555252 
    ##       dis indus:dis tax:indus 
    ##  3.587770  3.158612 46.495586

From the above outputs, we can see that we have a lot of predictors with values &gt;&gt; 5 & 10 in Model 2, but Model 3 shows great improvements. Though there are a few terms in model 3, that are high in terms of multicollinearity, but its still better than Model 2. Later we will be using a technique called **Ridge regression** to deal with this problem.

Summary of Models
=================

<table style="width:100%;">
<colgroup>
<col width="16%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th>Model</th>
<th>RSE</th>
<th>R^2</th>
<th>Adj. R^2</th>
<th>#Predictors</th>
<th>Model Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>0</td>
<td>25.70</td>
<td>62.64%</td>
<td>58.76%</td>
<td>13</td>
<td>Includes all predictors</td>
</tr>
<tr class="even">
<td>1</td>
<td>26.40</td>
<td>61.63%</td>
<td>58.63%</td>
<td>10</td>
<td>Includes significant predictors from model 0</td>
</tr>
<tr class="odd">
<td>2</td>
<td>23.25</td>
<td>66.21%</td>
<td>60.48%</td>
<td>20</td>
<td>Includes main effects and significant interaction terms from the correlation plot</td>
</tr>
<tr class="even">
<td>3</td>
<td>27.93</td>
<td>59.40%</td>
<td>56.23%</td>
<td>10</td>
<td>Includes significant predictors from model 2</td>
</tr>
<tr class="odd">
<td>21</td>
<td>25.89</td>
<td>62.37%</td>
<td>55.99%</td>
<td>20</td>
<td>Model 2 w/o outliers</td>
</tr>
<tr class="even">
<td>31</td>
<td>29.29</td>
<td>57.42%</td>
<td>54.10%</td>
<td>10</td>
<td>Model 3 w/o outliers</td>
</tr>
</tbody>
</table>
