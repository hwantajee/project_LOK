SELECT * FROM {{source('sales_kakao_cvr','sales_kakao_cvr')}}

    -- account = Online Channel (Kakao)
    -- month = YYYY-MM --> YYYY-MM-DD로 형식 변환 필요
    -- brand = brand_abbr
    -- buy_category = 채널 내 구매 위치 
    -- cr_buy = 구매 전환비율을 의미