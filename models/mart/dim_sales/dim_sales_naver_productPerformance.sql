SELECT
    date,
    -- Sell-out의 derived_mall_name과 일치를 작업 수행 후 channel 컬럼 생성
    'Naver' AS channel,
    -- 향후 monthly 대시보드 사용 시 이용될 year_month 컬럼 생성             
    SUBSTR(CAST(date AS string),1,7) AS year_month,
    brand_abbr,
    -- product_id,
    -- eJBP 제품 코드는 rpc_code로 명칭 통일
    IFNULL(cast(rpc_code AS string),'-') AS rpc_code,
    IFNULL(product_category_1, '-') AS product_category_1,       
    IFNULL(product_category_2, '-') AS product_category_2,       
    IFNULL(product_category_3, '-') AS product_category_3,       
    IFNULL(product_category_4, '-') AS product_category_4,
    IFNULL(product_name,'-') AS product_name,
    IFNULL(hero, '-') AS hero,
    pv,
    cr_pv,
    --일 단위 세일즈
    sales, 
    --일 단위 결제수량
    unit 
FROM {{ref('stg_sales_naver_productPerformance')}}
