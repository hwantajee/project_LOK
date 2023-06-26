SELECT 
DISTINCT

product_category,
    CASE product_category WHEN 'face care' THEN 'Skin care'
        WHEN 'Face care' THEN 'Skin care'
        WHEN 'Face Care' THEN 'Skin care'
        WHEN 'Body Care' THEN 'Skin care'
        WHEN 'Hair Care' THEN 'Hair care'
        WHEN 'Hair Color' THEN 'Hair color'
        WHEN 'Men Skin Care' THEN 'Skin care'
        WHEN 'MAKEUP' THEN 'Make up'
        WHEN 'MakeUp' THEN 'Make up'
        ELSE product_category
        END H2_category,

FROM {{source('media_spending','media_mezzo_spending')}}