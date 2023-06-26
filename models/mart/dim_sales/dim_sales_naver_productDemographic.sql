SELECT
    month,
    -- Sell-out의 derived_mall_name과 일치를 작업 수행 후 channel 컬럼 생성
    'Naver' as channel,
    -- sales 도메인 영역에서 브랜드 축약어로 값을 통일 >>brand 컬럼명으로 변경
    ifnull(brand, '-') as brand_abbr,
    ifnull(cast(rpc_code as string), '-') as rpc_code,
    ifnull(product_name, '-') product_name,  
    ifnull(sex, '-') as sex,
    ifnull(age, '-') as age,
    --naver 에서 order는 주문수가 아닌 결제수를 의미
    `order`, 
    --naver 에서 unit은 주문 수량이 아닌 결제 수량을 의미
    unit, 
    refund_amt,
    refund_cnt,
    refund_unit_cnt,
    sales
FROM {{ref('stg_sales_naver_productDemographic')}}
