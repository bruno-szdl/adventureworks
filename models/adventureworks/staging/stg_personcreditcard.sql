with 
  source_data as (
    select 
      -- primary key
      creditcardid

      -- foreign keys
      , businessentityid
        
      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at
        	
    from {{  source('adventureworks_integration', 'personcreditcard')  }}
  )
select * from source_data