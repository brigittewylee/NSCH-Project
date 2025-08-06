#*******************************************************************************
# Generates descriptive stats for each variable in target age group (12-17).
#*******************************************************************************

library(procs)

top_2018 <- read.csv("CleanedData(Num)/clean_2018n", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019n", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020n", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021n", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022n", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023n", header = TRUE)

voi <- v(SEX, INCOME, BULLIED, MAKEFRIEND, ADHD_SEVERITY, ADHD_MEDICATION,
         ADHD_BT)

univar_analysis <- function(df, year = "Unknown"){
  for (var in voi){
    res <- proc_means(df,
                      var = AGE,
                      stats = c("n", "mean", "std", "min", "max"),
                      output = NULL,
                      by = NULL,
                      class = var,
                      options = NULL,
                      titles = NULL)

  }
}

univar_analysis(top_2018, "2018")
univar_analysis(top_2019, "2019")
univar_analysis(top_2020, "2020")
univar_analysis(top_2021, "2021")
univar_analysis(top_2022, "2022")
univar_analysis(top_2023, "2023")
