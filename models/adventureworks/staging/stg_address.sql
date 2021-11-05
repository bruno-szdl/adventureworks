with 
  source_data as (
    select 
      -- primary key
      addressid

      -- foreign keys
      , stateprovinceid

      , addressline1
      , addressline2
      , city
      , postalcode
      , spatiallocation
      , modifieddate	
      , rowguid
        
      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at
        	
    from {{  source('adventureworks_integration', 'address')  }}
  )
select * from source_data