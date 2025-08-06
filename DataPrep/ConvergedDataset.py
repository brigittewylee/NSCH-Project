import pandas as pd

top_2018 = pd.read_csv("CleanedData(Num)/clean_2018n")
top_2019 = pd.read_csv("CleanedData(Num)/clean_2019n")
top_2020 = pd.read_csv("CleanedData(Num)/clean_2020n")
top_2021 = pd.read_csv("CleanedData(Num)/clean_2021n")
top_2022 = pd.read_csv("CleanedData(Num)/clean_2022n")
top_2023 = pd.read_csv("CleanedData(Num)/clean_2023n")

top_2018['Year'] = 2018
top_2019['Year'] = 2019
top_2020['Year'] = 2020
top_2021['Year'] = 2021
top_2022['Year'] = 2022
top_2023['Year'] = 2023

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


pre = pd.concat([df18, df19])
pre.to_csv("pre_covid", index = False)


peak = pd.concat([df20, df21])
peak.to_csv("peak_covid", index = False)


post = pd.concat([df22, df23])
post.to_csv("post_covid", index = False)

new_df = pd.concat([top_2018, top_2019, top_2020, top_2021, top_2022, top_2023],
                   ignore_index=True)

new_df.to_csv("cleaned_allyears", index=False)
