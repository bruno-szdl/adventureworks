with 
  source_data as (
    select 
      -- primary key
      countryregioncode

      , name
      , modifieddate

      -- stitch
      , _sdc_sequence
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_batched_at

    from {{  source('adventureworks_integration', 'countryregion')  }}
  )
select * from source_data