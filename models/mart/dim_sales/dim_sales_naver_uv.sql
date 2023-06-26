SELECT
    brand_abbr,
    month,
    uv_mobile,
    uv_pc,
    uv_total
FROM {{ref('stg_sales_naver_uv')}}
