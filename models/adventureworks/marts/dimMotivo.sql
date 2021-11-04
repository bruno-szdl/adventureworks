{{  config(materialized='table')  }}

with
    staging_salesreason as (
        select *
        from {{  ref('stg_salesreason')  }}
    )
    , staging_salesorderheadersalesreason as (
        select *
        from {{  ref('stg_salesorderheadersalesreason')  }}
    )
    , joined as (
        select 
          staging_salesorderheadersalesreason.salesorderid
          , staging_salesorderheadersalesreason.salesreasonid
          , staging_salesreason.name
          , staging_salesreason.reasontype

        from staging_salesorderheadersalesreason
        left join staging_salesreason on staging_salesreason.salesreasonid = staging_salesorderheadersalesreason.salesreasonid
    )
    , transformed as (
        select
          {{ dbt_utils.surrogate_key('salesorderid', 'salesreasonid') }} as motivoSK
          , salesorderid as pedidoid
          , salesreasonid as motivoid
          , name as motivoDaVenda
          , reasontype as tipoDeMotivo

        from joined
    )

select * from transformed
