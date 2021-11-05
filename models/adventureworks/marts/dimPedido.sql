{{  config(materialized='table')  }}

with
    pedido as (
        select *
        from {{ ref('stg_salesorderheader')  }}
    )
    , pessoa as (
        select *
        from {{  ref('stg_person')  }}
    )
    , cliente as (
        select *
        from {{  ref('stg_customer')  }}
    )
    , endereco as (
        select *
        from {{  ref('stg_address')  }}
    )
    , estado as (
        select *
        from {{  ref('stg_stateprovince')  }}
    )
    , pais as (
        select *
        from {{  ref('stg_countryregion')  }}
    )
    , cartao as (
        select *
        from {{  ref('stg_creditcard')  }}
    )
    , joined as (
        select
            {{ dbt_utils.surrogate_key('pedido.salesorderid') }} as pedidoSK
            , pedido.salesorderid as pedidoid
            , extract(year from pedido.orderdate) as ano
            , extract(month from pedido.orderdate) as mes
            , case
                when pedido.status = 1 then 'Em Processamento'
                when pedido.status = 2 then 'Aprovado'
                when pedido.status = 3 then 'Em Espera'
                when pedido.status = 4 then 'Rejeitado'
                when pedido.status = 5 then 'Enviado'
                when pedido.status = 6 then 'Cancelado'
              end as status
            , concat(if(title is null, ' ', pessoa.title), ' ', pessoa.firstname, ' ', pessoa.lastname) as cliente
            , pais.name as pais
            , estado.name as estado
            , endereco.city as cidade
            , cartao.cardtype as cartao

        from pedido
        left join cliente on cliente.customerid = pedido.customerid
        left join pessoa on pessoa.businessentityid = cliente.personid
        left join endereco on endereco.addressid = pedido.shiptoaddressid
        left join estado on estado.stateprovinceid = endereco.stateprovinceid
        left join pais on pais.countryregioncode = estado.countryregioncode
        left join cartao on cartao.creditcardid = pedido.creditcardid
    )

SELECT distinct * from joined