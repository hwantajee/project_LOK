SELECT * FROM {{source('sales_kakao_performance','sales_kakao_performance')}}

    -- account = Online Channel (Kakao)
    -- month = YYYY-MM --> YYYY-MM-DD로 형식 변환 필요
    -- brand = brand_abbr
