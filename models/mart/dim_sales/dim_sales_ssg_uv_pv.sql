WITH
SSG_UV AS (
SELECT
    channel_type,
    month,
    product_id AS rpc_code,
    product_name,
    pv,
    supplier,
    supplier_id,
    uv
FROM {{ref('stg_sales_ssg_uv_pv')}}
),

SSG_brand AS (
    SELECT

    brand_kr_ssg,
    brand_kr

    FROM {{ref('dim_mapping_brand_kr_ssg')}}
),

SSG_UV_KR AS (
    SELECT

        U.channel_type,
        U.month,
        U.rpc_code,
        U.product_name,
        U.pv,
        U.supplier,
        M.brand_kr,
        U.supplier_id,
        U.uv
    
    FROM SSG_UV U
    LEFT JOIN SSG_brand M
    ON U.supplier = M.brand_kr_ssg
),

BRAND_MAPPING AS (
    SELECT
    brand_kr,
    brand_abbr 
    FROM {{ref('dim_mapping_brand')}}
)

SELECT

    U.channel_type,
    U.month,
    U.rpc_code,
    U.product_name,
    U.pv,
    U.supplier,
    U.brand_kr,
    B.brand_abbr,
    U.supplier_id,
    U.uv

FROM SSG_UV_KR U
LEFT JOIN BRAND_MAPPING B
ON U.brand_kr = B.brand_kr

