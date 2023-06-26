WITH
SPR AS (
    SELECT
        -- CASE WHEN date = '*Date는 수작업으로 넣어야 할 수 있음' THEN NULL
        -- ELSE DATE
        -- END date,
        date,
        brand_case,    
        reply_rate,
        replied,
        conversations

    FROM {{ref('dim_social_springklr_div_brand_distribut')}}

),

BRAND AS (
    SELECT
    brand_case,
    brand
FROM {{ref('dim_SOIN_springklr_LOK_brand')}}
),

LOK_SPR AS (
SELECT
    S.date,
    S.reply_rate,
    S.conversations,
    S.replied,
    S.brand_case,
    B.brand
FROM SPR S 
LEFT JOIN BRAND B    
ON S.brand_case = B.brand_case
),

MAPPING AS (
    SELECT
        division,
        brand_abbr,
        signature_label
    FROM {{ref('stg_brand_mapping_temp')}}    
)

    SELECT 

    S.date,
    M.division,
    --S.brand_case,
    --S.brand,
    M.brand_abbr AS brand,
    S.reply_rate,
    S.replied,
    S.conversations

    FROM LOK_SPR S
    LEFT JOIN MAPPING M
    ON S.brand = M.signature_label
    WHERE date IS NOT NULL