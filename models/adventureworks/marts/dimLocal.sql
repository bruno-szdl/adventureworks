{{  config(materialized='table')  }}

with
    staging_address as (
        select *
        from {{  ref('stg_address')  }}
    )
    , staging_state as (
        select *
        from {{  ref('stg_stateprovince')  }}
    )
    , staging_country as (
        select *
        from {{  ref('stg_countryregion')  }}
    )
    , staging_businessentityaddress as (
        select *
        from {{  ref('stg_businessentityaddress')  }}
    )
    , staging_customer as (
        select *
        from {{  ref('stg_customer')  }}
    )
    , joined as (
        select
          staging_customer.customerid as clienteid
          , staging_country.name as pais
          , staging_state.name as estado
          , staging_address.city as cidade

        from staging_customer
        left join staging_businessentityaddress on staging_customer.customerid = staging_businessentityaddress.businessentityid
        left join staging_address on staging_businessentityaddress.addressid = staging_address.addressid
        left join staging_state on staging_address.stateprovinceid = staging_state.stateprovinceid
        left join staging_country on staging_state.countryregioncode = staging_country.countryregioncode
    )
    , transformed as (
        select 
          {{ dbt_utils.surrogate_key('pais', 'estado', 'cidade') }} as localSK
          , *

        from joined
    )

select * from transformed
