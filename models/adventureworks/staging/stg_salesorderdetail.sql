with 
  source_data as (
    select 
      -- primary key
      salesorderdetailid

      -- foreign keys
      , salesorderid
      , productid
      , specialofferid

      , unitprice
      , unitpricediscount
      , orderqty
      , carriertrackingnumber
      , modifieddate
      , rowguid

      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'salesorderdetail')  }}
  )
select * from source_data