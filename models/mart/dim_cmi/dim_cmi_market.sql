SELECT

    year
    selectivities,
    categories,
    channel,
    value,
    
FROM {{ref('stg_cmi_market')}}
