# Netflix Movie and TV Shows Data Analysis Using SQL

![Netflix Logo](https://github.com/esiihle/sql_netflix_manipulation/blob/main/logo.png)

## Overview
This project goes beyond a simple look at the numbers. It's a deep dive into Netflix's content library, using **SQL to uncover strategic insights** that can inform business decisions. By analyzing everything from content trends and top genres to geographic content production and audience ratings, this analysis provides a clear picture of the what, where, and why behind the platform's success.

## Objective
The goal was to transform raw data into actionable intelligence. The project tackles key business questions, such as:

* What content should a streaming service prioritize?
* Which countries are the most valuable content creators?
* How can we understand audience preferences through ratings and descriptions?

By answering these questions, this analysis provides a valuable framework for understanding the Netflix content landscape.

---

## Key Insights
Here are just a few of the compelling findings revealed through this analysis:

* **Content Dominance:** The United States, India, and the United Kingdom dominate the content library, highlighting their status as major production hubs for the platform.
* **Audience Demographics:** Movies are most often rated **TV-MA**, while TV shows are most commonly rated **TV-14**. This suggests a strategic focus on mature and young adult audiences for different content types.
* **Genre and Description Analysis:** By categorizing content as "Good" or "Bad" based on descriptive keywords like "violence" and "kill," the analysis reveals surprising patterns in specific genres.
* **Top Performers:** The project identifies key players, including the top 10 actors in South African productions and the longest-running movies, providing insights into content that may drive higher engagement.

---

## Technical Approach
This analysis was performed entirely using SQL. The following techniques were used to manipulate and query the dataset:

* **Data Transformation:** Employed functions like `UNNEST` and `STRING_TO_ARRAY` to effectively handle and transform semi-structured data, such as `country` and `casts`, for deeper analysis.
* **Aggregations & Ranking:** Utilized `GROUP BY` and window functions like `RANK()` to identify top content, most common ratings, and leading production countries.
* **Temporal Analysis:** Analyzed content additions and release years using `TO_DATE` and `EXTRACT` to identify content trends over time.
* **Pattern Matching:** Used string functions like `ILIKE` and `SPLIT_PART` to categorize content based on keywords in the description and extract numerical values from the `duration` field.
