# Machine learning with R programming - 03

## Review syntax
## Regression
set.seed(42)
ctrl <- trainControl(method = “cv”, 
	number = 5)
model <- train(
	y ~ .,
	data = df,
	method = “knn”,
	metric = “RMSE”,
	trControl = ctrl
)
## Classification
### Classification - ROC Sens Specs
set.seed(42)
	ctrl <- trainControl(
	method = “cv”, 
	number = 5,
	summaryFunction = twoClassSummary,
	classProbs = TRUE)
model <- train(
	y ~ .,
	data = df,
	method = “knn”,
	metric = “ROC”,
	trControl = ctrl
)
### Classification - AUC Precision Recall F1 
set.seed(42)
ctrl <- trainControl(
	method = “cv”, 
	number = 5,
	summaryFunction = prSummary,
	classProbs = TRUE)
model <- train(
	y ~ .,
	data = df,
	method = “knn”,
	metric = “AUC”,
	trControl = ctrl
)

## Decision Tree with K-Fold template
## train tree
set.seed(99)
ctrl <- trainControl(method = "....", number = ...., 
 verboseIter = TRUE)
tree_model <- train(diabetes ~ ., 
 data = ...., 
 method = "rpart",
 trControl = ....)
## test model 
p <- predict(tree_model, newdata = ....)
accuracy <- mean(....)

## train model rpart
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE,
  classProbs = TRUE, # we can change threshold 0.5 -> classProbs = TRUE ให้มัน predicted ออกมาเป็น prob
  summaryFunction = twoClassSummary # predicted แบบ 2 class
)

tree_model <- train(
  diabetes ~ glucose + pressure + insulin + mass + age,
  data = df,
  method = "rpart",
  metric = "ROC", # เวลาใช้ classProbs -> metric ใช้ ROC -> area under the curve
  trControl = ctrl
)

## prediction
predict(tree_model, df, type = "prob")[1:10, ]

## change threshold
probs <- predict(tree_model, df, type = "prob")

p_class <- ifelse(probs$pos >= 0.5, "pos", "neg") # change threshole

table(df$diabetes, p_class) # confusion matrix

## Random forest code template
## train random forests
set.seed(99)
myGrid <- expand.grid(mtry = 2:4)
ctrl <- trainControl(method = "....", number = ...., 
 verboseIter = TRUE)
rf_model <- train(diabetes ~ ., 
 data = ...., 
 method = "rf",
 tuneGrid = myGrid,
 trControl = ....)
## test model 
p <- predict(rf_model, newdata = ....)
accuracy <- mean(....)

## Random forest vs RPART code example
## RPART
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE
)

tree_model <- train(
  diabetes ~ .,
  data = df,
  method = "rpart",
  metric = "Accuracy",
  trControl = ctrl
)
## Random Forest
rf_model <- train(
  diabetes ~ .,
  data = df,
  method = "rf", 
  metric = "Accuracy",
  tuneGrid = data.frame(mtry = c(2,3,4)),
  trControl = ctrl
)

# Regularized Regression
## Ridge vs. Lasso Regression
## Regularization 
## Ridge => beta will be lower, but not zero
## Lasso => beta can be zero (feature selection)
glmnet_model <- train(
  diabetes ~ .,
  data = df,
  method = "glmnet", 
  metric = "Accuracy",
  tuneGrid = expand.grid(
    alpha = 0:1,
    lambda = c(0.004, 0.04, 0.08)
  ),
  trControl = ctrl
)
