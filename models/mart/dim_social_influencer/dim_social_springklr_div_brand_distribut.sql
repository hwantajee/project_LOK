
SELECT
    -- CASE WHEN _reply_rate LIKE '%`%' THEN CAST(replace(_reply_rate, '`', '') AS FLOAT64) 
    -- END reply_rate,
    -- CASE WHEN _reply_rate_public LIKE '%`%' THEN CAST(replace(_reply_rate_public,'`', '') AS FLOAT64)
    -- END reply_rate_public,
    -- CASE WHEN ai_categorized_cases_sum_ LIKE '%`%' THEN CAST(replace(ai_categorized_cases_sum_,'`', '') AS FLOAT64)
    -- END ai_categorized_cases_sum,
    -- CASE WHEN ai_categorized_rate_in_ LIKE '%`%' THEN CAST(replace( ai_categorized_rate_in_,'`', '') AS FLOAT64)
    -- END ai_categorized_rate_in,
    -- CASE WHEN auto_categorized LIKE '%`%' THEN CAST(replace  (auto_categorized,'`', '') AS FLOAT64)
    -- END auto_categorized,
    -- CASE WHEN auto_categorized_rate_in_ LIKE '%`%' THEN CAST(replace( auto_categorized_rate_in_,'`', '') AS FLOAT64)
    -- END auto_categorized_rate_in,
    -- brand_case_ AS brand_case,
    -- CASE WHEN categorized LIKE '%`%' THEN CAST(replace( categorized ,'`', '') AS FLOAT64)
    -- END categorized,
    -- CASE WHEN categorized_rate_in_ LIKE '%`%' THEN CAST(replace( categorized_rate_in_ ,'`', '') AS FLOAT64)
    -- END categorized_rate_in,
    -- CASE WHEN conversations LIKE '%`%' THEN CAST(replace( conversations,'`', '') AS FLOAT64)
    -- END conversations,
    -- date,
    -- division_case_ AS division_case,
    -- CASE WHEN replied LIKE '%`%' THEN CAST(replace(replied,'`', '') AS FLOAT64)
    -- END replied,
    -- CASE WHEN reply_rate_mention LIKE '%`%' THEN CAST(replace(reply_rate_mention,'`', '') AS FLOAT64)
    -- END reply_rate_mention,
    -- CASE WHEN reply_rate_private LIKE '%`%' THEN CAST(replace(reply_rate_private,'`', '') AS FLOAT64)
    -- END reply_rate_private
*
FROM {{ref('stg_social_springklr_div_brand_distribut')}}
