-- SOV내에 브랜드 축약어 변환을 위한 brand_full 형태의 변환 작업 수행

SELECT
DISTINCT
     CASE WHEN brand = 'Giorgio Armani' THEN 'Giorgio Armani Beauty'
        WHEN brand = 'La Roche Posay' THEN 'La Roche-Posay'
        WHEN brand = 'Maybelline' THEN 'Maybelline NY'
        ELSE brand     
        END brand_full,
    brand    

FROM {{ref('stg_media_nielsen_sov')}}
