
WITH comb_data AS (
    SELECT 
        ad_date,
        COALESCE(spend, 0)::NUMERIC AS spend,
        COALESCE(value, 0)::NUMERIC AS value
    FROM facebook_ads_basic_daily

    UNION ALL

    SELECT 
        ad_date,
        COALESCE(spend, 0)::NUMERIC AS spend,
        COALESCE(value, 0)::NUMERIC AS value
    FROM google_ads_basic_daily
)

SELECT 
    ad_date,
    SUM(spend) AS total_spend,
    SUM(value) AS total_value,
 (
  ROUND(
    CASE 
      WHEN SUM(spend) = 0 THEN 0
      ELSE ((SUM(value) - SUM(spend)) / SUM(spend)) * 100
    END, 
    2)
  
) AS romi

FROM comb_data
GROUP BY ad_date
ORDER BY romi DESC
limit 5;



