#*******************************************************************************
# Runs proc freq and outputs tables of two-way frequencies between ADHD_SEV and
# MAKEFRIEND.
#*******************************************************************************

library(procs)

top_2018 <- read.csv("SeverityData/clean_2018", header = TRUE)
top_2019 <- read.csv("SeverityData/clean_2019", header = TRUE)
top_2020 <- read.csv("SeverityData/clean_2020", header = TRUE)
top_2021 <- read.csv("SeverityData/clean_2021", header = TRUE)
top_2022 <- read.csv("SeverityData/clean_2022", header = TRUE)
top_2023 <- read.csv("SeverityData/clean_2023", header = TRUE)
all_yrs <- read.csv("SeverityData/all_yrs_sev")
pre <- read.csv("SeverityData/peak_covid")
peak <- read.csv("SeverityData/post_covid")
post <- read.csv("SeverityData/pre_covid")


run_proc_freq <- function(df, year) {
  res <- proc_freq(df,
                   tables = MAKEFRIEND * ADHD_SEVERITY,
                   options = v(crosstab, chisq),
                   titles = paste(year, "MAKEFRIEND*SEVERITY"))

  print(res)
  print(with(df, prop.table(table(ADHD_SEVERITY, BULLIED), 1)))

}


# run_proc_freq(top_2018, "2018")
# run_proc_freq(top_2019, "2019")
# run_proc_freq(top_2020, "2020")
# run_proc_freq(top_2021, "2021")
# run_proc_freq(top_2022, "2022")
# run_proc_freq(top_2023, "2023")

run_proc_freq(all_yrs, "all years")
run_proc_freq(pre, "Pre-Covid: 2018-2019")
run_proc_freq(peak, "Peak-Covid: 2020-2021")
run_proc_freq(post, "Post-Covid: 2022-2023")