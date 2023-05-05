-- 16) 查询持有相同基金组合的客户对，如编号为A的客户持有的基金，编号为B的客户也持有，反过来，编号为B的客户持有的基金，编号为A的客户也持有，则(A,B)即为持有相同基金组合的二元组，请列出这样的客户对。为避免过多的重复，如果(1,2)为满足条件的元组，则不必显示(2,1)，即只显示编号小者在前的那一对，这一组客户编号分别命名为c_id1,c_id2。
with t(c_id, f_id) as (
    select
        pro_c_id c_id,
        group_concat(distinct pro_pif_id order by pro_pif_id) as f_id
    from property
    where pro_type = 3
    group by pro_c_id
)
select
    t1.c_id as c_id1,
    t2.c_id as c_id2
from t t1, t t2
where t1.c_id < t2.c_id
and t1.f_id = t2.f_id;

/*  这条SQL语句的作用是查询在持有相同的物业时有相似购买行为的客户对。

首先，使用WITH语句定义了一个名为t的公共表达式，它包含两个列：c_id和f_id。这个公共表达式通过对物业表进行筛选和聚合操作，找出了所有物业类型为3的客户和他们持有的物业编号列表。其中，使用group_concat函数将同一客户持有的物业编号拼接成一个字符串，便于后续比较。

接着，在SELECT语句中，我们将t表自连接两次，使用t1表示第一个客户，t2表示第二个客户。在WHERE子句中，我们使用条件限制了客户编号较小的组合，并通过f_id列进行匹配，找出了持有相同物业的客户对。

最后，在SELECT子句中，我们使用AS关键字为新添加的列指定别名，即c_id1和c_id2，分别表示客户编号小的放在前面，客户编号大的放在后面。

请注意，这条SQL语句假设物业表至少包含pro_c_id、pro_pif_id和pro_type三列，您需要根据实际情况来调整查询中的表和列名称。 */