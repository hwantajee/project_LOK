WITH
RAW_MEDIA AS (

SELECT 

        year,
        pre_year, 
        end_date,
        `start_date`,
        year_month,
        adserving_status,
        division,
        brand,
        -- product_category를 통한 sales 기준  >> H2_category 생성
        product_category,
        --H2_category,
        product,
        campaign,
        campaign_theme, 
        vehicle,
        --landing_page (sales 도메인에 맞게 mapping 작업 완료) >> sales_channel
        UPPER(landing_page) AS landing_page,  
        UPPER(landing_category) AS landing_category,
        media,
        sub_media,
        digital_lever,
        type,
        device,
        ad_placement_kr,
        ad_placement,
        ad_placement_details,
        objectives,
        kpi_benchmark_ctr,
        kpi_benchmark_vtr,
        kpi_ctr,
        kpi_vtr,
        impression,
        click,
        ctr,
        view,
        vtr,
        cpm,
        cpc,
        cpv,
        pmm_imp,
        pmm_cpm,
        pmm_ctr,
        pmm_click,
        pmm_cpc,
        pmm_view,
        pmm_vtr,
        pmm_cpv,
        t_standard,
        conversion_t,
        cvr_t,
        revenue_t,
        roas_t,
        conversion_m,
        cvr_m,
        revenue_m,
        roas_m,
        conversion_g,
        cvr_g,
        revenue_g,
        roas_g,
        gross_budget,
        agency_fee,
        budget_net

FROM {{ref('stg_media_mezzo_spending')}}
 ),

MAPPING_CHANNEL AS (
    
    SELECT 
    *
    FROM  

{{ref('dim_mapping_channel_media')}} 
),


MAPPING_CATEGORY AS (
    
    SELECT 
    *
    FROM  

{{ref('dim_mapping_productCategory_media')}} 
)

SELECT 

        S.year,
        S.pre_year, 
        S.end_date,
        S.`start_date`,
        S.year_month,
        S.adserving_status,
        S.division,
        S.brand,
        -- product_category를 통한 sales 기준  >> H2_category 생성
        S.product_category,
        C.H2_category,
        S.product,
        S.campaign,
        S.campaign_theme, 
        S.vehicle,
        --landing_page (sales 도메인에 맞게 mapping 작업 완료) >> sales_channel
        S.landing_page,  
        S.landing_category,
        -- media mapping 테이블을 통한 sellout 채널 매핑 작업 수행
        M.sales_channel,
        -- media mapping 테이블을 통한 sellout 채널 카테고리 매핑 작업 수행  
        M.channel_name,
        S.media,
        S.sub_media,
        S.digital_lever,
        S.type,
        S.device,
        S.ad_placement_kr,
        S.ad_placement,
        S.ad_placement_details,
        S.objectives,
        S.kpi_benchmark_ctr,
        S.kpi_benchmark_vtr,
        S.kpi_ctr,
        S.kpi_vtr,
        S.impression,
        S.click,
        S.ctr,
        S.view,
        S.vtr,
        S.cpm,
        S.cpc,
        S.cpv,
        S.pmm_imp,
        S.pmm_cpm,
        S.pmm_ctr,
        S.pmm_click,
        S.pmm_cpc,
        S.pmm_view,
        S.pmm_vtr,
        S.pmm_cpv,
        S.t_standard,
        S.conversion_t,
        S.cvr_t,
        S.revenue_t,
        S.roas_t,
        S.conversion_m,
        S.cvr_m,
        S.revenue_m,
        S.roas_m,
        S.conversion_g,
        S.cvr_g,
        S.revenue_g,
        S.roas_g,
        S.gross_budget,
        S.agency_fee,
        S.budget_net

FROM RAW_MEDIA S 
LEFT JOIN MAPPING_CHANNEL M
ON S.landing_page = M.landing_page
LEFT JOIN MAPPING_CATEGORY C
ON S.product_category = C.product_category
