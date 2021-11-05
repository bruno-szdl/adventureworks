{{  config(materialized='table')  }}

with
    dimPedido as (
        select *
        from {{ ref('dimPedido')  }}
    )
    , dimProduto as (
        select *
        from {{ ref('dimProduto')  }}
    )
    , pedidos_com_sk as (
        select
            cabecalho.salesorderid as pedidoid
            , dimPedido.pedidoSK as pedidoFK
            , cabecalho.freight as frete

        from {{  ref('stg_salesorderheader')  }} cabecalho
        left join dimPedido on dimPedido.pedidoid = cabecalho.salesorderid
    )
    , detalhes_com_sk as (
        select
            detalhes.salesorderid as pedidoid
            , detalhes.salesorderdetailid as detalheid
            , dimProduto.produtoSK as produtoFK
            , detalhes.unitprice as precoUnitario
            , detalhes.unitpricediscount as descontoPrecoUnitario
            , detalhes.orderqty as quantidade
        
        from {{  ref('stg_salesorderdetail')  }} detalhes
        left join dimProduto on dimProduto.produtoid = detalhes.productid
    )
    , final as (
        select
            pedidos_com_sk.pedidoFK
            , detalhes_com_sk.produtoFK
            , detalhes_com_sk.precounitario
            , detalhes_com_sk.descontoPrecoUnitario
            , detalhes_com_sk.quantidade

        from pedidos_com_sk
        left join detalhes_com_sk on pedidos_com_sk.pedidoid = detalhes_com_sk.pedidoid
    )

select * from final