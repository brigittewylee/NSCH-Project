#*******************************************************************************
# Fits data to logistic model for the association between BULLIED and MAKEFRIEND
# after accounting for confounders and interaction term (ADHD_SEV). Generates
# CI and OR for all combinations of ADHD_SEV and MFRIEND.
#*******************************************************************************

top_2018 <- read.csv("CleanedData(Num)/clean_2018", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023", header = TRUE)

# all_yrs <- read.csv("all_yrs_sev")
CI_table <- function(data_year) {
  data_year$BULLIED <- as.factor(data_year$BULLIED)
  data_year$MAKEFRIEND <- as.factor(data_year$MAKEFRIEND)
  data_year$ADHD_SEV <- as.factor(data_year$ADHD_SEVERITY)

  glmodel <- glm(BULLIED ~ MAKEFRIEND + SEX + INCOME + ADHD_MEDICATION +
                   ADHD_BT + MAKEFRIEND * ADHD_SEV,
                 family = binomial, data = data_year)

  coefs <- coef(glmodel)[c("(Intercept)", "MAKEFRIEND1", "MAKEFRIEND2",
                           "ADHD_SEV1", "MAKEFRIEND1:ADHD_SEV1",
                           "MAKEFRIEND2:ADHD_SEV1")]

  raw_cov_matrix <- vcov(glmodel)
  vcov_matrix <- raw_cov_matrix[c("(Intercept)", "MAKEFRIEND1", "MAKEFRIEND2",
                                  "ADHD_SEV1", "MAKEFRIEND1:ADHD_SEV1",
                                  "MAKEFRIEND2:ADHD_SEV1"),
                                c("(Intercept)", "MAKEFRIEND1", "MAKEFRIEND2",
                                  "ADHD_SEV1", "MAKEFRIEND1:ADHD_SEV1",
                                  "MAKEFRIEND2:ADHD_SEV1")]
  combos <- expand.grid(MAKEFRIEND = c(0:2), ADHD_SEV = c(0:1))

  # design vectors for all combos
  make_design_vector <- function(mf, sev) {
    c(
      1,
      as.numeric(mf == 1),
      as.numeric(mf == 2),
      as.numeric(sev == 1),
      as.numeric(mf == 1 & sev == 1),
      as.numeric(mf == 2 & sev == 1)
    )
  }

  # populate matrix with dv
  design_matrix <- t(apply(combos, 1, function(row) {
    make_design_vector(row["MAKEFRIEND"], row["ADHD_SEV"])
  }))
  colnames(design_matrix) <- names(coefs)

  # dv referenced to baseline [1,0,0,0,0,0]
  ref_dv <- design_matrix[1, ]
  dv_rows <- nrow(design_matrix)
  dv_cols <- ncol(design_matrix)

  ref_combo_dv <- matrix(nrow = dv_rows, ncol = dv_cols)
  colnames(ref_combo_dv) <- names(coefs)

  for (i in 1:dv_rows) {
    val <- design_matrix[i, ] - ref_dv
    ref_combo_dv [i, ] <- val
  }

  # calculate log odds for each combo
  log_odds <- ref_combo_dv %*% coefs
  odds_ratio <- exp(log_odds)

  # calculate var for each combo
  lovcov <- numeric()
  total_rows <- nrow(ref_combo_dv)
  for (i in 1:total_rows){
    dv <- matrix(as.numeric(ref_combo_dv[i, ]), nrow = 1)
    var_logit <- dv %*% vcov_matrix %*% t(dv)
    lovcov <- append(lovcov, var_logit[1, 1])
  }

  # calculate standard error
  SE <- sqrt(lovcov)

  # calculate 95% CI
  total_length <- length(SE)

  upper_log_ci <- numeric()
  lower_log_ci <- numeric()

  for (i in 1:total_length) {
    ci <- log_odds[i] + (1.96 * SE[i])
    upper_log_ci <- append(upper_log_ci, ci)
  }

  for (i in 1:total_length) {
    ci <- log_odds[i] - (1.96 * SE[i])
    lower_log_ci <- append(lower_log_ci, ci)
  }

  upper_ci <- exp(upper_log_ci)
  lower_ci <- exp(lower_log_ci)

  CI <- data.frame(Lower = lower_ci, Upper = upper_ci)
  print(CI)
  print(odds_ratio)
  print(summary(glmodel))
}

CI_table(all_yrs)
# CI_table(top_2019)
# CI_table(top_2020)
# CI_table(top_2021)
# CI_table(top_2022)
# CI_table(top_2023)
