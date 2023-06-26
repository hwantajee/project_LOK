SELECT * FROM {{source('sales_ssg_uv_pv','sales_ssg_uv_pv')}}

-- month >> DATE 형식으로 CAST 필요
-- product_id >> STRING 형식으로 CAST 필요