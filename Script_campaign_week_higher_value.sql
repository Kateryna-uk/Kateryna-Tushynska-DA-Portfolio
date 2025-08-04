WITH comb_data AS (
    SELECT 
        cast(DATE_TRUNC('week', ad_date) as DATE) AS week_start,
        LOWER(SUBSTRING(url_parameters, 'utm_campaign=([^&]+)')) AS utm_campaign,
        COALESCE(value, 0)::NUMERIC AS value
    FROM facebook_ads_basic_daily
    WHERE url_parameters IS NOT NULL

    UNION ALL

    SELECT 
        cast(DATE_TRUNC('week', ad_date) as DATE) AS week_start,
        LOWER(SUBSTRING(url_parameters, 'utm_campaign=([^&]+)')) AS utm_campaign,
        COALESCE(value, 0)::NUMERIC AS value
    FROM google_ads_basic_daily
    WHERE url_parameters IS NOT NULL
),

aggregated_data AS (
    SELECT 
        week_start,
        utm_campaign,
        ROUND(SUM(value):: NUMERIC, 2) AS total_value
    FROM comb_data
    WHERE utm_campaign IS NOT NULL AND utm_campaign <> 'nan'
    GROUP BY week_start, utm_campaign
)

SELECT 
    week_start,
    utm_campaign,
    total_value
FROM aggregated_data
ORDER BY total_value DESC
LIMIT 1;