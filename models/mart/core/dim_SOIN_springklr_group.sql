WITH
SPR AS (
    SELECT

        *,
        CAST(SUBSTR(CAST(date AS STRING),1,4) AS int) AS year,
        CAST(SUBSTR(CAST(date AS STRING),6,2) AS int) AS month,
        CAST(SUBSTR(CAST(date AS STRING),1,4) AS int) -1 AS pre_year

    FROM {{ref('dim_SOIN_springklr')}}

),

--원본 데이터 생성
SOCIAL_ORIGIN AS (
   
    SELECT
  
        year,
        month,
        brand,
        reply_rate/100 AS reply_rate,
        replied,
        conversations


    FROM SPR
),

SOCIAL_GROUP AS (
  
    SELECT  
        
        CONCAT(year,'-',month) AS year_month,      
        brand,
        AVG(reply_rate) AS reply_rate,
        SUM(replied) AS replied,
        SUM(conversations) AS conversations

    FROM SOCIAL_ORIGIN
    GROUP BY year_month, brand    
)

SELECT * FROM SOCIAL_GROUP
