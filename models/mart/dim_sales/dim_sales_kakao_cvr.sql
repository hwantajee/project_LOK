SELECT
    account as channel,
    -- year_month 칼럼을 의미함
    month,
    brand AS brand_abbr,
    brand_kr,
    buy_category,
    cr_buy
FROM {{ref('stg_sales_kakao_cvr')}}
