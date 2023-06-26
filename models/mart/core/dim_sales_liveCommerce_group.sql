WITH 

live AS (
    SELECT

        date,
        CAST(SUBSTR(CAST(date AS string),1,4) AS int) AS year,
        CAST(SUBSTR(CAST(date AS string),6,2) AS int) month,
        CAST(SUBSTR(CAST(date AS string),1,4) AS int) -1 AS pre_year,     
        CAST(SUBSTR(CAST(date AS string),6,2) AS int) AS pre_month,        
        IFNULL(upper(platform), '-') as platform,
        IFNULL(brand,'-') as brand,
        IFNULL(engagement_live_view,0) as view,
        IFNULL(sales_live_of_order,0) as `order`,
        IFNULL(sales_live_sell_out,0) as sellout

    FROM {{ref('stg_sales_liveCommerce')}}    

)
--liveCommerce 데이터 원본 key 값 생성
    SELECT  
        
              
        CONCAT(year,'-',month) AS year_month,        
        CONCAT(platform,'_',brand,'_',year,'_',month) AS live_name,
        platform AS channel,
        brand AS brand_abbr,       
        SUM(view) AS view,
        SUM(`order`) AS `order`,
        SUM(sellout) AS sellout

    from live
    GROUP BY year_month, channel, brand_abbr, live_name

