-- ��ġ "�ϳ��� ������ ����Ǵ� ������", ��ġ�� ���� Ʈ��������� ������ �� �ִ�.
-- ����, ������ �ʿ��ϴٸ� Ʈ����� �������� �����Ѵ�.
-- ��� ����Ǵ°�?
-- 1. �Ľ̴ܰ�(���� �˻�) 2. ������ü�� �÷��� �����ϴ��� �˻� -> 1��2���� ������ ����� ��ġ ������ �ȵȴ�.

/* ���� ��ġ ���� */

-- 1. �Ľ� �����μ��� ��ġ
print 'first'
use AdventureWorks2019

print 'Second'
select TOP(1000) * frm [Person].[AddressType] -- ������ ������ ������ ������� �ʴ´�.

-- 2. ��ġ�� ����, ������ �ش� ������ ���ǵ� ��ġ �������� ��ȿ�ϴ�.
declare @i as int;
set @i = 10;
print @i;
go

print @i; -- �̶��� ��ȿ���� �ʴ�.

-- 3. ��ġ ������ ������ �� ���� ����, IF�� CREATE ���õ� ������ ���� �ٸ� ��ġ���� ó���ǵ��� �ؾ� �Ѵ�.(create table�� �� ���� �ȿ��� ���� ����)
if OBJECT_ID('Person.passwordtest', 'V') is not null drop view Person.passwordtest

create view Person.passwordtest
as

select * from [Person].[Address]
go

if OBJECT_ID('Person.passwordtest', 'V') is not null drop view Person.passwordtest
go -- if�� create view�� ���� �ٸ� ��ġ���� ����ǵ��� go�� ���

create view Person.passwordtest
as

select * from [Person].[Address]
go

-- 4. �˻� �����μ��� ��ġ, ��ġ ������ ��ü�� �÷��� ���� �˻簡 ����ȴ�.
if OBJECT_ID('dbo.C1', 'U') is not null drop table dbo.C1;
create table dbo.C1(col1 int);

alter table dbo.C1 ADD col2 int;
select col1, col2 from dbo.C1;

alter table dbo.C1 add col2 int;
go -- ddl�� dml�� ���� ����
select col1, col2 from dbo.C1

-- 5. GO n �ɼ�, ��ġ�� �󸶳� ���� ������ ������ ������ �� �ִ� �Է� ���� �ɼ�
if object_id('dbo.C1', 'U') is not null drop table dbo.C1;
create table dbo.C1(col1 int identity); -- col1�� identity �Ӽ����κ��� �ڵ����� ���� �߻���Ų��.

set nocount on;-- dml���� �󸶳� ���� ���� ó���ߴ��� ǥ�õ��� �ʰ�
insert into dbo.C1 default values;
go 100

select * from dbo.C1;
