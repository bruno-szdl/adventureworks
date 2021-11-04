{{  config(materialized='table')  }}

with
    person as (
        select *
        from {{  ref('stg_person')  }}
    )
    , customer as (
        select *
        from {{  ref('stg_customer')  }}
    )
    , joined as (
        select
          customer.customerid
          , customer.personid
          , person.businessentityid
          , person.title
          , person.firstname
          , person.lastname
        from customer
        left join person on person.businessentityid = customer.personid
    )
    , transformed as (
        select
          {{ dbt_utils.surrogate_key('customerid') }} as clienteSK
          , customerid as clienteid
          , concat(if(title is null, ' ', title), ' ', firstname, ' ', lastname) as nome
        from joined
    )

select * from transformed