{{  config(materialized='table')  }}

with
    motivo as (
        select *
        from {{ ref('dimMotivo')  }}
    )
    , staging as (
        select *
        from {{  ref('stg_salesorderheadersalesreason')  }}
    )
    , transformed as (
        select 
          salesorderid as pedidoid
          , salesreasonid as motivoid

        from staging
    )
    , final as (
        select
            {{ dbt_utils.surrogate_key('transformed.pedidoid', 'transformed.motivoid') }} as unique_key
            , transformed.pedidoid
            , motivo.motivoSK as motivoFK
            
            from transformed
            left join motivo on motivo.motivoid = transformed.motivoid
    )

select * from final
