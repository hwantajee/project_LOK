SELECT * FROM {{source('sales_naver_salesPerformance','sales_naver_sales_performance')}}
    
    -- order = daily 결제건 수
    -- unit_buy = daily 결제 수량
    -- sales = daily 세일즈