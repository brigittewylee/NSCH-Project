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


new_df = pd.concat([top_2018, top_2019, top_2020, top_2021, top_2022, top_2023],
                   ignore_index=True)

new_df.to_csv("cleaned_allyears", index=False)
