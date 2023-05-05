-- 1) 查询销售总额前三的理财产品
--   请用一条SQL语句实现该查询：
select pyear,rank() over (partition by pyear order by sumamount desc) as rk,p_id,sumamount
from 
(
    (select year(pro_purchase_time) as pyear,p_id,sum(p_amount*pro_quantity) as sumamount
    from property,finances_product
    where pro_pif_id = p_id and pro_type=1 and (pro_purchase_time like "2010%")
    group by pyear,p_id
    order by sumamount desc
    limit 3)
    union
    (select year(pro_purchase_time) as pyear,p_id,sum(p_amount*pro_quantity) as sumamount
    from property,finances_product
    where pro_pif_id = p_id and pro_type=1 and (pro_purchase_time like "2011%")
    group by pyear,p_id
    order by sumamount desc
    limit 3) 
) as a(pyear,p_id,sumamount);
/*  end  of  your code  */