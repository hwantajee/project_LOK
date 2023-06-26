WITH

-- year 컬럼 데이터 변환 작업 수행
ORIGIN AS (
    SELECT
    
    channel,
    CASE WHEN year LIKE '%YTD%' THEN replace(year,' YTD ','-')
        WHEN year NOT IN ('YTD') THEN CONCAT(year,'-','4Q')
        ELSE year
        END year_m,

    value

    FROM {{ref('stg_cmi_market')}}
),

-- fixed_key 값 생성을 위한 경우의 수 컬럼 생성 
ORIGIN_M AS (
    SELECT
    
    channel,
    CAST(SUBSTR(year_m,1,4) AS INT) AS year,
    CAST(SUBSTR(year_m,1,4) AS INT) -1 AS pre_year,
    SUBSTR(year_m,6,2) AS quarter,
    value

    FROM ORIGIN
),
--DISTINCT CHANNEL 컬럼 생성
FIXED_CHANNEL AS (
    SELECT
    DISTINCT

        channel,

    FROM ORIGIN_M
),
-- DISTINCT year,qurter 컬럼 생성
FIXED_YEAR_QUARTER AS (
    SELECT
    DISTINCT

    year,
    pre_year,
    quarter

    FROM ORIGIN_M
),
-- CROSS JOIN을 통한 fixed_key 경우의 수 생성
CROSS_YEAR_QUARTER_CHANNEL AS (
    SELECT
    DISTINCT
    * 
    FROM FIXED_CHANNEL
    CROSS JOIN FIXED_YEAR_QUARTER
),
-- fixed_key 값 생성
FIXED_GROUP AS (
    SELECT
    
    CONCAT(channel,'_',year,'_',quarter) AS fixed_key,
    CONCAT(channel,'_',pre_year,'_',quarter) AS fixed_prev_key
    
    FROM CROSS_YEAR_QUARTER_CHANNEL
),
-- 원본 key 값 생성
ORIGIN_GROUP AS (
    SELECT

    value,
    CONCAT(channel,'_',year,'_',quarter) AS key,
    CONCAT(channel,'_',pre_year,'_',quarter) AS prev_key,

    FROM ORIGIN_M  
),

--fixed_key 값,key 값 기준으로 left join 수행
FIXED_GROUP_JOIN AS (

    SELECT
    F.fixed_key,
    F.fixed_prev_key,
    O.key,
    O.prev_key,
    O.value
    FROM FIXED_GROUP F
    LEFT JOIN ORIGIN_GROUP O 
    ON F.fixed_key = O.key
),

--집계함수 추출
FIXED_GORUP_COMPLETE AS (
    
    SELECT
    
    fixed_key,
    fixed_prev_key,
    SUM(value) AS value

    FROM FIXED_GROUP_JOIN
    GROUP BY fixed_key, fixed_prev_key
)


    SELECT 
        
        key.fixed_key,
        key.fixed_prev_key,
        REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,1) AS channel,
        REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,2) AS year,
        REGEXP_SUBSTR(key.fixed_key, '[^_]+',1,3) AS quarter,
        key.value AS value,
        prev.value AS prev_value
        
    FROM FIXED_GORUP_COMPLETE key
    LEFT JOIN FIXED_GORUP_COMPLETE prev
    ON key.fixed_prev_key = prev.fixed_key 
