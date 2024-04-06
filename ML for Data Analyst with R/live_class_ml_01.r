# Machine learning with R programming - 01
# 3 step to build ML
## 1. Prepare data
## 2. Train algorithm
## 3. Test/Evaluate model
## ML Glossary => split -> train -> test
## Build ML in R programming using library caret
# import library
library(tidyverse) # for prep data
library(caret) # for build ML

## preview data
head(mtcars)

## recap statistics
# train model base R
model_lm <- lm(mpg ~ hp + wt, data = mtcars)
model_glm <- glm(mpg ~ hp + wt, data = mtcars)

# caret -> build standard interface for model training
## use function train()
model2 <- train(mpg ~ hp + wt, 
      data = mtcars,
      method = "lm")  # method = "" -> use to select algorithm

model2$finalModel # == lm(mpg ~ hp + wt, data = mtcars)

# Build model with carat → train test split
## 1. Split data

#build function for reusability
train_test_split <- function(data, size = 0.8) {
  set.seed(42)
  n <- nrow(mtcars)
  train_id <- sample(1:n, size = size*n)
  train_data <- mtcars[train_id, ]
  test_data <-mtcars[-train_id, ]
  return(list(train_data, test_data))
}

prep_df <- train_test_split(mtcars, size = 0.8)

## 2. Train model

model <- train(mpg ~ hp + wt + am,
               data = prep_df[[1]],
               method = "lm")
model

## 3. Score model

pred_mpg <- predict(model, newdata = prep_df[[2]])

pred_mpg

## 4. Evaluate model

actual_mpg <- prep_df[[2]]$mpg
# error = actual - prediction
test_mae <- mean(abs(pred_mpg - actual_mpg))
test_rmse <- sqrt(mean((pred_mpg - actual_mpg)**2))

print(test_rmse)
print(test_mae)

# Change resampling technic => Use function → trainControl()
## 2. Train model

# change resampling technic
## boostarpred 
ctrl <- trainControl(method = "boot",
                     number = 5) # Boot with 5 reps

# build model
model <- train(mpg ~ hp + wt + am,
               data = prep_df[[1]],
               method = "lm",
               trControl = ctrl)
model
## Leave One Out CV
ctrl <- trainControl(method = "LOOCV")

model <- train(mpg ~ hp + wt + am,
               data = prep_df[[1]],
               method = "lm",
               trControl = ctrl)
## K-Flod CV
ctrl <- trainControl(method = "cv",
                     number = 5)

model <- train(mpg ~ hp + wt + am,
               data = prep_df[[1]],
               method = "lm",
               trControl = ctrl)
