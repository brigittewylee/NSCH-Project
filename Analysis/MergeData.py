import pandas as pd

df18 = pd.read_csv("SeverityData/clean_2018")
df19 = pd.read_csv("SeverityData/clean_2019")
df20 = pd.read_csv("SeverityData/clean_2020")
df21 = pd.read_csv("SeverityData/clean_2021")
df22 = pd.read_csv("SeverityData/clean_2022")
df23 = pd.read_csv("SeverityData/clean_2023")

# def merge_datasets (df1, df2, output_path):
#     merged_df_inner = pd.merge(df1, df2)
#     merged_df_inner.to_csv(output_path, index=False)


# merge_datasets(df18, df19, "merged_1819")
# merge_datasets(df20, df21, "merged_2021")
# merge_datasets(df22, df23, "merged_2223")


all_yrs = pd.concat([df18, df19, df20, df21, df22, df23])
all_yrs.to_csv("all_yrs_sev", index = False)

