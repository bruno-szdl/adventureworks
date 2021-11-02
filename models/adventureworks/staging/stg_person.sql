with 
  source_data as (
    select 
      -- primary key
      businessentityid

      , persontype
      , title
      , namestyle
      , firstname
      , middlename
      , lastname
      , emailpromotion
      , suffix
      , modifieddate
      , rowguid

      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'person')  }}
  )
select * from source_data