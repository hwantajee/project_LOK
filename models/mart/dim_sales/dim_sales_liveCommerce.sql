SELECT

brand AS brand_abbr					
,category					
,cost_ads					
,cost_agency					
,cost_commission					
,cost_kol				
,cost_others					
,cost_total				
,cost_po					
,date					
,engagement_live_like				
,engagement_live_total				
,engagement_live_view				
,live_streamer_kol_name					
,live_streamer_kol_type				
,live_streamer_kol_name_1					
,live_streamer_kol_type_1					
,live_streamer_kol_name_2					
,live_streamer_kol_type_2					
,main_theme					
,platform					
,promotion					
,sales_live_basket_size					
,sales_live_cvr				
,sales_live_of_order				
,sales_live_sell_out					
,sales_week_basket_size				
,sales_week_of_order					
,sales_week_sell_out					
,type					
,url					
	
FROM {{ref('stg_sales_liveCommerce')}}
