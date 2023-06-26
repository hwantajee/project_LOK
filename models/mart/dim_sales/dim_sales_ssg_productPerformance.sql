WITH
SSG_PRODUCT AS (

SELECT
    brand_id,
    brand_kr,
    buyer_cnt,
    cr_buyer,
    cr_order,
    month,
    `order`,
    product_category_1,
    product_category_2,
    product_category_3,
    product_category_4,
    product_id AS rpc_code,
    product_name,
    pv,
    sales,
    sales_free_tax,
    supplier,
    supplier_id,
    unit,
    uv
FROM {{ref('stg_sales_ssg_productPerformance')}}
),

SSG_brand AS (
    SELECT

    brand_kr_ssg,
    brand_kr

    FROM {{ref('dim_mapping_brand_kr_ssg')}}
),

SSG_BRAND_KR AS (
    SELECT
        S.brand_id,
        M.brand_kr,
        S.buyer_cnt,
        S.cr_buyer,
        S.cr_order,
        S.month,
        S.`order`,
        S.product_category_1,
        S.product_category_2,
        S.product_category_3,
        S.product_category_4,
        S.rpc_code,
        S.product_name,
        S.pv,
        S.sales,
        S.sales_free_tax,
        S.supplier,
        S.supplier_id,
        S.unit,
        S.uv
    FROM SSG_PRODUCT S 
    LEFT JOIN SSG_brand M
    ON S.brand_kr = M.brand_kr_ssg 
),

BRAND_MAPPING AS (
    SELECT
    brand_kr,
    brand_abbr 
    FROM {{ref('dim_mapping_brand')}}
)

 SELECT
        S.brand_id,
        S.brand_kr,
        IFNULL(B.brand_abbr,'-') AS brand_abbr,
        S.buyer_cnt,
        S.cr_buyer,
        S.cr_order,
        S.month,
        S.`order`,
        S.product_category_1,
        S.product_category_2,
        S.product_category_3,
        S.product_category_4,
        S.rpc_code,
        S.product_name,
        S.pv,
        S.sales,
        S.sales_free_tax,
        S.supplier,
        S.supplier_id,
        S.unit,
        S.uv
        FROM SSG_BRAND_KR S
        LEFT JOIN BRAND_MAPPING B
        ON S.brand_kr = B.brand_kr

