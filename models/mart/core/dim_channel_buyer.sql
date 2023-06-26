{{config(
    materialized="table"
)}}

 WITH

    Naver as (

    SELECT
        -- year-month 형태로 추출
        SUBSTR(CAST(month AS STRING),1,7) AS month,
        channel,
        brand_abbr, -- 축약어 형태 브랜드
        CAST(buyer AS INT) AS buyer

    FROM {{ref('dim_sales_naver_buyerCNT')}}
),

    Kakao as (

    SELECT
        --year-month 형태
        SUBSTR(CAST(month AS STRING),1,7) AS month,
        channel,
        brand_abbr,-- 축약어 형태 브랜드
        CAST(buyer as int) as buyer
        
    FROM {{ref('dim_sales_kakao_performance')}}
),

    SSG AS (

    SELECT
        SUBSTR(CAST(month AS STRING),1,7) AS month,
        channel,
        brand_abbr,
        CAST(buyer as int) as buyer
    FROM {{ref('dim_sales_ssg_memberCNT')}}       
    ),

-- 채널 별 구매자 수 집계 
BUYER_G AS (

    select
        *
    from Naver

    union all

    select 
        *
    from Kakao  

    union all

    select 
        *
    from SSG      
),
-- fixed_key 생성을 위한 값 생성
CHANNEL_BUYER AS (
    SELECT

        channel,
        brand_abbr,
        CAST(buyer as int) as buyer,
        CAST(SUBSTR(month,1,4) AS int) AS year,
        CAST(SUBSTR(month ,6,2) AS int) AS month,
        CAST(SUBSTR(month ,1,4) AS int) -1 AS pre_year

    FROM BUYER_G

)
   
    SELECT
  
        CONCAT(year,'-',month) AS year_month,
        --pre_year,
        channel,
        brand_abbr,
        SUM(buyer) AS buyer

    FROM CHANNEL_BUYER
    GROUP BY year_month, channel, brand_abbr
