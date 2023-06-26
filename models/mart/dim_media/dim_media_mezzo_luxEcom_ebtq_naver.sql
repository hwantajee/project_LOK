SELECT

    date,
    month,
    ad_placement,
    brand,
    click,
    conversion_g,
    conversion_m,
    conversion_t,
    cost_gross_ AS cost_gross,
    cost_net_net,
    cpc,
    cpm,
    ctr,
    cvr_g,
    cvr_m,
    cvr_t,    
    impression,
    landing,    
    publisher,
    revenue_g,
    revenue_m,
    revenue_t,
    roas_g,
    roas_m,
    roas_t
FROM {{ref('stg_media_mezzo_luxEcom_ebtq_naver')}}


