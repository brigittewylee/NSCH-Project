
top_2018 <- read.csv("SeverityData/clean_2018", header = TRUE)
top_2019 <- read.csv("SeverityData/clean_2019", header = TRUE)
top_2020 <- read.csv("SeverityData/clean_2020", header = TRUE)
top_2021 <- read.csv("SeverityData/clean_2021", header = TRUE)
top_2022 <- read.csv("SeverityData/clean_2022", header = TRUE)
top_2023 <- read.csv("SeverityData/clean_2023", header = TRUE)



OR_table <- function(data_year) {
  data_year$BULLIED <- as.factor(data_year$BULLIED)
  data_year$MAKEFRIEND <- as.factor(data_year$MAKEFRIEND)
  data_year$ADHD_SEV <- as.factor(data_year$ADHD_SEVERITY)

  glmodel <- glm(BULLIED ~ MAKEFRIEND + SEX + INCOME + ADHD_MEDICATION +
                 ADHD_BT + MAKEFRIEND * ADHD_SEV,
               family = binomial, data = data_year)

  coefs <- coef(glmodel)
  combos <- expand.grid(MAKEFRIEND = c(0:2), ADHD_SEV = c(0:1))

  get_or_relative <- function(coefs, mf, sev) {
    logit_diff <- 0

    # severity == 0
    if (mf == 0 && sev == 0) {
      logit_diff
    }
    if (mf == 1 && sev == 0) {
      logit_diff <- logit_diff + coefs["MAKEFRIEND1"]
    }
    if (mf == 2 && sev == 0) {
      logit_diff <- logit_diff + coefs["MAKEFRIEND2"]
    }

    # severity == 1
    if (mf == 0 && sev == 1) {
      logit_diff <- logit_diff + coefs["ADHD_SEV1"]
    }
    if (mf == 1 && sev == 1) {
      logit_diff <- logit_diff + coefs["MAKEFRIEND1"] + coefs["ADHD_SEV1"] +
        coefs["MAKEFRIEND1:ADHD_SEV1"]
    }
    if (mf == 2 && sev == 1) {
      logit_diff <- logit_diff + coefs["MAKEFRIEND2"] + coefs["ADHD_SEV1"] +
        coefs["MAKEFRIEND2:ADHD_SEV1"]
    }
    exp(logit_diff)
  }

  combos$OR <- NA
  total_rows <- nrow(combos)
  for (i in 1:total_rows) {
    combos$OR[i] <- get_or_relative(coefs, combos$MAKEFRIEND[i],
                                    combos$ADHD_SEV[i])
  }
  print(combos)
}


# OR_table(top_2018)
# OR_table(top_2019)
# OR_table(top_2020)
OR_table(top_2021)
# OR_table(top_2022)
# OR_table(top_2023)
