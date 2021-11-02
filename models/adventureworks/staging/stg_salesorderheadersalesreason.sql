with 
  source_data as (
    select 
      -- primary key
      salesorderid

      -- foreign keys
      , salesreasonid

      , modifieddate

      -- stitch
      , _sdc_sequence
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'salesorderheadersalesreason')  }}
  )
select * from source_data