-- 编写一存储过程，自动安排某个连续期间的大夜班的值班表:

delimiter $$
create procedure sp_night_shift_arrange(in start_date date, in end_date date)
begin
    declare done,tp,wk int default false;
    declare doc,nur1,nur2,head char(30);
    declare fetch_nur cursor for select e_name from employee where e_type = 3;
    declare fetch_doc cursor for select e_type ,e_name from employee where e_type!=3;
    declare continue handler for not found set done = true;
    open fetch_doc;
    open fetch_nur;
    while start_date<=end_date do
        fetch fetch_nur into nur1;
        if done then
            close fetch_nur;
            open fetch_nur;
            set done = false;
            fetch fetch_nur into nur1;
        end if;
        fetch fetch_nur into nur2;
        if done then
            close fetch_nur;
            open fetch_nur;
            set done = false;
            fetch fetch_nur into nur2;
        end if;
        set wk = weekday(start_date);
        if wk = 0 and head is not null then 
            set doc=head;
            set head=null;
        else
            fetch fetch_doc into tp,doc;
            if done then
                close fetch_doc;
                open fetch_doc;
                set done = false;
                fetch fetch_doc into tp,doc;
            end if;
            if wk>4 and tp =1 then 
                set head = doc;
                fetch fetch_doc into tp, doc;
                if done then
                    close fetch_doc;
                    open fetch_doc;
                    set done = false;
                    fetch fetch_doc into tp,doc;
                end if;
            end if;
        end if;
        insert into night_shift_schedule values (start_date, doc, nur1, nur2);
        set start_date = date_add(start_date, interval 1 day);
    end while;
end$$

delimiter ;

/*  end  of  your code  */ 
