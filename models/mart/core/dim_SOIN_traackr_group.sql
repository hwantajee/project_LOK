{{config(
    materialized="table"
)}}

WITH
-- Year Month 컬럼 생성
ADVOCACY AS (
    SELECT

        *,
        CAST(SUBSTR(CAST(date AS STRING),1,4) AS int) AS year,
        CAST(SUBSTR(CAST(date AS STRING),6,2) AS int) AS month,
        CAST(SUBSTR(CAST(date AS STRING),1,4) AS int) -1 AS pre_year

    FROM {{ref('dim_SOIN_traackr')}}

),


T_GROUP AS (   
    SELECT
  
        CONCAT(year,'-',month) AS year_month,
        brand,
        SUM(engagements) AS engagements


    FROM ADVOCACY
    GROUP BY year_month, brand
),

LOK AS (
    SELECT
    DISTINCT
    brand,
    LOK
    FROM {{ref('dim_SOIN_traackr')}}
)

    SELECT

        T.brand,
        T.year_month,
        L.LOK,
        T.engagements,
     
    FROM T_GROUP AS T
    LEFT JOIN LOK AS L
    ON T.brand = L.brand    
