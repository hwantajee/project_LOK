{{config(
    materialized="table"
)}}

WITH 
    BRAND as ( 
       
        SELECT
            
         keyword_group,
         -- 기존의 bnand mapping table의 signature_label 형식의 브랜드 명 통일을 위한 일부 브랜드 명 변경 >> keyword_group_M
         CASE WHEN keyword_group = 'YSL' THEN 'Yves Saint Laurent'
            WHEN keyword_group = 'Maybelline' THEN 'Maybelline NY'
            WHEN keyword_group =  'KERA' THEN 'Kerastase'
            WHEN keyword_group = "L'Oreal Professionnel Paris" THEN "L'Oreal Professionnel"
            WHEN keyword_group = "Armani" THEN "Giorgio Armani Beauty"	
            ELSE keyword_group 
            END keyword_group_M         
              
        FROM {{ref('stg_influencer_traackr_performance')}} 
    )

SELECT
    DISTINCT
    keyword_group,
    keyword_group_M,
    CASE WHEN keyword_group_M = 'Yves Saint Laurent' THEN 'Y'
        WHEN keyword_group_M = "Kiehl's" THEN 'Y'
        WHEN keyword_group_M = 'Biotherm' THEN 'Y'
        WHEN keyword_group_M = 'Lancome' THEN 'Y'
        WHEN keyword_group_M = 'Giorgio Armani Beauty' THEN 'Y'
        WHEN keyword_group_M = 'Urban Decay' THEN 'Y'
        WHEN keyword_group_M = 'Atelier Cologne' THEN 'Y'
        WHEN keyword_group_M = 'Helena Rubinstein' THEN 'Y'
        WHEN keyword_group_M = 'Valentino' THEN 'Y'
        WHEN keyword_group_M = "L'Oreal Paris" THEN 'Y'
        WHEN keyword_group_M = 'Maybelline NY' THEN 'Y'
        WHEN keyword_group_M = '3CE' THEN 'Y'
        WHEN keyword_group_M = 'La Roche-Posay' THEN 'Y'
        WHEN keyword_group_M = 'Skinceuticals' THEN 'Y'
        WHEN keyword_group_M = 'Kerastase' THEN 'Y'
        WHEN keyword_group_M = "L'Oreal Professionnel" THEN 'Y'
        ELSE 'N'
        END LOK
    FROM BRAND    