{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_salesorderheader')  }}
    )
    , transformed as (
        select
            {{ dbt_utils.surrogate_key('orderdate') }} as dataSK
            , orderdate as dataPedido
            , extract(year from orderdate) as ano
            , extract(month from orderdate) as mes

        from staging
    )

select distinct * from transformed