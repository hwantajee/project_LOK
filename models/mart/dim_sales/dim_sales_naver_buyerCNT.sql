SELECT
    
    month,
    channel,
    brand AS brand_abbr,
    return_customer,
    return_customer_ratio,
    new_customer,
    new_customer_ratio,
    -- 전체 주문 고객을 order_uv 에서 >> order_customer으로 표기 
    --order_uv, 
    buyer,
    -- eJBP 대시보드에서 사용x 회원 주문수(같은달에 두번 주문 = 한번 주문으로 계산하여 표시중) >> order_unique로 표기
    buyer_unique, 
    store_like_accumulate,
    store_like_increase, 
    all_refund_cnt

FROM {{ref('stg_sales_naver_buyerCNT')}}
