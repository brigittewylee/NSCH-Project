#*******************************************************************************
# Runs proc freq and outputs tables of two-way frequencies between BULLIED and
# NA_MAKEFRIEND, and MAKEFRIEND and NA_BULLIED after removing entries with
# missing values in covariates
#*******************************************************************************

library(procs)

# load datasets
raw_2018 <- read.csv("AssessMissingness/CleanedNACovar(Num)/covar_na_2018", header = TRUE)
raw_2019 <- read.csv("AssessMissingness/CleanedNACovar(Num)/covar_na_2019", header = TRUE)
raw_2020 <- read.csv("AssessMissingness/CleanedNACovar(Num)/covar_na_2020", header = TRUE)
raw_2021 <- read.csv("AssessMissingness/CleanedNACovar(Num)/covar_na_2021", header = TRUE)
raw_2022 <- read.csv("AssessMissingness/CleanedNACovar(Num)/covar_na_2022", header = TRUE)
raw_2023 <- read.csv("AssessMissingness/CleanedNACovar(Num)/covar_na_2023", header = TRUE)

# Indicators on missing values in BULLIED/MAKEFRIEND columns
raw_2018$NA_BULLIED <- ifelse(is.na(raw_2018$BULLIED), 1, 0)
raw_2018$NA_MAKEFRIEND <- ifelse(is.na(raw_2018$MAKEFRIEND), 1, 0)

raw_2019$NA_BULLIED <- ifelse(is.na(raw_2019$BULLIED), 1, 0)
raw_2019$NA_MAKEFRIEND <- ifelse(is.na(raw_2019$MAKEFRIEND), 1, 0)

raw_2020$NA_BULLIED <- ifelse(is.na(raw_2020$BULLIED), 1, 0)
raw_2020$NA_MAKEFRIEND <- ifelse(is.na(raw_2020$MAKEFRIEND), 1, 0)

raw_2021$NA_BULLIED <- ifelse(is.na(raw_2021$BULLIED), 1, 0)
raw_2021$NA_MAKEFRIEND <- ifelse(is.na(raw_2021$MAKEFRIEND), 1, 0)

raw_2022$NA_BULLIED <- ifelse(is.na(raw_2022$BULLIED), 1, 0)
raw_2022$NA_MAKEFRIEND <- ifelse(is.na(raw_2022$MAKEFRIEND), 1, 0)

raw_2023$NA_BULLIED <- ifelse(is.na(raw_2023$BULLIED), 1, 0)
raw_2023$NA_MAKEFRIEND <- ifelse(is.na(raw_2023$MAKEFRIEND), 1, 0)

#*******************************************************************************

proc_freq_covarna <- function(df, year = "Unknown") {
  # Run proc_freq on columns for missingness indicator of bullied and makefriend
  res_bullied <- proc_freq(df,
                           tables = MAKEFRIEND * NA_BULLIED,
                           options = v(crosstab, chisq),
                           titles = paste(year, "MAKEFRIEND vs NA_BULLIED"))
  res_friend <- proc_freq(df,
                          tables = BULLIED * NA_MAKEFRIEND,
                          options = v(crosstab, chisq),
                          titles = paste(year, "BULLIED vs NA_MAKEFRIEND"))
}

# proc_freq_covarna(raw_2018, year = "Covar 2018")
proc_freq_covarna(raw_2019, year = "Covar 2019")
proc_freq_covarna(raw_2020, year = "Covar 2020")
proc_freq_covarna(raw_2021, year = "Covar 2021")
proc_freq_covarna(raw_2022, year = "Covar 2022")
proc_freq_covarna(raw_2023, year = "Covar 2023")