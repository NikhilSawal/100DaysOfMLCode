library(MASS)
library(ISLR)
library(caTools)
library(corrplot)
library(car)

df <- Boston
attach(df)

set.seed(102)
split <- sample.split(df$medv, SplitRatio = 0.7)
train <- subset(df, split == T)
test <- subset(df, split == F)

lm.fit <- lm(medv~., data = train)
summary(lm.fit)

# removing the variables crim, indus and age and then fittiing the model
lm.fit1 <- lm(medv~.-crim-indus-age, data = train)
summary(lm.fit1)


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

# Interaction terms
M <- cor(df)
corrplot(M, method = "circle")

lm.fit2 <- lm(medv ~ crim + zn + chas + rm + ptratio + black + lstat +
                indus*nox + indus*dis + indus*tax + nox*age + nox*dis + 
                age*dis + rad*tax)

summary(lm.fit2)

# model lm.fit2 has a lot of insignificant terms
# We will refit the model, using only significant terms
lm.fit3 <- lm(medv ~ crim + chas + rm + ptratio + black + lstat + rad + tax +
                indus:dis + indus:tax)

summary(lm.fit3)

# Model 0
model_eval(lm.fit, 13)

# Model 1
model_eval(lm.fit1, 10)

# Model 2
model_eval(lm.fit2, 20)

# Model 3
model_eval(lm.fit3, 10)

# Model adequacy checks
plot(lm.fit2)

# Variance inflation factor
vif(lm.fit2)
vif(lm.fit3)
