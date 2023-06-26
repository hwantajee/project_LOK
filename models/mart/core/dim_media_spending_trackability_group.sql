{{config(
    materialized="table"
)}}

-- brand 맵핑을 위한 media spending 테이블 구성, L'Oreal Professionnel 표기법을 기존 맵핑 테이블의 brandfull과 맞추어 변경
with 
MEDIA as (

    SELECT 
    
        *

    FROM {{ref('dim_media_mezzo_spending')}}                  
    
),

-- brand 맵핑 테이블 생성
MAPPING as (
    SELECT
        
        brand_abbr,
        signature_label
    

    FROM {{ref('dim_mapping_brand')}}                  

),
-- 브랜드 축약어 맵핑을 위한 맵핑 테이블과 미디어 테이블 조인
MEDIA_MAPPING AS (
    SELECT 
        
        
        A.year,
        A.t_standard AS trackability,
        A.year_month,
        A.landing_page,
        A.channel_name,
        A.sales_channel,
        B.brand_abbr AS brand, 
        A.revenue_t,
        A.impression,
        A.click,
        A.conversion_t,
        A.view,
        A.budget_net

    FROM MEDIA A
    LEFT JOIN MAPPING B
    ON A.brand = B.signature_label 
),

-- MEDIA_TR AS (

--     SELECT
--     year_month,
--     CONCAT(CAST (LEFT(year_month, 4) AS INT64) +1,RIGHT(year_month,3)) AS prev_year_month, 
--     landing_page,
--     sales_channel,
--     channel_name,
--     trackability,
--     brand AS brand_abbr,
--     SUM(revenue_t) AS revenue_t,
--     SUM(impression) AS impression,
--     SUM(click) AS click,
--     SUM(conversion_t) AS conversion_t,
--     SUM(view) AS view,
--     SUM(budget_net) AS budget_net

-- FROM MEDIA_MAPPING    
-- GROUP BY year_month,landing_page,sales_channel,channel_name,trackability,brand
--)


--이전 연도 year 와  fixed key 값 생성을 위한 전처리 과정 
YEAR_MONTH AS (
    SELECT

        CAST(SUBSTR(year_month,1,4) AS int) AS year,
        CAST(SUBSTR(year_month,6,2) AS int) AS month,
        CAST(SUBSTR(year_month,1,4) AS int) -1 AS pre_year
    
    FROM MEDIA_MAPPING    

),
--이전년도 같은 월 값 생성 후 DISTINCT 값 수행 
FIXED_YEAR_MONTH AS (

    SELECT
    DISTINCT

        CONCAT (year,'_',month) AS year_month,
        CONCAT (pre_year,'_',month) AS Pre_year_month
        
        
    FROM YEAR_MONTH
),
--brand 칼럼 값만 추출 후 distinct 함수 수행
FIXED_BRAND AS (

    SELECT

    DISTINCT brand

    FROM MEDIA_MAPPING
),
--trackability 칼럼 값만 추출 후 distinct 함수 수행
FIXED_TRACKABILITY AS (
    
    SELECT

    DISTINCT trackability

    FROM MEDIA_MAPPING
),

FIXED_LANDING_PAGE AS (
    
    SELECT

    DISTINCT landing_page

    FROM MEDIA_MAPPING
),

--Fixed key 값 생성을 위한 year_month ,brand테이블 간 CROSS JOIN 수행
CROSS_YEAR_BRAND AS (
    SELECT

    DISTINCT    
    
    * 

    FROM FIXED_YEAR_MONTH
    CROSS JOIN FIXED_BRAND
),

--trackability 컬럼 
CROSS_YEAR_BRAND_TRACKABILITY AS (
    
    SELECT

    DISTINCT    
    
    * 

    FROM CROSS_YEAR_BRAND
    CROSS JOIN FIXED_TRACKABILITY
),

CROSS_YEAR_BRAND_TRACKABILITY_LANDING_PAGE AS (
    
    SELECT

    DISTINCT    
    
    * 

    FROM CROSS_YEAR_BRAND_TRACKABILITY
    CROSS JOIN FIXED_LANDING_PAGE
),

