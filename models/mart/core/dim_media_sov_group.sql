WITH
SOV_ORIGIN AS (
 
    SELECT

        *,
        CAST(SUBSTR(year_month,1,4) AS int) AS year,
        CAST(SUBSTR(year_month,6,2) AS int) AS month,
        CAST(SUBSTR(year_month,1,4) AS int) -1 AS pre_year

    FROM {{ref('dim_media_sov')}}

),

SOV_GROUP AS (
  
    SELECT  
                    
        brand_abbr,
        year,
        month,
        SOV

    FROM SOV_ORIGIN    
),

SOV_FIXED_GROUP_COMPLETE AS (

    SELECT 

    brand_abbr,
    year,
    month,
    CONCAT(year,'-',month) AS year_month,
    sum(SOV) as SOV

    FROM SOV_GROUP
    GROUP BY brand_abbr,year,month

),


LOK AS (

    SELECT
    DISTINCT 
        LOK,
        brand_abbr
    FROM SOV_ORIGIN    
)

SELECT
    
    S.year_month,
    S.brand_abbr,
    S.SOV,
    L.LOK

FROM SOV_FIXED_GROUP_COMPLETE S
LEFT JOIN LOK L
ON S.brand_abbr = L.brand_abbr    