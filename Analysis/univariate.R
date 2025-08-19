top_2018 <- read.csv("CleanedData(Num)/clean_2018", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023", header = TRUE)

library(summarytools)

descriptive_stats <- function(df) {
  df[c("SEX", "INCOME", "BULLIED", "MAKEFRIEND", "ADHD_DIAGNOSIS",
       "ADHD_SEVERITY", "ADHD_BT")] <- lapply(df[c("SEX", "INCOME", "BULLIED",
                                                   "MAKEFRIEND",
                                                   "ADHD_DIAGNOSIS",
                                                   "ADHD_SEVERITY",
                                                   "ADHD_BT")], as.factor)
  print(dfSummary(df))
}

descriptive_stats(top_2018)
descriptive_stats(top_2019)
descriptive_stats(top_2020)
descriptive_stats(top_2021)
descriptive_stats(top_2022)
descriptive_stats(top_2023)