library(tidytlg)
library(plyr)
library(dplyr)

top_2018 <- read.csv("CleanedData(Num)/clean_2018n", header = TRUE)
top_2019 <- read.csv("CleanedData(Num)/clean_2019n", header = TRUE)
top_2020 <- read.csv("CleanedData(Num)/clean_2020n", header = TRUE)
top_2021 <- read.csv("CleanedData(Num)/clean_2021n", header = TRUE)
top_2022 <- read.csv("CleanedData(Num)/clean_2022n", header = TRUE)
top_2023 <- read.csv("CleanedData(Num)/clean_2023n", header = TRUE)

univariate_analysis <- function(ds, age_output_path, output_path) {
  rowvars <- setdiff(colnames(ds), c("AGE", "ADHD_DIAGNOSIS"))

  age_tbl <- as.data.frame(
    tidytlg::univar(
      df = ds,
      colvar = "ADHD_DIAGNOSIS",
      rowvar = "AGE",
      statlist = statlist(c("N", "MEANSD", "MEDIAN", "RANGE")),
      decimal = 0,
      row_header = "Age (Years)"
    )
  )

  summary_df <- data.frame()
  for (vars in rowvars) {
    tbl <- as.data.frame(table(Variable = ds[[vars]],
                               ADHD_DIAGNOSIS = ds$ADHD_DIAGNOSIS))
    tbl$VariableName <- vars
    tbl <- tbl %>%
      group_by(Variable, ADHD_DIAGNOSIS) %>%
      mutate(Percentage = 100 * Freq / sum(Freq)) %>%
      ungroup()
    summary_df <- rbind.data.frame(summary_df, tbl)
    univar_summary <- summary_df[c("VariableName", "Variable", "Freq",
                                   "Percentage")]
  }
  write.csv(age_tbl, age_output_path)
  write.csv(univar_summary, output_path)
}

univariate_analysis(top_2018, "univar_age_2018", "univar_2018")
univariate_analysis(top_2019, "univar_age_2019", "univar_2019")
univariate_analysis(top_2020, "univar_age_2020", "univar_2020")
univariate_analysis(top_2021, "univar_age_2021", "univar_2021")
univariate_analysis(top_2022, "univar_age_2022", "univar_2022")
univariate_analysis(top_2023, "univar_age_2023", "univar_2023")
