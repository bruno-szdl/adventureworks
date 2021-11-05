 with
    teste as (
        select count(pedidoid) as totalPedidos
        from {{  ref('dimPedido')  }}
        where ano = 2011
    )

select * from teste where totalPedidos != 1607