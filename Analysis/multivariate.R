library(pROC)

top_2018 <- read.csv("CleanedData(Num)/clean_2018n", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019n", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020n", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021n", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022n", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023n", header = TRUE)


fit_glm <- function(df, year = "Unknown") {
  factored_df <- within (df, {BULLIED = as.factor(BULLIED)
                              MAKEFRIEND = as.factor(MAKEFRIEND)})
  glmodel <- glm(BULLIED ~ MAKEFRIEND SEX , family = binomial, data = factored_df)

  prediction <- predict(glmodel, factored_df, type = "response")

  roc_object <- roc(factored_df$BULLIED, prediction)
  auc_value <- auc(roc_object)


  print(paste("Logistic Regression Model of", year, "data"))
  print(with(factored_df, table(BULLIED, MAKEFRIEND)))
  print(summary(glmodel))
  plot(roc_object)
  print(auc_value)
  # saveRDS(glm1, file = paste0("glm_model_", year, ".rds"))
}

fit_glm(top_2018, 2018)
fit_glm(top_2019, 2019)
fit_glm(top_2020, 2020)
fit_glm(top_2021, 2021)
fit_glm(top_2022, 2022)
fit_glm(top_2023, 2023)