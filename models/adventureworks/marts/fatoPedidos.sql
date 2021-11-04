{{  config(materialized='table')  }}

with
    cartao as (
        select *
        from {{ ref('dimCartao')  }}
    )
    , cliente as (
        select *
        from {{ ref('dimCliente')  }}
    )
    , data as (
        select *
        from {{ ref('dimData')  }}
    )
    , local as (
        select *
        from {{ ref('dimLocal')  }}
    )
    , motivo as (
        select *
        from {{ ref('dimMotivo')  }}
    )
    , produto as (
        select *
        from {{ ref('dimProduto')  }}
    )
    , status as (
        select *
        from {{ ref('dimStatus')  }}
    )

    , pedidos_com_sk as (
        select
            salesorderheader.salesorderid as pedidoid
            , cartao.cartaoSK as cartaoFK
            , cliente.clienteSK as clienteFK
            , data.dataSK as dataFK
            , local.localSK as localFK
            , status.statusSK as statusFK
            , salesorderheader.freight as frete

        from {{  ref('stg_salesorderheader')  }} salesorderheader
        left join cartao on salesorderheader.creditcardid = cartao.cartaoid
        left join cliente on salesorderheader.customerid = cliente.clienteid
        left join data on salesorderheader.orderdate = data.dataPedido
        left join local on salesorderheader.customerid = local.clienteid
        left join status on salesorderheader.status = status.status

    )
    , detalhes_com_sk as (
        select
            salesorderdetail.salesorderid as pedidoid
            , salesorderdetail.salesorderdetailid as detalheid
            , produto.produtoSK as produtoFK
            , salesorderdetail.unitprice as precoUnitario
            , salesorderdetail.unitpricediscount as descontoPrecoUnitario
            , salesorderdetail.orderqty as quantidade
        
        from {{  ref('stg_salesorderdetail')  }} salesorderdetail
        left join produto on salesorderdetail.productid = produto.produtoid

    )
    , final as (
        select
            {{ dbt_utils.surrogate_key('pedidos_com_sk.pedidoid', 'detalhes_com_sk.detalheid') }} as pedidoSK
            , pedidos_com_sk.pedidoid
            , detalhes_com_sk.produtoFK
            , motivo.motivoSK as motivoFK
            , pedidos_com_sk.cartaoFK
            , pedidos_com_sk.clienteFK
            , pedidos_com_sk.dataFK
            , pedidos_com_sk.localFK
            , pedidos_com_sk.statusFK
            , detalhes_com_sk.precounitario
            , detalhes_com_sk.descontoPrecoUnitario
            , detalhes_com_sk.quantidade
            , pedidos_com_sk.frete

            from pedidos_com_sk
            left join detalhes_com_sk on pedidos_com_sk.pedidoid = detalhes_com_sk.pedidoid
            left join motivo on pedidos_com_sk.pedidoid = motivo.pedidoid
    )

select * from final