install.packages("ISLR")

library(MASS)
library(ISLR)
library(caTools)          #to do a test train split

# We will use the Boston house price data which records medv (median house value) for 506 neighborhoods in Boston
df <- Boston
attach(df)

# Test-Train split
# set.seed() is used to recreate the same test-train split every time
set.seed(101)
sample <- sample.split(df$medv, SplitRatio = 0.7)
train <- subset(df, sample==T)
test <- subset(df, sample==F)

# returns the descriptions about each column of our data frame
str(df)

colnames(df)
# medv is the response that we want to predict and it represents the median house prices in boston

# fit a model using the lm(response ~ predictor, data=data.name) function
# We will include only one feature (lstat) since we are considering a simple linear regression
lm.fit <- lm(medv ~ lstat, data = train)


# summary() returns the estimates for regression coefficients, standard error, 
# t-statistic, p-value, R^2 value.
summary(lm.fit)

# We can also get a list of outputs by using names() function on lm.fit
names(lm.fit)

# Estimates of the coefficients of regression
coef(lm.fit)

# Confidence interval for the coefficients
confint(lm.fit)

# the b1 term or the slope of the regression is non-zero. So, there is a relationship (negative relationship) between response and predictor variable.

# predict() function can be use to produce confidence and prediction interval for response (medv) for a given value of predictor (lstat)
prediction <- predict(lm.fit, test)
results <- cbind(prediction, test$medv)
colnames(results) <- c('predicted', 'actual')
results <- as.data.frame(results)

# check the minimum to see if there are any negative values
min(results$predicted)

# take care of negative values
make_zero <- function(x){
  if(x<0){
    return(0)
  }else{
    return(x)
  }
}

# apply the function
results$predicted <- sapply(results$predicted, make_zero)
min(results$predicted)

# Mean squared error
mse <- mean((results$predicted-results$actual)^2)
mse

# R^2
SSRes <- sum((results$predicted-results$actual)^2)
SST <- sum((test$medv-mean(df$medv))^2)

R2 <- 1-(SSRes/SST)
R2

# predict() function can be use to produce confidence and prediction interval for response (medv) for a given value of predictor (lstat)
predict(lm.fit, test, interval = "confidence")
predict(lm.fit, test, interval = "prediction")
# So, in the above two lines of code we construct confidence and prediction interval for x=5, x=10 and x=12

par(mfrow=c(1,2))
plot(test$lstat, test$medv)
abline(lm.fit, lwd=3, col="red")

plot(train$lstat, train$medv)
abline(lm.fit, lwd=3, col="red")


