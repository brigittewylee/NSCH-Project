library(procs)


df <- read.csv("cleaned_allyears")


run_proc_freq <- function(df) {
  res <- proc_freq(df,
                   tables = YEAR * ADHD_SEVERITY,
                   options = v(crosstab, chisq),
                   titles = paste("YEAR vs SEVERITY"))

  print(res)
}

print(with(df, prop.table(table(ADHD_SEVERITY, BULLIED), 1)))


run_proc_freq(df)