    
    SELECT 

        barcode,
        brand_no,
        divis_no,
        goods_fn,
        goods_nm,
        material_cd,
        product_affiliation_name,
        product_affiliation_no,
        product_detail_no,
        product_group_name,
        product_group_no,
        sr_brand_name

    FROM {{source('brand_bh','dim_brand_bh')}}
