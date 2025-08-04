WITH comb_data AS (
    SELECT 
        DATE_TRUNC('month', ad_date)::DATE AS month_start,
        LOWER(SUBSTRING(url_parameters, 'utm_campaign=([^&]+)')) AS utm_campaign,
        COALESCE(reach, 0)::NUMERIC AS reach
    FROM facebook_ads_basic_daily
    WHERE url_parameters IS NOT NULL

    UNION ALL

    SELECT 
        DATE_TRUNC('month', ad_date)::DATE AS month_start,
        LOWER(SUBSTRING(url_parameters, 'utm_campaign=([^&]+)')) AS utm_campaign,
        COALESCE(reach, 0)::NUMERIC AS reach
    FROM google_ads_basic_daily
    WHERE url_parameters IS NOT NULL
),

aggregated AS (
    SELECT 
        month_start,
        utm_campaign,
        SUM(reach) AS monthly_reach
    FROM comb_data
    WHERE utm_campaign IS NOT NULL AND utm_campaign <> 'nan'
    GROUP BY month_start, utm_campaign
),

with_lag AS (
    SELECT 
        utm_campaign,
        month_start,
        monthly_reach,
        LAG(monthly_reach) OVER (PARTITION BY utm_campaign ORDER BY month_start) AS prev_month_reach
    FROM aggregated
)

SELECT 
    utm_campaign,
    month_start,
    monthly_reach,
    prev_month_reach,
    (monthly_reach - prev_month_reach) AS reach_diff
FROM with_lag
WHERE prev_month_reach IS NOT NULL
ORDER BY reach_diff DESC
LIMIT 1;
