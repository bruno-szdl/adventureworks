{{  config(materialized='table')  }}

with
    dimPedido as (
        select *
        from {{ ref('dimPedido')  }}
    )
    , dimMotivo as (
        select *
        from {{ ref('dimMotivo')  }}
    )
    , pedidos_com_sk as (
        select
            cabecalho.salesorderid as pedidoid
            , dimPedido.pedidoSK as pedidoFK

        from {{  ref('stg_salesorderheader')  }} cabecalho
        left join dimPedido on dimPedido.pedidoid = cabecalho.salesorderid

    )
    , motivos_com_sk as (
        select
            cabecalhoMotivo.salesorderid as pedidoid
            , cabecalhoMotivo.salesreasonid as motivoid
            , dimMotivo.motivoSK as motivoFK
        
        from {{  ref('stg_salesorderheadersalesreason')  }} cabecalhoMotivo
        left join dimMotivo on dimMotivo.motivoid = cabecalhoMotivo.salesreasonid

    )
    , final as (
        select
            {{ dbt_utils.surrogate_key('pedidos_com_sk.pedidoid', 'motivos_com_sk.motivoid') }} as pedidoMotivoSK
            , pedidos_com_sk.pedidoFK
            , motivos_com_sk.motivoFK

            from pedidos_com_sk
            left join motivos_com_sk on pedidos_com_sk.pedidoid = motivos_com_sk.pedidoid
    )

select * from final