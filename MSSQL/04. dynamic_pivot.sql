/*
0. µ¿Àû SQL
*/

create table #temp2
(
    date datetime,
    category varchar(3),
    amount money
)

insert into #temp2 values ('1/1/2012', 'ABC', 1000.00)
insert into #temp2 values ('2/1/2012', 'DEF', 500.00)
insert into #temp2 values ('2/1/2012', 'GHI', 800.00)
insert into #temp2 values ('2/10/2012', 'DEF', 700.00)
insert into #temp2 values ('3/1/2012', 'ABC', 1100.00)

select * from #temp2

declare @cols as nvarchar(Max) = '';
declare @query as nvarchar(Max) = '';

SELECT @cols = @cols + QUOTENAME(category) + ',' FROM (select distinct category from #temp ) as tmp

select @cols = substring(@cols, 0, len(@cols)) --trim "," at end
print @cols

set @query = 
'SELECT * from 
(
    select date, amount, category from #temp
) src
pivot 
(
    max(amount) for category in (' + @cols + ')
) piv'

execute(@query)
drop table #temp