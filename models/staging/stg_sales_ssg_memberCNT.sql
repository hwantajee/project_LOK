SELECT
    month,
    UPPER (brand) AS brand,
    member_cnt
FROM {{source('sales_ssg_memberCNT','sales_ssg_member_cnt')}}
UNPIVOT (member_cnt for brand IN (
    AC,
    BIO,
    BIO_2,
    GAB,
    HR,
    KIE,
    LAN,
    SHU,
    UD,
    YSL
    
    )
) AS UNPIVOT_RESULT
ORDER BY month, brand