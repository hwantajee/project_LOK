SELECT * FROM {{source('sales_ssg_memberPerformance','sales_ssg_member_performance')}}

-- month >> DATE 형식으로 CAST 필요
-- product_id >> STRING 형식으로 CAST 필요