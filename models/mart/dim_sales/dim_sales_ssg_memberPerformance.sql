WITH
MEMBER_PERFORMANCE AS (

SELECT
    age,
    brand_kr,
    buyer_cnt,
    buyer_cnt_first,
    buyer_cnt_once,
    buyer_cnt_orgin,
    buyer_cnt_reorder,
    buyer_cnt_third,
    buyer_cnt_twice,
    first_order_unit_price,
    month,
    once_order_unit_price,
    product_id AS rpc_code,
    product_name,
    reorder_unit_price,
    sex,
    third_order_unit_price,
    twice_order_unit_price
    
FROM {{ref('stg_sales_ssg_memberPerformance')}}

),

SSG_brand AS (
    SELECT

    brand_kr_ssg,
    brand_kr

    FROM {{ref('dim_mapping_brand_kr_ssg')}}
),

SSG_brand_kr AS (

SELECT

    M.age,
    S.brand_kr,
    M.buyer_cnt,
    M.buyer_cnt_first,
    M.buyer_cnt_once,
    M.buyer_cnt_orgin,
    M.buyer_cnt_reorder,
    M.buyer_cnt_third,
    M.buyer_cnt_twice,
    M.first_order_unit_price,
    M.month,
    M.once_order_unit_price,
    M.rpc_code,
    M.product_name,
    M.reorder_unit_price,
    M.sex,
    M.third_order_unit_price,
    M.twice_order_unit_price

FROM MEMBER_PERFORMANCE M
LEFT JOIN SSG_brand S 
ON M.brand_kr = S.brand_kr_ssg
),

BRAND_MAPPING AS (
    SELECT
    brand_kr,
    brand_abbr 
    FROM {{ref('dim_mapping_brand')}}
)

SELECT

    M.age,
    M.brand_kr,
    B.brand_abbr,
    M.buyer_cnt,
    M.buyer_cnt_first,
    M.buyer_cnt_once,
    M.buyer_cnt_orgin,
    M.buyer_cnt_reorder,
    M.buyer_cnt_third,
    M.buyer_cnt_twice,
    M.first_order_unit_price,
    M.month,
    M.once_order_unit_price,
    M.rpc_code,
    M.product_name,
    M.reorder_unit_price,
    M.sex,
    M.third_order_unit_price,
    M.twice_order_unit_price
FROM SSG_brand_kr M
LEFT JOIN BRAND_MAPPING B
ON M.brand_kr = B.brand_kr   
