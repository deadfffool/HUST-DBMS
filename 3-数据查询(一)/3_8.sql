select c_name,c_id_card,c_phone
from client
where exists(
    select b_c_id,count(b_c_id) as num
    from bank_card
    where b_type = "信用卡" and b_c_id = c_id
    group by b_c_id
    having num >= 2
)