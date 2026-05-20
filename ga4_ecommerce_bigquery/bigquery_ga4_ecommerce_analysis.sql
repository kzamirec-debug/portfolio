---Q1 Retrieve REPEATED fields for a specific user with valid interaction data---
select user_pseudo_id,
       timestamp_micros(event_timestamp) as event_timestamp,
       event_name,
       event_params,
       user_properties,
       items
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
where user_pseudo_id = (
  select user_pseudo_id
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
  unnest(items) as i
  where i.item_name is not null and i.item_name <> '(not set)'
  limit 1
)
and exists (
  select 1 from unnest(items) as i 
  where i.item_name is not null and i.item_name <> '(not set)'
)
limit 1;

--- Q2 Calculate array lengths for event_params, user_properties, and items---
with one_user as (
  select user_pseudo_id,
         timestamp_micros(event_timestamp) as event_timestamp
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
unnest (items) as i
where i.item_name is not null and i.item_name <> '(not set)'
order by 2 desc
limit 1 )
select ga4.user_pseudo_id,
       timestamp_micros(ga4.event_timestamp) as event_timestamp,
       event_name,
       event_params,
       user_properties,
       items,
       ARRAY_LENGTH(event_params) as nb_event,
       ARRAY_LENGTH(user_properties) as nb_user_properties,
       ARRAY_LENGTH(items) as nb_user_items
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` as ga4
right join one_user o
on o.user_pseudo_id = ga4.user_pseudo_id
and o.event_timestamp = timestamp_micros(ga4.event_timestamp);

--- Q3 Flatten event_params array to analyze specific key-value parameters---
with target_event as (
  select 
    user_pseudo_id, 
    event_timestamp
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
  where exists (
    select 1 from unnest (items) as i 
    where i.item_name is not null 
      and i.item_name != '' 
      and i.item_name not in ('not set', '(not set)')
  )
  and user_pseudo_id is not null
  limit 1
)
select
    e.user_pseudo_id,
    timestamp_micros(e.event_timestamp) as event_timestamp,
    e.event_name,
    ep.key,
    ep.value.string_value,
    ep.value.int_value,
    ep.value.double_value
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` as e
cross join unnest(e.event_params) as ep
join target_event t 
  on e.user_pseudo_id = t.user_pseudo_id 
  and e.event_timestamp = t.event_timestamp
order by ep.key asc;
  
--- Q4 Calculate the frequency distribution of event parameter keys for 2021---
select ep.key,
       count (ep.key) as total_params
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_2021*` as ga4,
unnest (event_params) as ep
group by ep.key
order by total_params desc;

--- Q5 Flatten the items array to extract product-level granular transaction data---
select ga4.user_pseudo_id,
       timestamp_micros(ga4.event_timestamp) as event_timestamp,
       i.item_id,
       i.item_name,
       i.item_category,
      i.price,
      i.quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` as ga4,
unnest(items) as i;

--- Q6 Aggregate product performance metrics (Event count, Quantity, Total revenue)---
select i.item_id,
       i.item_name,
       count(*) as count_events,
       sum(i.quantity) as sum_quantity,
       sum(i.price*i.quantity) as total_revenue
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` as ga4,
unnest (items) as i
group by 1,2
order by 5 desc;

--- Q7 Filter nested event items by specific category using EXISTS and UNNEST---
select event_name
from  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` as ga4
where exists (select 1 from unnest (items) as i where i.item_category = 'Apparel');

--- Q8 Analyze daily trends using wildcards (_TABLE_SUFFIX) for users, events, and purchases---
select _TABLE_SUFFIX as event_date,
       count (distinct user_pseudo_id) as unique_users,
       count (*) as total_events,
       countif (event_name = 'purchase') as purchase_events
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as ga4
group by event_date
order by event_date asc;

--- Q9 Rank top 20 users by total revenue using RANK(), DENSE_RANK(), and ROW_NUMBER()---
with user_revenue as (
  select user_pseudo_id,
         sum (item.price*item.quantity) as total_revenue
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as ga4,
  unnest (items) as item
  group by 1
)
select user_pseudo_id,
       total_revenue,
       rank() over(order by total_revenue desc) as rank_revenue,
       dense_rank() over(order by total_revenue desc) as dense_rank_revenue,
       row_number() over(order by total_revenue desc) as rn_revenue
from user_revenue
order by total_revenue desc
limit 20;

--- Q10 Extract session IDs and determine the most frequent session-start events---
with ga_session_user as (
  select user_pseudo_id,
         event_name,
         event_timestamp,
         (select value.int_value from unnest (event_params) where key='ga_session_id') as ga_session_id
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
),
rn_event as (
  select event_name,
         row_number() over(partition by user_pseudo_id, ga_session_id order by event_timestamp asc) as rn
  from ga_session_user
  where ga_session_id is not null
)
select event_name as most_common_event,
       count(*) as occurences_count
from rn_event
where rn=1
group by event_name
order by occurences_count desc
limit 1

