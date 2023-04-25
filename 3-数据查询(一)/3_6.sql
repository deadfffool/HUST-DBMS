select pro_income , count(pro_income) as presence
from property
group by pro_income
having presence >= all(select count(pro_income) from property group by pro_income);