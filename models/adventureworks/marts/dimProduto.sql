{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_product')  }}
    )
    , transformed as (
        select
            {{ dbt_utils.surrogate_key('productid') }} as produtoSK
            , productid as produtoid
            , name as produto

        from staging
    )

select * from transformed