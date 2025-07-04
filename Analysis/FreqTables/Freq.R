#*******************************************************************************
# Runs proc freq and outputs tables of two-way frequencies between BULLIED and
# MAKEFRIEND in datasets(numerical) cleaned for all missing values.
#*******************************************************************************

library(procs)

top_2018 <- read.csv("CleanedData(Num)/clean_2018n", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019n", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020n", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021n", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022n", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023n", header = TRUE)

run_proc_freq <- function(df, year = "Unknown") {
  res <- proc_freq(df,
                   tables = MAKEFRIEND * BULLIED,
                   options = v(crosstab, chisq),
                   titles = paste(year, "MAKEFRIEND vs BULLIED"))

  # Print results
  print(res)
}

run_proc_freq(top_2018, year = "2018")
run_proc_freq(top_2019, year = "2019")
run_proc_freq(top_2020, year = "2020")
run_proc_freq(top_2021, year = "2021")
run_proc_freq(top_2022, year = "2022")
run_proc_freq(top_2023, year = "2023")
