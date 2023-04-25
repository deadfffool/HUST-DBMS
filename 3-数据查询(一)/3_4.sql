select c_name, c_phone, b_number
from client, bank_card
where bank_card.b_type ='储蓄卡' and client.c_id=bank_card.b_c_id 
order by client.c_id; 