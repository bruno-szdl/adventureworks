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
    , enderecoCliente as (
        select *
        from {{  ref('stg_businessentityaddress')  }}
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
            , pedido.status
            , concat(if(title is null, ' ', pessoa.title), ' ', pessoa.firstname, ' ', pessoa.lastname) as cliente
            , pais.name as pais
            , estado.name as estado
            , endereco.city as cidade
            , cartao.cardtype as cartao

        from pedido
        left join cliente on cliente.customerid = pedido.customerid
        left join pessoa on pessoa.businessentityid = cliente.personid
        left join enderecoCliente on enderecoCliente.businessentityid = cliente.personid
        left join endereco on endereco.addressid = enderecoCliente.addressid
        left join estado on estado.stateprovinceid = endereco.stateprovinceid
        left join pais on pais.countryregioncode = estado.countryregioncode
        left join cartao on cartao.creditcardid = pedido.creditcardid
    )

SELECT distinct * from joined