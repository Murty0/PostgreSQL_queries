select distinct (don.donor_id, donev1.timestamp::date)
from 
donation don 
left join 
donation_event donev1 on donev1.donation_id = don.id 
left join
donation_event donev2 on donev1.donation_id = donev2.donation_id  
where 
donev1.timestamp::date='xxxx' 
and donev1.type = 'Offered'
and donev1.donation_id in (select id from donation where donor_id in (select id from organization where parent_id=x));
