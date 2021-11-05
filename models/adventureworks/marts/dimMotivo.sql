{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_salesreason')  }}
    )
    , transformed as (
        select
          {{ dbt_utils.surrogate_key('salesreasonid') }} as motivoSK
          , salesreasonid as motivoid
          , name as motivoDaVenda
          , reasontype as tipoDeMotivo

        from staging
    )

select * from transformed
