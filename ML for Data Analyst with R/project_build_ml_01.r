# Project - 01 build ML with R (logistic regression)

# load library
library(tidyverse)
library(caret)

# load data
churn <- read_csv("churn.csv")
str(churn)

# Spit data
train_test_spit <- function(data, size = 0.8) {
                  n <- nrow(data)
                  set.seed(42)
                  id <- sample(1:n,
                              size = size*n,
                              replace = FALSE)
                  train_df <- data[id, ]
                  test_df <- data[-id, ]
                  return(list(train_df, test_df))
}

prep_data <- train_test_spit(churn)

glimpse(prep_data)

train_data <- prep_data[[1]] %>%
  mutate(churn = as.factor(churn))

test_data <- prep_data[[2]] %>%
  mutate(churn = as.factor(churn))

# train model
model <- train(churn ~ totaldaycharge + totalevecharge + totalnightcharge + totalintlcharge + numbercustomerservicecalls,
               data = train_data,
               method = "glm")
model

# Score model
pred_data <- predict(model, newdata = test_data)
pred_data
glimpse(pred_data)

# Evauate model
Accuracy_pred <- mean(pred_data == test_data$churn)
Accuracy_pred
model

pred_data
test_data$churn

model
confusionMatrix(data = pred_data, reference = test_data$churn)

summary(pred_data)
summary(test_data$churn)
