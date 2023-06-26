WITH
MEMBER AS (
    
    SELECT
        
        DISTINCT
        
        brand_kr AS brand_kr_ssg

    FROM {{ref('stg_sales_ssg_memberPerformance')}}
),

PRODUCT AS (

    SELECT

        DISTINCT
        
        brand_kr AS brand_kr_ssg

    FROM {{ref('stg_sales_ssg_productPerformance')}}    
),

UV_PV AS (

    SELECT

        DISTINCT
        
        supplier AS brand_kr_ssg

    FROM {{ref('stg_sales_ssg_uv_pv')}}    
),
SSG AS (
    SELECT
    
        brand_kr_ssg
    
    FROM MEMBER

    UNION ALL

    SELECT

        brand_kr_ssg
    
    FROM PRODUCT

    UNION ALL

    SELECT

        brand_kr_ssg

    FROM UV_PV        
)
    SELECT

        DISTINCT
        brand_kr_ssg,
        CASE WHEN brand_kr_ssg = '비오템옴므' THEN '비오템'
            WHEN brand_kr_ssg = '아틀리에코롱' THEN '아틀리에 코롱'
            WHEN brand_kr_ssg = '로레알파리헤어' THEN '로레알 파리'
            WHEN brand_kr_ssg = '[시코르]케라스타즈' THEN '케라스타즈'
            WHEN brand_kr_ssg = '조르지오아르마니' THEN '아르마니'
            WHEN brand_kr_ssg = '엘오케이(유)' THEN '로레알코리아'
            WHEN brand_kr_ssg = '[시코르]어반디케이' THEN '어반디케이'
            WHEN brand_kr_ssg = '조르지오아르마니 뷰티' THEN '아르마니'
            WHEN brand_kr_ssg = 'YSL' THEN '입생로랑'
            WHEN brand_kr_ssg = '헬레나루빈스타인' THEN '헬레나 루빈스타인'
            WHEN brand_kr_ssg = '입생로랑 (YSL)' THEN '입생로랑'
        ELSE brand_kr_ssg
        END brand_kr

        FROM SSG