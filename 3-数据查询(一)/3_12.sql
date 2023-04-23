 -- 12) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、保险表(insurance)和
 --     基金表(fund)，列出客户的名称、身份证号以及投资总金额（即投资本金，
 --     每笔投资金额=商品数量*该产品每份金额)，注意投资金额按类型需要查询不同的表，
 --     投资总金额是客户购买的各类资产(理财,保险,基金)投资金额的总和，总金额命名为total_amount。
 --     查询结果按总金额降序排序。
 -- 请用一条SQL语句实现该查询：

select c_name, c_id_card, sum(amount) as total_amount
from
    (select c_name, c_id_card, c_id, sum(p_amount * pro_quantity) as amount
    from client, finances_product, property
    where
        pro_pif_id = p_id and pro_c_id = c_id and pro_type = 1
    group by c_id

    union
    select c_name, c_id_card, c_id, sum(i_amount * pro_quantity) as amount
    from client, insurance, property
    where
    pro_pif_id = i_id and pro_c_id = c_id and pro_type = 2
    group by c_id

    union
    select c_name, c_id_card, c_id, sum(f_amount * pro_quantity) as amount
    from client, fund, property
    where 
    pro_pif_id = f_id and pro_c_id = c_id and pro_type = 3
    group by c_id
    
    union 
    select c_name, c_id_card, c_id, 0
    from client left outer join property on (c_id = pro_c_id)
    where
        pro_c_id is NULL
    ) 
    as amount_all(c_name, c_id_card, c_id, amount)


group by c_id, c_id_card, c_name
order by total_amount desc;


/*  end  of  your code  */ 