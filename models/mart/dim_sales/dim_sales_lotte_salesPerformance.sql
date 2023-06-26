SELECT
    -- 셀아웃 채널 명칭과 동일 하게 표기 
    'Lotte ON' AS channel,
    month,
    -- brand 축약어를 의미
    IFNULL(brand,'-') as brand_abbr,
    -- 실제 RPC code를이용 했을 때 통일하여 이용하기 위한 명칭 변경
    LTRIM(product_code, 'LE') AS rpc_code,
    ifnull(product_name,'-') as product_name,
    pv,
    buyer_cnt AS buyer,
    cr_buy,
    sales, 
    unit
FROM {{ref('stg_sales_lotte_salesPerformance')}}
