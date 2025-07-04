import pandas as pd
import numpy as np

# topical data:
top_2018 = "NSCHData/2018/nsch_2018e_topical.sas7bdat"
top_2019 = "NSCHData/2019/nsch_2019e_topical.sas7bdat"
top_2020 = "NSCHData/2020/nsch_2020e_topical.sas7bdat"
top_2021 = "NSCHData/2021/nsch_2021e_topical.sas7bdat"
top_2022 = "NSCHData/2022/nsch_2022e_topical.sas7bdat"
top_2023 = "NSCHData/2023/nsch_2023e_topical.sas7bdat"

# # check all variables are present
required_vars=['SC_AGE_YEARS', 'SC_SEX', 'FPL_I1', 'BULLIED_R', 'MAKEFRIEND', 
               'K2Q31A', 'K2Q31B', 'K2Q31C', 'K2Q31D', 'ADDTREAT', 'FIPSST', 
               'STRATUM', 'HHID']
# datasets = {'df1': top_2019, 'df2': top_2020, 'df3': top_2021, 'df4': top_2022, 'df5': top_2023}

# for name, df in datasets.items():
#     df=pd.read_sas(df)
#     missing = [col for col in required_vars if col not in df.columns]
#     if missing:
#         print(f"{name} is missing: {missing}")
#     else:
#         print(f"{name} has all required variables.")


missing_vals = [999, -999, np.inf, -np.inf, '.M', '.A', '.B', '.C']

def clean_data(file, output_path):
    # isolate voi
    df = pd.read_sas(file)
    df_var = df[required_vars]

    df_na = df_var.replace(missing_vals, np.nan)
    
    df_filtered = df_na[(df_na['SC_AGE_YEARS'].between(12, 17)) &
                        (df_na['K2Q31A'] == 1) &
                        (df_na['K2Q31B'] == 1) &
                        (df_na['K2Q31C'].isin([1, 2, 3]))]
    
    df_voi = df_filtered.dropna()
    # df_voi = df_filtered.dropna(subset=['SC_AGE_YEARS', 'SC_SEX', 'FPL_I1', 
    #            'K2Q31A', 'K2Q31B', 'K2Q31C', 'K2Q31D', 'ADDTREAT', 'FIPSST', 
    #            'STRATUM', 'HHID'])
    
    # reclassification
    income_cond = [(df_voi['FPL_I1'] > 0) & (df_voi['FPL_I1'] <= 199),
                   (df_voi['FPL_I1'] >= 200) & (df_voi['FPL_I1'] <= 299),
                   (df_voi['FPL_I1'] >= 300) & (df_voi['FPL_I1'] <= 399),
                   (df_voi['FPL_I1'] >= 400)]
    income_choice = [0, 1, 2, 3]

    bullied_cond = [df_voi['BULLIED_R'].isin([2, 3, 4, 5]), 
                    df_voi['BULLIED_R'] == 1]
    bullied_choice = [1, 0]

    diagnosis_cond = [df_voi['K2Q31A'] == 2,
                      (df_voi['K2Q31A'] == 1) & (df_voi['K2Q31B'] == 2),
                      (df_voi['K2Q31A'] == 1) & (df_voi['K2Q31B'] == 1)]
    diagnosis_choice = [0, 0, 1]

    # income_cond = [(df_voi['FPL_I1'] > 0) & (df_voi['FPL_I1'] <= 199),
    #                (df_voi['FPL_I1'] >= 200) & (df_voi['FPL_I1'] <= 299),
    #                (df_voi['FPL_I1'] >= 300) & (df_voi['FPL_I1'] <= 399),
    #                (df_voi['FPL_I1'] >= 400)]
    # income_choice = ["0-199% FPL", "200-299% FPL", "300-399% FPL", "400% FPL or greater"]

    # bullied_cond = [df_voi['BULLIED_R'].isin([2, 3, 4, 5]), 
    #                 df_voi['BULLIED_R'] == 1]
    # bullied_choice = ['yes', 'no']

    # diagnosis_cond = [df_voi['K2Q31A'] == 2,
    #                   (df_voi['K2Q31A'] == 1) & (df_voi['K2Q31B'] == 2),
    #                   (df_voi['K2Q31A'] == 1) & (df_voi['K2Q31B'] == 1)]
    # diagnosis_choice = ['no', 'no', 'yes']

    df_clean = pd.DataFrame({
        'AGE': df_voi['SC_AGE_YEARS'],
        'SEX': df_voi['SC_SEX'].map({1: 0, 
                                     2: 1}).fillna(np.nan),
        'INCOME': np.select(income_cond, income_choice, default=np.nan), 
        'BULLIED': np.select(bullied_cond, bullied_choice , default=np.nan),
        'MAKEFRIEND': df_voi['MAKEFRIEND'].map({1: 0, 
                                               2: 1, 
                                               3: 2}).fillna(np.nan),
        'ADHD_DIAGNOSIS':np.select(diagnosis_cond, diagnosis_choice , default=np.nan),
        'ADHD_SEVERITY': df_voi['K2Q31C'].map({1: 0, 
                                               2: 1, 
                                               3: 2}).fillna(np.nan),
        'ADHD_MEDICATION': df_voi['K2Q31D'].map({1: 1, 
                                                 2: 0}).fillna(np.nan),
        'ADHD_BT': df_voi['ADDTREAT'].map({1: 1, 
                                           2: 0}).fillna(np.nan)

        # 'SEX': df_voi['SC_SEX'].map({1: 'Male', 
        #                              2: 'Female'}).fillna(np.nan),
        # 'INCOME': np.select(income_cond, income_choice, default=np.nan), 
        # 'BULLIED': np.select(bullied_cond, bullied_choice , default=np.nan),
        # 'MAKEFRIEND': df_voi['MAKEFRIEND'].map({1: 'no difficulty', 
        #                                        2: 'little difficulty', 
        #                                        3:'lots of difficulty'}).fillna(np.nan),
        # 'ADHD_DIAGNOSIS':np.select(diagnosis_cond, diagnosis_choice , default=np.nan),
        # 'ADHD_SEVERITY': df_voi['K2Q31C'].map({1: 'mild', 
        #                                        2: 'moderate', 
        #                                        3: 'severe'}).fillna(np.nan),
        # 'ADHD_MEDICATION': df_voi['K2Q31D'].map({1: 'medication', 
        #                                          2: 'no medication'}).fillna(np.nan),
        # 'ADHD_BT': df_voi['ADDTREAT'].map({1: 'treatment', 
        #                                    2: 'no treatment'}).fillna(np.nan)
    })
    df_clean.to_csv(output_path, index=False)
    return df_clean

clean_data(top_2019, 'clean_2019')
# clean_data(top_2019, 'covar_na_2019')
# clean_data(top_2020, 'covar_na_2020')
# clean_data(top_2021, 'covar_na_2021')
# clean_data(top_2022, 'covar_na_2022')
# clean_data(top_2023, 'covar_na_2023')
