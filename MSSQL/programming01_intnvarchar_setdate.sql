declare @name as nvarchar(20) = 'tname';
declare @j as int = 1;

while @j <= 10
begin
	print @name + cast(@j as nvarchar);
	set @j = @j + 1;
end

--2
declare @date1 as date = '2021-03-02';
while @date1 <= cast('2021-03-20' as date) 
begin
	print @date1
	set @date1 = (select dateadd(dd, 1, @date1) as date3)
end;

