# Machine learning with R programming - 02
## K-nearest Neighbors algorithm -> Predicted → class of X

## Build ML with tune hyperparameter
# load library 
install.packages("mlbench")
library(mlbench) # machine learning bench -> dataset for build project ML
library(tidyverse)
library(caret)

## load data set for regression
data("BostonHousing")
glimpse(BostonHousing)

## load data set for classification
data("PimaIndiansDiabetes")
glimpse(PimaIndiansDiabetes)

## prep data
clean_df <- mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate(hp = replace_na(hp, 146.68),
         wt = replace_na(wt, 3.21)) %>% ## Clean data(NULL) -> by avg
  drop_na()

## train
## linear regression
lm_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "lm"
)

## knn: k-nearest neighbors
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn"
)

## change summary metric
## use MAE 
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "MAE"
)
## use Rsquared
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "Rsquared"
)

## knn: k-nearest neighbors
## set.seed() to contain random sampling in knn
set.seed(42)
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "Rsquared"
)

## rpart (classification and regression tree)
set.seed(42)
rpart_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "rpart",
  metric = "RMSE"
)

# Try to increase variable to compare lm vs knn
## increase variables (use all variable in mtcars)
clean_df02 <- mtcars %>%
  mutate(hp = replace_na(hp, 146.68),
         wt = replace_na(wt, 3.21)) %>%
  drop_na()

## lm
lm_model <- train(
  mpg ~ .,
  data = clean_df02,
  method = "lm"
)  # lm model → ใส่ตัวแปรเพิ่มขึ้นมีตัวแปรที่ไม่เกี่ยวข้องทำให้ model เราแย่ลง 

## knn
set.seed(42)
knn_model <- train(
  mpg ~ .,
  data = clean_df02,
  method = "knn",
  metric = "RMSE"
) # knn model → ยิ่งมันเห็นตัวแปรมากขึ้นมันยิ่งเก่งขึ้น

# Change K (hyperparameter)
## knn: k-nearest neighbors
## Experimentation
## Chagne K
# set.seed
set.seed(42)

# create train control
ctrl <- trainControl(
  method = "cv",# change method to k-flow cv
  number = 5, ## <= k
  verboseIter = TRUE ## progress bar
)

# build model
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl
)

set.seed(42)

## change k
# create train control
ctrl <- trainControl(
  method = "cv",
  number = 3, ## <= change k
  verboseIter = TRUE ## progress bar
)

# build model
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl
)

## Set K (hyperparameter)
# grid search (dataframe) => set grid search (data frame) for select k
k_grid <- data.frame(k = c(3,5,7))
# tunegrid combine with grid search
# build model
knn_model <- train(
  mpg ~ .,
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneGrid = k_grid ## <- tuneGrid parameter
)
## Random K => use tuneLength parameter
knn_model <- train(
  mpg ~ .,
  data = clean_df02,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneLength = 4
)

## Repeatedcv
## clean data
clean_df02 <- mtcars %>%
  mutate(hp = replace_na(hp, 146.68),
         wt = replace_na(wt, 3.21)) %>%
  drop_na()

## define grid
k_grid <- data.frame(k = c(3,5,7))

## define control
ctrl <- trainControl(
  method = "repeatedcv",
  number = 3, ## <= k
  repeats = 5,
  verboseIter = TRUE ## progress bar
)

## build model
knn_model <- train(
  mpg ~ .,
  data = clean_df02,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneGrid = k_grid
)

## save model => for export to user or other
## .RDS extension 
saveRDS(knn_model, "knnModel.RDS")
## Read RDS
friend_laptop <- readRDS("knnModel.RDS")

# Normalization
## Normalization
## 1. min-max (feature scaling 0-1)
## 2. Standardization -3, +3 (center and scale)

# min-max
x <- c(5, 10, 12, 15, 20)
minmaxNorm <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

# center and scale (standardization)
zNorm <- function(x) {
  (x - mean(x)) / sd(x)
}
# Standardization use => preProcess()
train_df <- mtcars[1:20, ]
test_df <- mtcars[21:32, ]
## compute x_bar, x_sd
# center == mean, scale == sd
transformer <- preProcess(train_df,
                          method = c("center", "scale"))

train_df_z <- predict(transformer, train_df)
test_df_z <- predict(transformer, test_df)
## min max scaling with preprocess()
transformer <- preProcess(train_df,
                          method = c("range"))

train_df_z <- predict(transformer, train_df)
test_df_z <- predict(transformer, test_df)


# change metric summary (performance)

## build ML to classify diabetes patients
## binary classification
## change metric summary (performance)

## load library
library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)

## load dataset
data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes

## explore dataset
## check missing value -> compelet.cases()
glimpse(df)
mean(complete.cases(df))

## select variables
df_starter <- df %>%
  select(2,5,6,8,diabetes)

## check correlation -> binary variable by use mean of relate variable
df_starter %>%
  group_by(diabetes) %>%
  summarize(mean(age), mean(mass))

## 1. split data
set.seed(42)
n <- nrow(df_starter)
id <- sample(1:n, size = 0.8*n)
train_df <- df_starter[id, ]
test_df <- df_starter[-id, ]- 

## 2. Train data
set.seed(42) 

ctrl <- trainControl(method = "cv", number = 5)

logis_model <- train(diabetes ~ .,
                     data = train_df,
                     method = "glm", ## default glm -> logistic regression
                     trControl = ctrl) 

## 3. score
p <- predict(logis_model, newdata = test_df)

## 4. evaulate model
mean(p == test_df$diabetes) ## accuracy

table(test_df$diabetes, p, dnn=c("actual", "preds"))

confusionMatrix(p, 
                test_df$diabetes, 
                positive="pos", 
                mode="prec_recall") 

# Change metric to tune model
ctrl <- trainControl(method = "cv", 
                     number = 5,
                     #pr = precision + recall
                     summaryFunction = prSummary,
                     classProbs = TRUE) ## จะคำนวณ precision, recall ได้ต้องมี classProbs = TRUE

logis_model <- train(diabetes ~ .,
                     data = train_df,
                     method = "glm",
                     metric = "Recall", ## default in R -> acc
                     trControl = ctrl) 

knn_model <- train(diabetes ~ .,
                     data = train_df,
                     method = "knn",
                     metric = "Recall",
                     trControl = ctrl) 
