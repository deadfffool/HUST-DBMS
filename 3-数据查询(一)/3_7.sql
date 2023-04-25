select c_name,c_phone,c_mail
from client 
where c_id_card like "4201%" and 
not exists(
    select *
    from property
    where pro_type = '1' and pro_c_id = c_id
)
order by c_id;