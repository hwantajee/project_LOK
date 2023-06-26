SELECT 

IFNULL(landing_page,'-' ) AS landing_page,
IFNULL(landing_category,'-') AS landing_category

FROM {{source('media_spending','media_mezzo_spending')}}