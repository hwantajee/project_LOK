SELECT
    month,
    lok_ttl AS total_sales /*LOK 브랜드 별 total 값 */
FROM {{ref('stg_sales_kakao_total')}}
