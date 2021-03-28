-- 배치 "하나의 단위로 실행되는 구문들", 배치는 여러 트랜잭션으로 구성될 수 있다.
-- 만약, 복구가 필요하다면 트랜잭션 단위부터 시작한다.
-- 어떻게 실행되는가?
-- 1. 파싱단계(문법 검사) 2. 참조개체와 컬럼이 존재하는지 검사 -> 1과2에서 문제가 생기면 배치 실행이 안된다.

/* 여러 배치 종류 */

-- 1. 파싱 단위로서의 배치
print 'first'
use AdventureWorks2019

print 'Second'
select TOP(1000) * frm [Person].[AddressType] -- 문법적 오류가 있으면 실행되지 않는다.

-- 2. 배치와 변수, 변수는 해당 변수가 정의된 배치 내에서만 유효하다.
declare @i as int;
set @i = 10;
print @i;
go

print @i; -- 이때는 유효하지 않다.

-- 3. 배치 내에서 결합할 수 없는 구문, IF와 CREATE 관련된 구문은 서로 다른 배치에서 처리되도록 해야 한다.(create table은 한 구문 안에서 실행 가능)
if OBJECT_ID('Person.passwordtest', 'V') is not null drop view Person.passwordtest

create view Person.passwordtest
as

select * from [Person].[Address]
go

if OBJECT_ID('Person.passwordtest', 'V') is not null drop view Person.passwordtest
go -- if와 create view가 서로 다른 배치에서 실행되도록 go를 사용

create view Person.passwordtest
as

select * from [Person].[Address]
go

-- 4. 검사 단위로서의 배치, 배치 단위로 개체나 컬럼에 대한 검사가 수행된다.
if OBJECT_ID('dbo.C1', 'U') is not null drop table dbo.C1;
create table dbo.C1(col1 int);

alter table dbo.C1 ADD col2 int;
select col1, col2 from dbo.C1;

alter table dbo.C1 add col2 int;
go -- ddl과 dml을 서로 구분
select col1, col2 from dbo.C1

-- 5. GO n 옵션, 배치를 얼마나 많이 수행할 것인지 지정할 수 있는 입력 인자 옵션
if object_id('dbo.C1', 'U') is not null drop table dbo.C1;
create table dbo.C1(col1 int identity); -- col1은 identity 속성으로부터 자동으로 값을 발생시킨다.

set nocount on;-- dml문이 얼마나 많은 행을 처리했는지 표시되지 않게
insert into dbo.C1 default values;
go 100

select * from dbo.C1;
