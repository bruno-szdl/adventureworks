with 
  source_data as (
    select 
      -- primary key
      salesreasonid

      name
      , reasontype
      , modifieddate

      -- stitch
      , _sdc_sequence
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'salesreason')  }}
  )
select * from source_data