
-- #1���ڿ��� ���鸸 �ִ� ���
create table ex (
	string VARCHAR(1000)
);

insert into ex (string) values ('');
insert into ex (string) values ('12');
insert into ex (string) values ('234');
insert into ex (string) values ('345');

select *
from ex

-- #1 ���ڿ��� ���ڿ��� �ٲٱ�

select cast(string as int) + 1
from ex;

select case when string = '' then 0 else cast(string as bigint) end as string_to_int1
into #case1
from ex;

select string_to_int1 + 1
from #case1;

select cast(replace(string, '', '0')  as int) as string_to_int2
into #case2
from ex;

select string_to_int2 + 1
from #case2;

-- �����׽�Ʈ
select cast('' as int)
select cast(' ' as int)
select cast('  ' as int)

-- #2 ���� �ܿ� �ٸ� ���ڿ��� �ִ� ���
create table ex2 (
	string VARCHAR(1000)
);

insert into ex2 (string) values ('');
insert into ex2 (string) values ('12');
insert into ex2 (string) values ('Į��');
insert into ex2 (string) values ('234');
insert into ex2 (string) values ('345');

select *
from ex2

-- ���� �߻�
select cast(string as bigint)
from ex2



select distinct string
	 , ISNUMERIC(string) checkNum
from ex2

select string
	 , case when (ISNUMERIC(string) = 1) then string
			else 0
	   end as v
from ex2