# Movie Data

## Project Overview
This project focuses on extracting, parsing, and analyzing historical movie records spans from 1900 to 1969 sourced from Wikipedia dataset repositories. The primary objective was to clean unformatted JSON text strings, restructure multidimensional attributes, and conduct an Exploratory Data Analysis (EDA) to map the evolution of film genres, production volumes, and core industry trends across seven decades.

## Tools & Technologies
- **Language:** Python
- **Libraries:** Pandas, NumPy (Data Structuring & Aggregation), JSON (Data Parsing)
- **Data Visualization:** Seaborn, Matplotlib (Trend & Distribution Plotting)
- **Environment:** Jupyter Notebook / Google Colab

## Analytical Workflow
1. **Data Gathering & Parsing:** Programmatically fetched decade-specific movie data from remote repositories, handling complex JSON arrays to unify disparate textual schemas into a centralized DataFrame.
2. **Data Wrangling & Feature Engineering:** Cleaned missing values, filtered inconsistent records, and structured raw text data into explicit analytical dimensions (Decades, Genres, and Release Years).
3. **Exploratory Data Analysis (EDA):** Aggregated movie frequencies to trace industrial growth curves and analyzed dynamic distributions of distinct cinematic genres over time.

## Key Insights
- **Production Boom:** Identified a significant exponential growth in film production volume starting from the late 1920s, aligning historically with the transition from silent films to "talkies".
- **Genre Evolution:** Documented the cyclical popularity of core movie genres, displaying how specific entertainment segments dominated distinct decades based on socio-economic shifts.
- **Data Quality Value:** Demonstrated the necessity of robust string/JSON cleaning protocols, as historical datasets heavily suffer from non-standardized feature logging.
