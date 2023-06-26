{{config(
    materialized="table"
)}}

WITH 
BRAND as ( 
    -- 브랜드 맵핑 테이블과 통일 및 LOK 여부를 판단하기 위한 테이블 생성    
    SELECT
                       
    keyword_group,
    keyword_group_M,
    LOK

    FROM {{ref('dim_SOIN_traackr_LOK_brand')}} 
    ),

ADVOCACY_PRE AS (

    SELECT
    date,
    keyword_group,
    engagements


    FROM {{ref('dim_influencer_traackr_performance')}}
),
    
INFLUENCER AS (
    SELECT 

        B.keyword_group_M AS brand_full,
        B.LOK,
        A.date,
        A.engagements

    FROM ADVOCACY_PRE A
    LEFT JOIN BRAND B
    ON A.keyword_group = B.keyword_group
),

-- 브랜드 맵핑 테이블 생성 

MAPPING AS (
    
    SELECT
    
        division,
        brand_abbr,
        signature_label
        
    
    FROM {{ref('stg_brand_mapping_temp')}}    
),

-- LOK 브랜드 풀네임 명에 대한 브랜드 축약어 칼럼 생성 
ADVOCACY AS (
    SELECT

        I.date,
        I.brand_full,
        IFNULL(M.brand_abbr,'') AS brand,
        I.LOK,  
        I.engagements,
        IFNULL(M.division,'-') as division

    FROM INFLUENCER I    
    LEFT JOIN MAPPING M
    ON I.brand_full = M.signature_label
)
-- 경쟁사 브랜드 일 시 축약어 형태가 아닌 full name 명
SELECT

    date,
    brand_full,
    division,
    CASE WHEN brand = '' THEN CONCAT(brand_full,brand)
    ELSE brand
    END brand,
    LOK,
    engagements
    
FROM ADVOCACY    