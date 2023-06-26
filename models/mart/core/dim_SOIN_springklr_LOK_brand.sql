WITH
SPR AS (
    SELECT
        -- CASE WHEN date = '*Date는 수작업으로 넣어야 할 수 있음' THEN NULL
        -- ELSE DATE
        -- END date,
        brand_case,
        -- sprinklr의 brand 칼럼이 signature 명과 full 명칭과 혼합되어 있어 like 문 함수를 이용하여, 칼럼명 변환 >> brand로 컬럼명 작성      
        case when brand_case = 'Lancôme' THEN 'Lancome'
            when brand_case like '%Shu%' THEN 'Shu Uemura' 
            when brand_case = 'Giorgio Armani' THEN 'Giorgio Armani Beauty'
            when brand_case = 'LaRoche Posay' THEN 'La Roche-Posay'
            when brand_case = 'SkinCeuticals' THEN 'Skinceuticals'
            when brand_case = 'Maybelline New York' THEN 'Maybelline NY'
            when brand_case = 'Valentino Beauty' THEN 'Valentino'
            when brand_case = "L'Oréal Paris" THEN "L'Oreal Paris"
            when brand_case = "L'Oréal" THEN "L'Oreal"
            when brand_case = "L'Oréal Professionnel" THEN "L'Oreal Professionnel"
            when brand_case = 'Kérastase' THEN 'Kerastase' 
        else brand_case 
        end brand

    FROM {{ref('dim_social_springklr_div_brand_distribut')}}

)

SELECT DISTINCT * FROM SPR