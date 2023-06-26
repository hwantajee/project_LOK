WITH 
modified_media AS (
    SELECT
        year,
        adserving_status,
        division,
        brand,
        product_category,
        product,
        campaign,
        campaign_theme, 
        vehicle,
        IFNULL(landing_page, '-') AS landing_page,
        IFNULL(landing_category, '-') AS landing_category, 
        media,
        submedia AS sub_media,
        digital_lever,
        type,
        device,
        ad_placement_kor AS ad_placement_kr,
        ad_placement,
        ad_placement_details,
        IFNULL(objectives, '-') as objectives,
        kpi_benchmark_ctr,
        kpi_benchmark_vtr,
        kpi_ctr,
        kpi_vtr,
        amp_impression AS impression,
        amp_click AS click,
        amp_ctr AS ctr,
        amp_view AS view,
        amp_vtr AS vtr,
        amp_cpm AS cpm,
        amp_cpc AS cpc,
        amp_cpv AS cpv,
        pmm_imp,
        pmm_cpm,
        pmm_ctr,
        pmm_click,
        pmm_cpc,
        pmm_view,
        pmm_vtr,
        pmm_cpv,
        -- 해당 매체가 trackability인지 아닌지의 여부를 위한 코드
        CASE WHEN t_standard = 'G' then 'Y'
            WHEN t_standard = 'M' then 'Y'
            ELSE 'N'
            END t_standard,
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
        budget_net,
        CASE WHEN end_date LIKE '%00:00:00%' THEN SUBSTRING(end_date,6,2)
            WHEN end_date LIKE '%Jan%' THEN SUBSTRING (REPLACE(end_date, 'Jan', '01'),4,2) 
            WHEN end_date LIKE '%Feb%' THEN SUBSTRING (REPLACE(end_date, 'Feb', '02'),4,2) 
            WHEN end_date LIKE '%Mar%' THEN SUBSTRING (REPLACE(end_date, 'Mar', '03'),4,2) 
            WHEN end_date LIKE '%Apr%' THEN SUBSTRING (REPLACE(end_date, 'Apr', '04'),4,2)
            WHEN end_date LIKE '%May%' THEN SUBSTRING (REPLACE(end_date, 'May', '05'),4,2)
            WHEN end_date LIKE '%Jun%' THEN SUBSTRING (REPLACE(end_date, 'Jun', '06'),4,2)
            WHEN end_date LIKE '%Jul%' THEN SUBSTRING (REPLACE(end_date, 'Jul', '07'),4,2)
            WHEN end_date LIKE '%Aug%' THEN SUBSTRING (REPLACE(end_date, 'Aug', '08'),4,2)
            WHEN end_date LIKE '%Sep%' THEN SUBSTRING (REPLACE(end_date, 'Sep', '09'),4,2)
            WHEN end_date LIKE '%Oct%' THEN SUBSTRING (REPLACE(end_date, 'Oct', '10'),4,2)
            WHEN end_date LIKE '%Nov%' THEN SUBSTRING (REPLACE(end_date, 'Nov', '11'),4,2)
            WHEN end_date LIKE '%Dec%' THEN SUBSTRING (REPLACE(end_date, 'Dec', '12'),4,2)
            ELSE SUBSTRING (end_date,6,2)
            END end_month_m,
        CASE WHEN end_date LIKE '%00:00:00%' THEN SUBSTRING(end_date,1,4)
            WHEN end_date LIKE '%Jan%' THEN SUBSTRING (REPLACE(end_date, 'Jan', '01'),7,4) 
            WHEN end_date LIKE '%Feb%' THEN SUBSTRING (REPLACE(end_date, 'Feb', '02'),7,4) 
            WHEN end_date LIKE '%Mar%' THEN SUBSTRING (REPLACE(end_date, 'Mar', '03'),7,4) 
            WHEN end_date LIKE '%Apr%' THEN SUBSTRING (REPLACE(end_date, 'Apr', '04'),7,4)
            WHEN end_date LIKE '%May%' THEN SUBSTRING (REPLACE(end_date, 'May', '05'),7,4)
            WHEN end_date LIKE '%Jun%' THEN SUBSTRING (REPLACE(end_date, 'Jun', '06'),7,4)
            WHEN end_date LIKE '%Jul%' THEN SUBSTRING (REPLACE(end_date, 'Jul', '07'),7,4)
            WHEN end_date LIKE '%Aug%' THEN SUBSTRING (REPLACE(end_date, 'Aug', '08'),7,4)
            WHEN end_date LIKE '%Sep%' THEN SUBSTRING (REPLACE(end_date, 'Sep', '09'),7,4)
            WHEN end_date LIKE '%Oct%' THEN SUBSTRING (REPLACE(end_date, 'Oct', '10'),7,4)
            WHEN end_date LIKE '%Nov%' THEN SUBSTRING (REPLACE(end_date, 'Nov', '11'),7,4)
            WHEN end_date LIKE '%Dec%' THEN SUBSTRING (REPLACE(end_date, 'Dec', '12'),7,4)
            ELSE SUBSTRING(end_date,1,4)
            END end_year_m,
        CASE WHEN end_date LIKE '%00:00:00%' THEN SUBSTRING(end_date,9,2)
            WHEN end_date LIKE '%Jan%' THEN SUBSTRING (REPLACE(end_date, 'Jan', '01'),1,2) 
            WHEN end_date LIKE '%Feb%' THEN SUBSTRING (REPLACE(end_date, 'Feb', '02'),1,2) 
            WHEN end_date LIKE '%Mar%' THEN SUBSTRING (REPLACE(end_date, 'Mar', '03'),1,2) 
            WHEN end_date LIKE '%Apr%' THEN SUBSTRING (REPLACE(end_date, 'Apr', '04'),1,2)
            WHEN end_date LIKE '%May%' THEN SUBSTRING (REPLACE(end_date, 'May', '05'),1,2)
            WHEN end_date LIKE '%Jun%' THEN SUBSTRING (REPLACE(end_date, 'Jun', '06'),1,2)
            WHEN end_date LIKE '%Jul%' THEN SUBSTRING (REPLACE(end_date, 'Jul', '07'),1,2)
            WHEN end_date LIKE '%Aug%' THEN SUBSTRING (REPLACE(end_date, 'Aug', '08'),1,2)
            WHEN end_date LIKE '%Sep%' THEN SUBSTRING (REPLACE(end_date, 'Sep', '09'),1,2)
            WHEN end_date LIKE '%Oct%' THEN SUBSTRING (REPLACE(end_date, 'Oct', '10'),1,2)
            WHEN end_date LIKE '%Nov%' THEN SUBSTRING (REPLACE(end_date, 'Nov', '11'),1,2)  
            WHEN end_date LIKE '%Dec%' THEN SUBSTRING (REPLACE(end_date, 'Dec', '12'),1,2)
            ELSE SUBSTRING(end_date,9,2)
            END end_date_m,
        CASE WHEN start_date LIKE '%00:00:00%' THEN SUBSTRING(start_date,6,2)
            WHEN start_date LIKE '%Jan%' THEN SUBSTRING (REPLACE(start_date, 'Jan', '01'),4,2) 
            WHEN start_date LIKE '%Feb%' THEN SUBSTRING (REPLACE(start_date, 'Feb', '02'),4,2) 
            WHEN start_date LIKE '%Mar%' THEN SUBSTRING (REPLACE(start_date, 'Mar', '03'),4,2) 
            WHEN start_date LIKE '%Apr%' THEN SUBSTRING (REPLACE(start_date, 'Apr', '04'),4,2)
            WHEN start_date LIKE '%May%' THEN SUBSTRING (REPLACE(start_date, 'May', '05'),4,2)
            WHEN start_date LIKE '%Jun%' THEN SUBSTRING (REPLACE(start_date, 'Jun', '06'),4,2)
            WHEN start_date LIKE '%Jul%' THEN SUBSTRING (REPLACE(start_date, 'Jul', '07'),4,2)
            WHEN start_date LIKE '%Aug%' THEN SUBSTRING (REPLACE(start_date, 'Aug', '08'),4,2)
            WHEN start_date LIKE '%Sep%' THEN SUBSTRING (REPLACE(start_date, 'Sep', '09'),4,2)
            WHEN start_date LIKE '%Oct%' THEN SUBSTRING (REPLACE(start_date, 'Oct', '10'),4,2)
            WHEN start_date LIKE '%Nov%' THEN SUBSTRING (REPLACE(start_date, 'Nov', '11'),4,2)
            WHEN start_date LIKE '%Dec%' THEN SUBSTRING (REPLACE(start_date, 'Dec', '12'),4,2)
            ELSE start_date
            END start_month_m,
        CASE WHEN start_date LIKE '%00:00:00%' THEN SUBSTRING(start_date,1,4)
            WHEN start_date LIKE '%Jan%' THEN SUBSTRING (REPLACE(start_date, 'Jan', '01'),7,4) 
            WHEN start_date LIKE '%Feb%' THEN SUBSTRING (REPLACE(start_date, 'Feb', '02'),7,4) 
            WHEN start_date LIKE '%Mar%' THEN SUBSTRING (REPLACE(start_date, 'Mar', '03'),7,4) 
            WHEN start_date LIKE '%Apr%' THEN SUBSTRING (REPLACE(start_date, 'Apr', '04'),7,4)
            WHEN start_date LIKE '%May%' THEN SUBSTRING (REPLACE(start_date, 'May', '05'),7,4)
            WHEN start_date LIKE '%Jun%' THEN SUBSTRING (REPLACE(start_date, 'Jun', '06'),7,4)
            WHEN start_date LIKE '%Jul%' THEN SUBSTRING (REPLACE(start_date, 'Jul', '07'),7,4)
            WHEN start_date LIKE '%Aug%' THEN SUBSTRING (REPLACE(start_date, 'Aug', '08'),7,4)
            WHEN start_date LIKE '%Sep%' THEN SUBSTRING (REPLACE(start_date, 'Sep', '09'),7,4)
            WHEN start_date LIKE '%Oct%' THEN SUBSTRING (REPLACE(start_date, 'Oct', '10'),7,4)
            WHEN start_date LIKE '%Nov%' THEN SUBSTRING (REPLACE(start_date, 'Nov', '11'),7,4)
            WHEN start_date LIKE '%Dec%' THEN SUBSTRING (REPLACE(start_date, 'Dec', '12'),7,4)
            ELSE start_date
            END start_year_m,
        CASE WHEN start_date LIKE '%00:00:00%' THEN SUBSTRING(start_date,9,2)
            WHEN start_date LIKE '%Jan%' THEN SUBSTRING (REPLACE(start_date, 'Jan', '01'),1,2) 
            WHEN start_date LIKE '%Feb%' THEN SUBSTRING (REPLACE(start_date, 'Feb', '02'),1,2) 
            WHEN start_date LIKE '%Mar%' THEN SUBSTRING (REPLACE(start_date, 'Mar', '03'),1,2) 
            WHEN start_date LIKE '%Apr%' THEN SUBSTRING (REPLACE(start_date, 'Apr', '04'),1,2)
            WHEN start_date LIKE '%May%' THEN SUBSTRING (REPLACE(start_date, 'May', '05'),1,2)
            WHEN start_date LIKE '%Jun%' THEN SUBSTRING (REPLACE(start_date, 'Jun', '06'),1,2)
            WHEN start_date LIKE '%Jul%' THEN SUBSTRING (REPLACE(start_date, 'Jul', '07'),1,2)
            WHEN start_date LIKE '%Aug%' THEN SUBSTRING (REPLACE(start_date, 'Aug', '08'),1,2)
            WHEN start_date LIKE '%Sep%' THEN SUBSTRING (REPLACE(start_date, 'Sep', '09'),1,2)
            WHEN start_date LIKE '%Oct%' THEN SUBSTRING (REPLACE(start_date, 'Oct', '10'),1,2)
            WHEN start_date LIKE '%Nov%' THEN SUBSTRING (REPLACE(start_date, 'Nov', '11'),1,2)  
            WHEN start_date LIKE '%Dec%' THEN SUBSTRING (REPLACE(start_date, 'Dec', '12'),1,2)
            ELSE start_date
            END start_date_m

               
    FROM {{source('media_spending','media_mezzo_spending')}}
),

media AS (
    SELECT 
        year,
        year-1 as pre_year, 
        CONCAT(end_year_m,'-',end_month_m,'-',end_date_m) AS end_date,
        CONCAT(start_year_m,'-',start_month_m,'-',start_date_m) AS `start_date`,
        
        CONCAT(end_year_m,'-',end_month_m ) AS year_month,
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
        -- landing_page (sales 도메인에 맞게 mapping 작업 완료) >> sales_channel
        landing_page,
        landing_category,
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
    FROM modified_media
)

SELECT 
    *
FROM media





