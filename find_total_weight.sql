select
count(o1.quantity)
from (
select
(donev.type, donev2.type) as group,
offit.units,
offit.quantity,
don.external_id,
COALESCE ((donev.type = 'Accepted', donev2.type = 'Collected'),
(donev.type = 'Accepted', donev2.type = 'Uncollected')) as coalesced
from
donation_event donev
join donation_event donev2 on donev.donation_id = donev2.donation_id
join donation don on donev.donation_id = don.id
join donation_item donit on don.id = donit.donation_id
join offer_item offit on donit.id = offit.donation_item_id
join offer off on off.donor_id = don.donor_id
join donor donor on don.donor_id = donor.org_id
where off.recipient_id=xxxx
and donor.external_id like 'ABC%'
and donev.type = 'Accepted' and donev2.type in ('Collected', 'Uncollected')
group by (donev.type, donev2.type), offit.units, offit.quantity, don.external_id) o1;