--Fixed key 값 생성
MEDIA_FIXED_GROUP AS (

    SELECT

    CONCAT(brand,'_',landing_page,'_',trackability,'_',year_month) as fixed_key,
    CONCAT(brand,'_',landing_page,'_',trackability,'_',pre_year_month) as fixed_prev_key

    FROM CROSS_YEAR_BRAND_TRACKABILITY_LANDING_PAGE
),
--원본 데이터 생성
MEDIA_ORIGIN AS (
   
    SELECT
  
        CAST(SUBSTR(CAST(year_month AS string),1,4) AS int) AS year,
        CAST(SUBSTR(CAST(year_month AS string),6,2) AS int) month,
        CAST(SUBSTR(CAST(year_month AS string),1,4) AS int) -1 AS pre_year,
        trackability,
        landing_page,        
        IFNULL(brand,'-') AS brand,
        IFNULL(revenue_t,0) AS revenue_t,
        IFNULL(impression,0) AS impression,
        IFNULL(budget_net,0) AS budget_net,        
        IFNULL(view,0) AS view,
        IFNULL(click,0) AS click,        
        IFNULL(conversion_t,0) AS conversion_t,

    FROM MEDIA_MAPPING   
),
--MEDIA 데이터 원본 key 값 생성

MEDIA_GROUP AS (
  
    SELECT  
        
        CONCAT(brand,'_',landing_page,'_',trackability,'_',year,'_',month) AS key,
        CONCAT(brand,'_',landing_page,'_',trackability,'_',pre_year,'_',month) AS prev_key,      
        impression,
        view,
        click,
        conversion_t,
        revenue_t,
        budget_net

    FROM MEDIA_ORIGIN
),
--fixed_key 와 key 값의 LEFT JOIN 수행
MEDIA_GROUP_COMPLETE AS (
    
    SELECT 

        FIXED.fixed_key,
        FIXED.fixed_prev_key,
        MEDIA.key,
        MEDIA.prev_key,
        MEDIA.view,
        MEDIA.impression,
        MEDIA.click,
        MEDIA.conversion_t,
        MEDIA.revenue_t,
        MEDIA.budget_net

    FROM MEDIA_FIXED_GROUP AS FIXED
    LEFT JOIN MEDIA_GROUP AS MEDIA
    ON FIXED.fixed_key = MEDIA.key    
),

--fixed_prev_key 값과 fixed_key 값, trackability 기준으로 view, impression, click, conversion_t, revenue_y, budget_net 
--집계 시행 key 값의 unique 화--

--집계함수를 통한 key 값 unique화 수행
MEDIA_FIXED_GROUP_COMPLETE AS (
    
    SELECT

        fixed_key,
        fixed_prev_key,
        SUM(impression) AS impression,
        SUM(view) AS view,
        SUM(click) AS click,
        SUM(conversion_t) AS conversion_t,
        SUM(revenue_t) AS revenue_t,
        SUM(budget_net) AS budget_net

    FROM MEDIA_GROUP_COMPLETE
    GROUP BY fixed_prev_key, fixed_key
),
-- 현재 년도 집계 값, 이전 연도 집계 값 생성을 위한 LEFT JOIN 수행
EVOL AS (
    SELECT

        key.fixed_key,
        key.fixed_prev_key,
        REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,1) AS brand,
        REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,2) AS landing_page,
        CONCAT(REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,4),'-',REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,5)) AS year_month,         
        REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,3) AS trackability,
        key.view,
        key.click,
        key.impression,
        key.conversion_t,
        key.revenue_t,
        key.budget_net,         
        prev.view AS prev_view,
        prev.click AS prev_click,
        prev.impression AS prev_impression,
        prev.conversion_t AS prev_conversion_t,
        prev.revenue_t AS prev_revenue_t,
        prev.budget_net AS prev_budget_net

    FROM MEDIA_FIXED_GROUP_COMPLETE AS key
    LEFT JOIN MEDIA_FIXED_GROUP_COMPLETE AS prev
    ON key.fixed_prev_key = prev.fixed_key 
),
-- landing page 와 세일즈 채널 간 맵핑 진행

SALES_CHANNEL AS (
    SELECT

        landing_page,
        channel_name,
        sales_channel

    FROM MEDIA
)

SELECT 

    DISTINCT
    E.fixed_key,
    E.fixed_prev_key,
    E.brand AS brand_abbr,
    E.trackability,
    E.landing_page,
    S.sales_channel,
    S.channel_name,
    E.year_month,
    E.view,
    E.click,
    E.impression,
    E.conversion_t,
    E.revenue_t,
    E.budget_net,
    E.prev_revenue_t,
    E.prev_budget_net,


FROM EVOL E
LEFT JOIN SALES_CHANNEL S
ON E.landing_page = S.landing_page    


  