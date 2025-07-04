#*******************************************************************************
# Fits data to logistic model and generates model summary, ORs, ROC/AUC for
# bivariate association between BULLIED and MAKEFRIEND.
#*******************************************************************************

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
  glmodel <- glm(BULLIED ~ MAKEFRIEND, family = binomial, data = factored_df)

  coefs <- summary(glmodel)$coefficients
  beta_val <- coefs[-1, 1]
  std_errors <- coefs[-1, 2]

  lower_ci <- beta_val - qnorm(0.975) * std_errors
  upper_ci <- beta_val + qnorm(0.975) * std_errors
  CI_table <- data.frame(
    CI_Lower = lower_ci,
    CI_Upper = upper_ci
  )

  OR <- exp(beta_val)
  OR_lower <- exp(lower_ci)
  OR_upper <- exp(upper_ci)
  OR_table <- data.frame(
    Beta_val = beta_val,
    OR = OR,
    CI_Lower = OR_lower,
    CI_Upper = OR_upper
  )

  prediction <- predict(glmodel, factored_df, type = "response")

  roc_object <- roc(factored_df$BULLIED, prediction)
  auc_value <- auc(roc_object)

  cat("Logistic Regression Model of", year, "data\n\n")
  print(with(factored_df, table(BULLIED, MAKEFRIEND)))
  cat("\nModel Summary:\n")
  print(summary(glmodel))

  cat("\nLog-odds 95% Confidence Intervals:\n")
  print(CI_table)

  cat("\nOdds Ratios (OR) with 95% Confidence Intervals:\n")
  print(OR_table)

  plot(roc_object, main = paste("ROC Curve", year))
  print(auc_value)

  cat("===================================================\n\n")
}


# fit_glm(top_2018, 2018)
# fit_glm(top_2019, 2019)
fit_glm(top_2020, 2020)
# fit_glm(top_2021, 2021)
# fit_glm(top_2022, 2022)
# fit_glm(top_2023, 2023)