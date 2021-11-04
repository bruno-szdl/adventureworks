{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_salesorderheader')  }}
    )
    , transformed as (
        select
            {{ dbt_utils.surrogate_key('status') }} as statusSK
            , status

        from staging
    )

select distinct * from transformed