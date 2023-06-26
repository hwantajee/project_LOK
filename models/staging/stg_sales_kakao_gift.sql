
SELECT * FROM {{source('sales_kakao_gift','sales_kakao_gift')}}

    -- account = Online Channel (Kakao)
    -- month = YYYY-MM --> YYYY-MM-DD로 형식 변환 필요
    -- brand = brand_abbr