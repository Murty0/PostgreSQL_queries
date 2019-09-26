SELECT
  donation_id, date_time, donor_id, offer_channel, accept_channel
FROM (
       SELECT
         d1.aggregate_id AS donation_id,
         d1.timestamp    AS date_time,
         d1.donor_id     AS donor_id,
         d1.event_type   AS event,
         d1.data         AS accept_channel,
         d2.data         AS offer_channel,
         ROW_NUMBER()
         OVER (
           PARTITION BY d1.aggregate_id
           ORDER BY d1.timestamp DESC
           )             AS row
       FROM
         donation_event d1, donation_event d2
       WHERE
         d1.event_type = 'Accepted' AND d1.timestamp >= 'xxxx'
         AND d2.aggregate_id = d1.aggregate_id
         AND d2.event_type = 'Offered'
         AND d2.data like 'xxxx%') x
WHERE x.row = 1;
