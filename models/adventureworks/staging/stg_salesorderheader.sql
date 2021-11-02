with 
  source_data as (
    select 
      -- primary key
      salesorderid

      -- foreign keys
      , customerid
      , salespersonid
      , billtoaddressid
      , creditcardid
      , currencyrateid
      , territoryid
      , shipmethodid
      , shiptoaddressid

      , status
      , purchaseordernumber
      , subtotal
      , freight
      , totaldue
      , accountnumber
      , revisionnumber
      , creditcardapprovalcode
      , orderdate
      , duedate
      , shipdate
      , taxamt
      , onlineorderflag
      , modifieddate	
      , rowguid

      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'salesorderheader')  }}
  )
select * from source_data