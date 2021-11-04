{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_creditcard')  }}
    )
    , transformed as (
        select
            {{ dbt_utils.surrogate_key('creditcardid') }} as cartaoSK
            , creditcardid as cartaoid
            , cardtype as tipoDeCartao

        from staging
    )

select * from transformed