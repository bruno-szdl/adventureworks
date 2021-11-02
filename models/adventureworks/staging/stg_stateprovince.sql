with 
  source_data as (
    select 
      -- primary key
      stateprovinceid

      -- foreign keys
      , territoryid
      , countryregioncode

      , name
      , stateprovincecode
      , isonlystateprovinceflag
      , modifieddate
      , rowguid

      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence	
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'stateprovince')  }}
  )
select * from source_data