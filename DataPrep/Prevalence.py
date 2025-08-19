import pandas as pd
import numpy as np

top_2018 = "NSCHData/2018/nsch_2018e_topical.sas7bdat"
top_2019 = "NSCHData/2019/nsch_2019e_topical.sas7bdat"
top_2020 = "NSCHData/2020/nsch_2020e_topical.sas7bdat"
top_2021 = "NSCHData/2021/nsch_2021e_topical.sas7bdat"
top_2022 = "NSCHData/2022/nsch_2022e_topical.sas7bdat"
top_2023 = "NSCHData/2023/nsch_2023e_topical.sas7bdat"


def ADHD_prevalence (df):
    df1 = pd.read_sas(df)
    df2 = df1.loc[df1['SC_AGE_YEARS'].between(12, 17), ['K2Q31B']]
    missing_vals = [999, -999, np.nan, '.M', '.A', '.B', '.C']
    df_na = df2.replace(missing_vals, np.nan)
    df_voi = df_na.dropna(subset=['K2Q31B'])

    counts = df_voi['K2Q31B'].value_counts()
    print(counts)

    total = len(df_voi['K2Q31B'])
    print(total)

    prev = counts.get(1.0, 0) / total * 100
    print(f"Prevalence: {prev:.1f}")


ADHD_prevalence(top_2018)
# ADHD_prevalence(top_2019)
# ADHD_prevalence(top_2020)
# ADHD_prevalence(top_2021)
# ADHD_prevalence(top_2022)
# ADHD_prevalence(top_2023)