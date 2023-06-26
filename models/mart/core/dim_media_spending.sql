WITH
MEDIA AS (    
    
    SELECT
        year,
        t_standard,
        year_month,
        end_date,
        start_date,
        division,
        brand,
        product_category,
        H2_category,
        campaign,
        vehicle,
        landing_page,
        sales_channel,
        objectives,
        type,
        impression,
        click,
        conversion_t,
        view,
        revenue_t,
        budget_net
    FROM {{ref('dim_media_mezzo_spending')}}
),
-- 미디어 데이터 기준 브랜드 축약어 조인을 위한 브랜드 맵핑 테이블 생성 
MAPPING as (

    SELECT
        
        brand_abbr,
        division,
        signature_label
    

    FROM {{ref('dim_mapping_brand')}}                  

),
-- 브랜드 축약어 생성 후 대시보드에 올릴 미디어 원본 데이터 생성
MEDIA_MAPPING AS (

    SELECT 
                
        A.year,
        A.year_month,
        A.t_standard,
        A.start_date,
        A.end_date,
        A.product_category,
        A.H2_category,
        A.campaign,
        A.vehicle,
        A.landing_page,
        A.sales_channel,
        A.objectives,
        A.type,
        B.division,
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
)

    SELECT * FROM MEDIA_MAPPING

   