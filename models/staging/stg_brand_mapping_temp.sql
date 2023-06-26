WITH BRAND AS ( 
    
    SELECT 

        string_field_0 AS division,
        string_field_1 AS division_full,  
        string_field_2 AS brand_abbr,
        string_field_3 AS brand_kr,
        CASE WHEN string_field_4 = "L'Oréal Professionnel" THEN "L'Oreal Professionnel" 
        ELSE string_field_4 
        END signature_label

    FROM {{source('brand','brand_mapping_temporary')}}
)

    SELECT 
        *,
        'Y' AS LOK
    FROM BRAND    