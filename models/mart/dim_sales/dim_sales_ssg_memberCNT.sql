SELECT
    'Shinsegae Mall' AS channel,
    month,
    CASE WHEN brand = 'BIO_2' THEN 'BIO'
    ELSE brand
    END brand_abbr,
    member_cnt AS buyer
FROM {{ref('stg_sales_ssg_memberCNT')}}