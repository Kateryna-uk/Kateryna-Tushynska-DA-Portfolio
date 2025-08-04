WITH comb_data AS (
  SELECT 
     ad_date,
    'Facebook Ads' AS media_source,
     spend 
  FROM facebook_ads_basic_daily 
     
    union all
 
    SELECT 
     ad_date,
    'Google Ads' AS media_source,
     spend
  FROM google_ads_basic_daily
)
 
 select ad_date, Media_Source, 
         SUM(spend) as total_spend,
         MIN(spend) AS min_spend_in_day,
         MAX(spend) AS max_spend_in_day,
         ROUND(AVG(spend), 2) AS avg_spend_in_day
  from  comb_data
  group by ad_date, media_source;