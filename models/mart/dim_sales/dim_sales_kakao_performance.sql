SELECT
    account AS channel,
    -- year_month 칼럼을 의미함
    month,
    brand AS brand_abbr,
    brand_kr,
    clicks,
    buyer,
    `order`,
    sales,
    uv
FROM {{ref('stg_sales_kakao_performance')}}
