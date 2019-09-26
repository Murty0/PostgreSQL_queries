SELECT
  count (*) noofdonations, CAST(to_timestamp(floor((extract('epoch' from (accept_time - offer_time)) / 300)) * 300) AS time) as time_taken 
FROM (
       SELECT
         d1.aggregate_id AS noofdonations,
         d1.timestamp    AS accept_time,
         d1.donor_id     AS donor_id,
     d1.recipient_id AS recipient_id,
         d2.timestamp    AS offer_time,
     d1.data         AS accept_channel,
         d2.data         AS offer_channel,
         ROW_NUMBER()
         OVER (
           PARTITION BY d1.aggregate_id, d1.recipient_id
           ORDER BY d1.timestamp ASC
           )             AS row
       FROM
         donation_event d1, donation_event d2
       WHERE
         d1.event_type = 'Accepted' AND 
     d1.timestamp >= 'xxxx' AND 
     d2.timestamp >= 'xxxx' AND 
     d1.timestamp < 'xxxx' AND 
     d2.timestamp < 'xxxx' AND 
     d2.aggregate_id = d1.aggregate_id AND 
     d2.event_type = 'Offered' 
     ORDER BY (d1.timestamp - d2.timestamp) desc) x
WHERE x.row = 1 GROUP BY time_taken ORDER BY (time_taken);
