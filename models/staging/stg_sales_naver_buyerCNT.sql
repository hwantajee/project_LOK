SELECT

    month,
    -- Sell-out의 derived_mall_name과 일치를 작업 수행 후 channel 컬럼 생성
    'Naver' as channel,
    -- sales 도메인 영역에서 브랜드 축약어로 값을 통일 >>brand_abbr 컬럼명으로 변경
    ifnull(brand,"-") as brand,
    -- 기존 고객을 retuen customer로 표기
    return_customer,
    return_customer_ratio,
    new_customer,
    new_customer_ratio,
    buyer,
    -- eJBP 대시보드에서 사용x 회원 주문수(같은달에 두번 주문 = 한번 주문으로 계산하여 표시중) >> order_unique로 표기
    buyer_unique, 
    store_like_accumulate,
    store_like_increase, 
    all_refund_cnt

FROM {{source('sales_naver_buyerCNT','sales_naver_buyer_cnt')}}