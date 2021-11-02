{{  config(materialized='table')  }}

select * from {{  ref('stg_salesorderheader')  }}
