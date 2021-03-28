/*
0. 변수
*/

-- 변수할당1
declare @i AS int;
set @i = 10;

-- 변수할당2
declare @j as int = 10;

/*변수할당3*/
use AdventureWorks2019;

declare @empname as nvarchar(30);

-- 하위 쿼리 형태의 스칼라, 한 번에 하나의 변수만 지정 가능 
set @empname = 
		(select firstname + ' ' + LastName
		 from person.person
		 where BusinessEntityID = 3);

select @empname as empname;

/*SELECT 구문을 이용한 변수 할당*/
declare @firstname as nvarchar(20), @lastname as nvarchar(20); -- declare구문에는 여러개 할당 가능

select
	  @firstname = firstname
	, @lastname = lastname
from person.person
where BusinessEntityID = 3;

select @firstname as firstname, @lastname as lastname;


/*
1. 배치
- sql server로 전달되는 하나 또는 그 이상의 구문
_ 파싱(문법 검사) -> 참조 개체, 컬럼 존재 확인 -> 권한 검사 -> 단일 유닛으로 최적화
*/

-- 유효 배치
print 'first batch'
select *
from person.person
go

-- 배치와 변수
declare @k as int;
set @k = 10;

print @k; 

/*배치 내에서 결합할 수 없는 구문*/
-- create default, create function, create procedure, create rule, create schema, create trigger, create view는 독립적인 구문으로 처리

if object_id('person.test', 'V') is not null drop view person.test;
go

create view person.test 
as (select *
	from person.person)
go

--ddl과 dml문을 분리
if object_id('dbo.T1', 'U') is not null drop table dbo.t1;
go

create table dbo.T1(col1 int); 
go

alter table dbo.t1 add col2 int;
go

select col1, col2
from dbo.t1; 
go

/*Go N옵션 - 배치의 끝, 배치를 몇회 실행할 것인지 인자 지정 가능*/
if object_id('dbo.t1', 'U') is not null drop table dbo.t1;
create table dbo.t1(col1 int identity); -- identity 속성으로부터 자동으로 값을 발생 시킴

set nocount on;

insert into dbo.t1 default values;
go 100

select * from dbo.t1;

/*
3. 흐름제어요소
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

--while 흐름 제어 요소
declare @i as int = 1;
while @i <= 10
begin 
	print @i;
	set @i = @i + 1;
end ;

--특정 구간에서 종료
declare @k as int = 1;
while @k <= 10
begin
	if @k = 6 break;
	print @k;
	set @k = @k + 1;
end;

--특정 구간 건너뛰기
declare @p as int = 0;
while @p < 10
begin
	set @p = @p + 1;
	if @p = 6 continue;
	print @p;
end;

--if, while 조합 | dbo.Numbers라는 테이블 생성 후 n 컬럼에 1~1000 숫자 저장
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

--커서 처리 단계
/*
1. 쿼리를 기반으로 하는 커서를 정의한다.
2. 커서를 연다.
3. 첫 번째, 커서 레코드의 특성 값들을 변수들에 저장한다.
4. 커서가 마지막에 도달할 때까지 커서 레코드들에 대한 루프를 반복한다. 
   루프가 반복될 때마다 현재 커서 레코드의 특성 값들을 변수들에 저장하고, 현재 행에 대해 필요한 처리 작업을 수행한다.
5. 커서를 닫는다.
6. 커서를 해제한다.
*/