use fib;

-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

drop procedure if exists sp_fibonacci;
delimiter $$
create procedure sp_fibonacci(in m int)
begin
######## 请补充代码完成存储过程体 ########
    declare i bigint default 0;
    declare j bigint default 1;
    declare k bigint default 0;
    declare t bigint default 0;
    while k < m do
    insert into fibonacci(n, fibn) value(k, i);
    set t = i + j;
    set i = j;
    set j = t;
    set k = k+1;
    end while;

end $$

delimiter ;

 
