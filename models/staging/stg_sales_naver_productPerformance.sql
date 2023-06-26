--제품 별 성과
   select 

   brand_abbr						
   ,cr_pv					
   ,date						
   ,hero						
   ,product_category_1						
   ,product_category_2						
   ,product_category_3						
   ,product_category_4						
   ,product_id AS rpc_code					
   ,product_name					
   ,pv						
   ,sales				
   ,unit						
   ,brand_day
   
   
   from {{source('sales_naver_productPerformance','sales_naver_product_performance')}}

     