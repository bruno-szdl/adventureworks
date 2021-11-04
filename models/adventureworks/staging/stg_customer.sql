with 
  source_data as (
    select 
      -- primary key
      customerid

      -- foreign keys
      , personid
      , storeid
      , territoryid

      , modifieddate	
      , rowguid
        
      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at
        	
    from {{  source('adventureworks_integration', 'customer')  }}
  )
select * from source_data
