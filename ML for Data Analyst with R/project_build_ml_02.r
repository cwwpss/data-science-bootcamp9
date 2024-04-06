# Project - 01 build ML with R
## increase variable
## compare knn and logistic regression
## tune with hyperparameter

# load library
library(tidyverse)
library(caret)
library(MLmetrics)

# prep data
churn <- read_csv("churn.csv")

glimpse(churn)

churn_prep <- churn %>%
  mutate(churn = as.factor(churn))

# 1. split data
train_test_split <- function(data, size = 0.8) {
  n <- nrow(data)
  set.seed(42)
  id <- sample(
    1:n,
    size = size*n,
    replace = FALSE)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train_data, test_data))
}

prep_data <- train_test_split(churn_prep)

# 2. train model

## define k for tune model
k_grid <- data.frame(k = c(3, 5, 7, 9))

ctrl <- trainControl(
  method = "cv",
  number = 5,
  summaryFunction = prSummary,
  classProbs = TRUE,
  verboseIter = TRUE
)

glm_model <- train(
  churn ~ .,
  data = prep_data[[1]],
  method = "glm",
  metric = "Recall",
  trControl = ctrl, 
  tuneLength = 10
  )

knn_model <- train(
  churn ~ .,
  data = prep_data[[1]],
  method = "knn",
  metric = "Recall",
  trControl = ctrl,
  tuneLength = 10
  )

glm_model
knn_model

# 3. Scoring model
glm_p <- predict(glm_model, newdata = prep_data[[2]])
Knn_p <- predict(knn_model, newdata = prep_data[[2]])

# 4. Evaluate model
confusionMatrix(
  glm_p,
  prep_data[[2]]$churn,
  positive = "Yes",
  mode = "prec_recall"
)

confusionMatrix(
  Knn_p,
  prep_data[[2]]$churn,
  positive = "Yes",
  mode = "prec_recall"
)
