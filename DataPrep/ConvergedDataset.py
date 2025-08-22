import pandas as pd

top_2018 = pd.read_csv("CleanedData(Num)/clean_2018")
top_2019 = pd.read_csv("CleanedData(Num)/clean_2019")
top_2020 = pd.read_csv("CleanedData(Num)/clean_2020")
top_2021 = pd.read_csv("CleanedData(Num)/clean_2021")
top_2022 = pd.read_csv("CleanedData(Num)/clean_2022")
top_2023 = pd.read_csv("CleanedData(Num)/clean_2023")

def severity(df):
    print(df['ADHD_SEVERITY'].unique())

severity(top_2018)
severity(top_2019)
severity(top_2020)
severity(top_2021)
severity(top_2022)
severity(top_2023)

# pre = pd.concat([df18, df19])
# pre.to_csv("pre_covid", index = False)


# peak = pd.concat([df20, df21])
# peak.to_csv("peak_covid", index = False)


# post = pd.concat([df22, df23])
# post.to_csv("post_covid", index = False)

# new_df = pd.concat([top_2018, top_2019, top_2020, top_2021, top_2022, top_2023],
#                    ignore_index=True)

# new_df.to_csv("cleaned_allyears", index=False)
