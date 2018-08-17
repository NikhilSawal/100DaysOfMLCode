install.packages("ISLR")

library(MASS)
library(ISLR)

# We will use the Boston house price data which record medv (median house value) for 506 neighborhoods in Boston
df <- Boston
attach(df)

# returns the structure of our data frame
str(df)

colnames(df)
# medv is the response that we want to predict and it represents the median house prices in boston

# fit a model using the lm(response~predictor, data=data.name) function
lm.fit <- lm(medv ~ lstat, data = df)
lm.fit

# Will return the summary of the fit. Includes estimates, standard error, t statistic, p-value
summary(lm.fit)

# Estimates of the coefficients of regression
coef(lm.fit)

# Confidence interval for the coefficients
confint(lm.fit)

# predict() function can be use to produce confidence and prediction interval for response (medv) for a given value of predictor (lstat)
predict(lm.fit, data.frame(lstat=c(5,10,12)), interval = "confidence")
predict(lm.fit, data.frame(lstat=c(5,10,12)), interval = "prediction")
# So, in the above two lines of code we construct confidence and prediction interval for x=5, x=10 and x=12

plot(lstat, medv)
abline(lm.fit, lwd=3, col="red")

