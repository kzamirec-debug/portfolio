# Titanic Passengers: Exploratory Data Analysis & Survival Insights

## Project Overview
This project focuses on a comprehensive Exploratory Data Analysis (EDA) of the classic Titanic passenger dataset. The primary objective was to investigate the structural relationships within the data, analyze distributions across various demographic segments, and uncover key socio-economic and situational factors that directly influenced passenger survival rates.

## Tools & Technologies
- **Language:** Python
- **Libraries:** Pandas, NumPy (Data Manipulation & Aggregation)
- **Data Visualization:** Seaborn, Matplotlib (Exploratory Plotting)
- **Environment:** Jupyter Notebook / Google Colab

## Analytical Workflow
1. **Data Inspection:** Explored the structural components of the dataset, identifying key data types and distributions.
2. **Feature Segmentation:** Segmented passengers by behavioral, demographic, and socio-economic variables (Age groups, Ticket Class, Family Size, and Cabin Levels).
3. **Statistical Aggregation:** Calculated explicit survival percentages across distinct categories to isolate critical factors.

## Key Insights
- **Socio-Economic Impact:** Passengers in the 3rd Class (`Pclass = 3`) faced the highest mortality rate (~75.8%), proving a strong correlation between ticket class (socio-economic status) and survival chances.
- **Age Vulnerability:** Senior passengers (aged 60 and older) had a significantly high mortality rate (~74.1%), highlighting the physical difficulties during the emergency evacuation.
- **Family Size Dynamics:** Travel company size significantly influenced outcomes; passengers traveling with larger families (specifically 5 relatives) experienced a stark mortality rate of 86.36%.
- **Conclusion:** While family size and age played vital roles, **Ticket Class** was identified as the single most critical determinant of survival due to the massive discrepancy in safety access.
