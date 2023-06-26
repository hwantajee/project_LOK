WITH
CHANNEL_MEDIA AS (        
        
        SELECT
        UPPER(landing_page) AS landing_page,
        'Online' AS channel_mode_code,       
        CASE WHEN landing_page LIKE '%Naver%' THEN 'Naver'
            WHEN landing_page LIKE '%kakao%' THEN 'Kakao'
            WHEN landing_page LIKE '%Kakao%' THEN 'Kakao'
            WHEN landing_page LIKE '%Ak%' THEN 'Ak Mall'
            WHEN landing_page LIKE '%SSG%' THEN 'Shinsegae Mall'
            WHEN landing_page LIKE '%ssg%' THEN 'Shinsegae Mall'
            WHEN landing_page LIKE '%AK%' THEN 'Ak Mall'
            WHEN landing_page LIKE '%E-boutique%' THEN 'E-Boutique'
            WHEN landing_page LIKE '%Coupang%' THEN 'Coupang'
            WHEN landing_page LIKE '%coupang%' THEN 'Coupang'
            WHEN landing_page LIKE '%Lotte%' THEN 'LOTTE ON'
            WHEN landing_page LIKE '%Olive%' THEN 'Oliveyoung'
            WHEN landing_page LIKE '%H Mall%' THEN 'H Mall'
            WHEN landing_page LIKE '%11st%' THEN '11St'
            WHEN landing_page LIKE '%Galleria%' THEN 'Galleria'
            ELSE '-'
            END sales_channel,
        UPPER(landing_category) AS landing_category       
            
    FROM {{ref('stg_channel_media')}}
),

CHANNEL_NAME_MEDIA AS (
        
        SELECT
        landing_page,
        sales_channel,
        CASE WHEN sales_channel = 'Naver' THEN 'E-Shop-in-Shop'
            WHEN sales_channel = 'Kakao' THEN 'E-Shop-in-Shop'
            WHEN sales_channel = 'Ak Mall' THEN 'DS Online'
            WHEN sales_channel = 'Shinsegae Mall' THEN 'DS Online'
            WHEN sales_channel = 'E-Boutique' THEN 'E-Boutique'
            WHEN sales_channel = 'Coupang' THEN 'Pure Player'
            WHEN sales_channel = 'LOTTE ON' THEN 'DS Online'
            WHEN sales_channel = 'Oliveyoung' THEN 'Opensell Online'
            WHEN sales_channel = 'H Mall' THEN 'DS Online'
            WHEN sales_channel = '11St' THEN 'Pure Player'
            WHEN sales_channel = 'Galleria' THEN 'DS Online'
            WHEN sales_channel = '-' THEN '-' 
            end channel_name,   
        landing_category
        FROM CHANNEL_MEDIA
)

SELECT 
DISTINCT
*

FROM CHANNEL_NAME_MEDIA
