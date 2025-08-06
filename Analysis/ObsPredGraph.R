library(ggplot2)
library(grid)
library(gridExtra)

top_2018 <- read.csv("CleanedData(Num)/clean_2018n", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019n", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020n", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021n", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022n", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023n", header = TRUE)

obs_pred <- function(df, year = "Unknown") {
  factored_df <- within(df, {BULLIED = as.factor(BULLIED)
                             MAKEFRIEND = as.factor(MAKEFRIEND)})

  glmodel <- glm(BULLIED ~ MAKEFRIEND + SEX + INCOME + ADHD_MEDICATION +
                   ADHD_BT,
                 family = binomial, data = factored_df)

  predicted <- predict(glmodel, type = "response")
  res <- resid(glmodel, type = "deviance")

  gplot <- ggplot(df, aes(x = predicted,
                          y = BULLIED)) + geom_point() +
    geom_jitter(height = 0.05) +
    geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
    geom_smooth(method = "glm", method.args = list(family = "binomial")) +
    labs(x = "Predicted Values", y  = "Observed Values",
         title = paste("Predicted vs. Observed Values", year))

  resplot <- ggplot(df, aes(x = MAKEFRIEND,
                            y = res)) + geom_point() +
    geom_jitter(height = 0.05) +
    labs(x = "MAKEFRIEND", y  = "Residuals",
         title = paste("Residual Plot", year))

  grid.newpage()
  print(grid.arrange(gplot, resplot, nrow = 2))
}

obs_pred(top_2018, "2018")
obs_pred(top_2019, "2019")
obs_pred(top_2020, "2020")
# obs_pred(top_2021, "2021")
# obs_pred(top_2022, "2022")
# obs_pred(top_2023, "2023")
