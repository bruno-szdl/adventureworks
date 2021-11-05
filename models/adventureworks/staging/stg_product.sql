with 
  source_data as (
    select 
      -- primary key
      productid

      -- foreign keys
      , productsubcategoryid
      , productmodelid

      , productnumber
      , name
      , class
      , standardcost
      , listprice
      , safetystocklevel
      , size
      , sizeunitmeasurecode
      , weight
      , weightunitmeasurecode
      , color
      , style
      , sellstartdate
      , sellenddate
      , daystomanufacture
      , productline
      , reorderpoint
      , makeflag
      , finishedgoodsflag
      , modifieddate	
      , rowguid

      -- stitch
      , _sdc_table_version
      , _sdc_received_at
      , _sdc_sequence
      , _sdc_batched_at

      from {{  source('adventureworks_integration', 'product')  }}
  )
select * from source_data

	

	





	