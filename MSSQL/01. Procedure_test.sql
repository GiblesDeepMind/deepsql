-- ��Į�� ������ ���� �Ҵ��ϴ� ���
Declare @helloSet AS int;
set @helloSet = 101;

/* ���� ������ ���� �Ҵ�*/
-- ��Į�� ���� ���� ���·� ������ �Ҵ��ϴ� ���
USE [AdventureWorks2019];
declare @empinfo as nvarchar(40); 
set @empinfo     = (select gender + '_' + jobTitle
					from [HumanResources].[Employee]
					where NationalIDNumber = '245797967');
select @empinfo as empinfo;

-- �� �� �̻��� ������ �Ҵ��ϸ� ����
declare @empinfo as nvarchar(40); 
set @empinfo     = (select gender + '_' + jobTitle
					from [HumanResources].[Employee]
					where gender = 'F');
select @empinfo as empinfo;

-- �� ���� ���� ������ �Ҵ�
declare @geninfo as nvarchar(40), @jobinfo as nvarchar(40);
set @geninfo     = (select gender
					from [HumanResources].[Employee]
					where NationalIDNumber = '245797967');
set @jobinfo     = (select jobTitle
					from [HumanResources].[Employee]
					where NationalIDNumber = '245797967');
select @geninfo as gen, @jobinfo as job;					

-- ������ �̿��Ͽ� ���� �����ϱ�1
declare @geninfo as nvarchar(40), @jobinfo as nvarchar(40);
select @geninfo = gender
	 , @jobinfo = jobTitle
from [HumanResources].[Employee];
select @geninfo as gen, @jobinfo as job;					

-- ������ �̿��Ͽ� ���� �����ϱ�1
/*
���ǿ� ���� ������ �־ �� �� �ϳ��� �������� ��� / SET�� �����Ϸ��� �ݵ�� ��Į�� ���� ���� ��
*/
declare @job1 as nvarchar(10)
select @job1 = jobtitle
from [HumanResources].[Employee]
where gender = 'M'
select @job1 as job

