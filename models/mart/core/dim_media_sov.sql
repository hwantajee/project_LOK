WITH
MAPPING AS (

SELECT
    
    brand,
    brand_full

FROM {{ref('dim_mapping_brand_full_media_sov')}}

),

-- brand mapping 테이블의 signature label 과 명칭을 통일하기 위한 brand_full 컬럼 생성
SOV AS (

SELECT

    S.year,
    S.month,
    S.media_total_7 AS SOV,
    S.brand,
    M.brand_full

FROM {{ref('stg_media_nielsen_sov')}} S
LEFT JOIN MAPPING M 
ON S.brand = M.brand
),
--brand_abbr 형식의 변환을 위한 맵핑 테이블 생성
BRAND_MAPPING AS (
    SELECT

        signature_label,
        brand_abbr
    
    FROM {{ref('dim_mapping_brand')}} 
),    
-- brand_abbr변환을 위한 LEFT JOIN 수행 및 LOK 브랜드와 경쟁사 브랜드 구분을 위한 컬럼 생성
SOV_M AS (
    SELECT 
 
        S.year,
        S.year -1 AS pre_year,
        S.month,
        S.SOV,
        S.brand_full,
        IFNULL(B.brand_abbr,'') AS brand_abbr,
        CASE WHEN B.brand_abbr is null THEN 'N'
        ELSE 'Y'
        END LOK

    FROM SOV AS S
    LEFT JOIN BRAND_MAPPING AS B
    ON S.brand_full = B.signature_label
),    

-- 경쟁사 브랜드는 brand_abbr 컬럼에서 brand_full 값으로 대체 
SOV_B AS (
    
    SELECT

        CONCAT(year,'-',month) AS year_month,
        CASE WHEN brand_abbr = '' THEN CONCAT(brand_full,brand_abbr)
        ELSE brand_abbr
        END brand_abbr,
        LOK,
        SOV

    FROM SOV_M
)

SELECT * FROM SOV_B