# Kateryna-Tushynska-DA-Portfolio
Hi! I'm an aspiring Junior Data Analyst with 9 years of business background in tourism.  
This portfolio highlights my skills in SQL, BigQuery & GA4


This folder contains SQL scripts created as part of a campaign performance analysis project based on open datasets from Facebook and Google Ads.

## 🔍 SQL Files:

- `Script_min_max_avg_daily_spend.sql`  
  → Calculates daily total, min, max, and average spend across platforms. Helps identify abnormal spikes or drops in spend.

- `Script_TOP_ROMI_5.sql`  
  → Aggregates daily spend and value, calculates ROMI using ((value − spend) / spend) × 100, and selects top 5 days with highest return on investment.

- `Script_campaign_week_higher_value.sql`  
  → Aggregates revenue by campaign per week and identifies the campaign with the highest weekly value.

- `Script_Reach_diff_campaign.sql`  
  → Calculates monthly reach per campaign and finds the month with the largest MoM growth using `LAG()`.

## 📂 Dataset:

- `facebook_ads_basic_daily`
- `google_ads_basic_daily`

Used in PostgreSQL



Users Behavior & Conversion (BigQuery links)

[Core User Events Extract](https://console.cloud.google.com/bigquery?sq=88226012018:16a8f616fd0d4a3f971ca84695821675) 
Key user events (session_start → purchase) were extracted from the GA4 dataset for 2021.
Session ID, country, device type, and traffic source were added to build a sales funnel and analyze user behavior.

[Conversion of landing page](https://console.cloud.google.com/bigquery?sq=88226012018:b30ca74abfbc4b2aa21e2f9682eee9d4)
Matching sessions with purchases by user and session ID, extracting page_path from page_location.
Calculating conversion rates for each landing page to identify high- and low-performing pages.

[Conversion funnel by traffic sources](https://console.cloud.google.com/bigquery?sq=88226012018:cdcc4055732d495db9a2b71dff7213e5)
A funnel was built at the session level from session_start to purchase, grouped by traffic sources, environment, and campaign.
Conversion rates were calculated for each stage of the funnel (add_to_cart → checkout → purchase) to analyze channel effectiveness.

## 📂 Dataset:

- `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*``

Used BigQuery & GA4
