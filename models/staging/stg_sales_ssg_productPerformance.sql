SELECT * FROM {{source('sales_ssg_productPerformance','sales_ssg_product_performance')}}

-- month >> DATE 형식으로 CAST 필요
-- product_id >> STRING 형식으로 CAST 필요