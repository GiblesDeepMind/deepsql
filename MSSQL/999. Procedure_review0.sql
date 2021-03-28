/*
0. ����
*/

-- �����Ҵ�1
declare @i AS int;
set @i = 10;

-- �����Ҵ�2
declare @j as int = 10;

/*�����Ҵ�3*/
use AdventureWorks2019;

declare @empname as nvarchar(30);

-- ���� ���� ������ ��Į��, �� ���� �ϳ��� ������ ���� ���� 
set @empname = 
		(select firstname + ' ' + LastName
		 from person.person
		 where BusinessEntityID = 3);

select @empname as empname;

/*SELECT ������ �̿��� ���� �Ҵ�*/
declare @firstname as nvarchar(20), @lastname as nvarchar(20); -- declare�������� ������ �Ҵ� ����

select
	  @firstname = firstname
	, @lastname = lastname
from person.person
where BusinessEntityID = 3;

select @firstname as firstname, @lastname as lastname;


/*
1. ��ġ
- sql server�� ���޵Ǵ� �ϳ� �Ǵ� �� �̻��� ����
_ �Ľ�(���� �˻�) -> ���� ��ü, �÷� ���� Ȯ�� -> ���� �˻� -> ���� �������� ����ȭ
*/

-- ��ȿ ��ġ
print 'first batch'
select *
from person.person
go

-- ��ġ�� ����
declare @k as int;
set @k = 10;

print @k; 

/*��ġ ������ ������ �� ���� ����*/
-- create default, create function, create procedure, create rule, create schema, create trigger, create view�� �������� �������� ó��

if object_id('person.test', 'V') is not null drop view person.test;
go

create view person.test 
as (select *
	from person.person)
go

--ddl�� dml���� �и�
if object_id('dbo.T1', 'U') is not null drop table dbo.t1;
go

create table dbo.T1(col1 int); 
go

alter table dbo.t1 add col2 int;
go

select col1, col2
from dbo.t1; 
go

/*Go N�ɼ� - ��ġ�� ��, ��ġ�� ��ȸ ������ ������ ���� ���� ����*/
if object_id('dbo.t1', 'U') is not null drop table dbo.t1;
create table dbo.t1(col1 int identity); -- identity �Ӽ����κ��� �ڵ����� ���� �߻� ��Ŵ

set nocount on;

insert into dbo.t1 default values;
go 100

select * from dbo.t1;

/*
3. �帧������
*/

if year(sysdatetime()) = year(dateadd(day, 1, sysdatetime())) 
	print 'last day of this year';
else
	print 'not last day of this year';

print sysdatetime()


if year(sysdatetime()) = year(dateadd(day, 1, sysdatetime())) 
	print 'last day of this year';
else
	if month(sysdatetime()) = month(dateadd(day, 1, sysdatetime()))
		print 'not last day of this year but last day of this month'
	else 
		print 'not last day of this year and not last day of this month'

-- begin end
if day(sysdatetime()) = 1
begin
	print 'today is the first day of this month'
	print 'begin first day process'
	/* process code */
	print 'end first day process'
end
else
begin
	print 'today is not the first day of this month'
	print 'begin after first day process'
	/* process code */
	print 'end after first day process'
end

--while �帧 ���� ���
declare @i as int = 1;
while @i <= 10
begin 
	print @i;
	set @i = @i + 1;
end ;

--Ư�� �������� ����
declare @k as int = 1;
while @k <= 10
begin
	if @k = 6 break;
	print @k;
	set @k = @k + 1;
end;

--Ư�� ���� �ǳʶٱ�
declare @p as int = 0;
while @p < 10
begin
	set @p = @p + 1;
	if @p = 6 continue;
	print @p;
end;

--if, while ���� | dbo.Numbers��� ���̺� ���� �� n �÷��� 1~1000 ���� ����
set nocount on;
if object_id('dbo.numbers', 'U') is not null drop table dbo.numbers;
go

create table dbo.numbers(n int not null primary key);
go

declare @i as int = 1;
while @i <= 1000
begin
	insert into dbo.numbers(n) values(@i);
	set @i = @i + 1;
end

select * from dbo.numbers;

--Ŀ�� ó�� �ܰ�
/*
1. ������ ������� �ϴ� Ŀ���� �����Ѵ�.
2. Ŀ���� ����.
3. ù ��°, Ŀ�� ���ڵ��� Ư�� ������ �����鿡 �����Ѵ�.
4. Ŀ���� �������� ������ ������ Ŀ�� ���ڵ�鿡 ���� ������ �ݺ��Ѵ�. 
   ������ �ݺ��� ������ ���� Ŀ�� ���ڵ��� Ư�� ������ �����鿡 �����ϰ�, ���� �࿡ ���� �ʿ��� ó�� �۾��� �����Ѵ�.
5. Ŀ���� �ݴ´�.
6. Ŀ���� �����Ѵ�.
*/