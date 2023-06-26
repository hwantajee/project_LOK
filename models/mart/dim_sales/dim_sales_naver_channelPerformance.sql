SELECT

month
,'Naver' as channel
,ifnull(brand_abbr,'-') as brand_abbr
,ifnull(brand_day, '-') as brand_day
,ifnull(channel_name, '-') as channel_name
,ifnull(channel_type, '-') as channel_type
,ifnull(channel_attribute, '-') as channel_attribute
,ifnull(channel_detailed, '-') as channel_detailed										
,order_14_days					
,sales_per_visit_last_click				
,order_last_click					
,order_per_visit_14_days					
,order_per_visit_last_click				
,pv					
,roas_14_days					
,roas_last_click					
,sales_14_days				
,sales_last_click				
,sales_per_visit_14_days					
,uv				
,visit				
,visit_per_pv
,ad_spending	



FROM {{ref('stg_sales_naver_channelPerformance')}}

    