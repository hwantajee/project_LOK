SELECT 

brand				
,brand_code				
,brand_tr				
,channel_category				
,channel_mode				
,channel_mode_tr			
,channel_name				
,channel_sub_category				
,counter_code				
,counter_distribution				
,mapping				
,mars_code				
,name				
,sold_to_sap_code 			
,store_code_brand_channel_mode_channel_category_channel_group				
,sub_channel


FROM {{ref('stg_mars_counterCode_LD_specification')}}