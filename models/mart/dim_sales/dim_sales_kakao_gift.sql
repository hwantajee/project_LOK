SELECT 
    account as channel,
    -- year_month 칼럼을 의미함
    month,
    brand AS brand_abbr,
    brand_kr,
    gift_for_oneself,
    gift_for_others
FROM {{ref('stg_sales_kakao_gift')}}
