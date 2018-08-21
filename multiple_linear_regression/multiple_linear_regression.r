library(MASS)
library(ISLR)
library(caTools)

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


model_evaluation <- function(model){
  
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
  return(list(mse, r2))
  
}

model_evaluation(lm.fit)
model_evaluation(lm.fit1)
