with 
  source_data as (
    select 
      -- primary key
      addressid

      -- foreign keys
      , businessentityid

      , addresstypeid
      , modifieddate	
      , rowguid
        
      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at
        	
    from {{  source('adventureworks_integration', 'businessentityaddress')  }}
  )
select * from source_data
