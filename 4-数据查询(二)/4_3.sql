   -- 3) 查询购买了所有畅销理财产品的客户
--   请用一条SQL语句实现该查询：

SELECT DISTINCT
	client.c_id AS pro_c_id
FROM
	client
WHERE
	NOT EXISTS(
	SELECT
			finances_product.p_id , 
			COUNT(property.pro_c_id) AS num_of_client
		FROM
			finances_product
			INNER JOIN
			property
			ON 
				finances_product.p_id = property.pro_pif_id
		WHERE
			property.pro_type = 1 AND 
			finances_product.p_id NOT IN ( SELECT property1.pro_pif_id FROM property property1 WHERE property1.pro_type = 1 AND property1.pro_c_id = client.c_id ) 
		GROUP BY
			finances_product.p_id
		HAVING
			num_of_client > 2
	)
ORDER BY
	client.c_id ASC
/*  end  of  your code  */