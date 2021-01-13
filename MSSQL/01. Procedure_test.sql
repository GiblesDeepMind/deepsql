-- 스칼라 변수에 값을 할당하는 경우
Declare @helloSet AS int;
set @helloSet = 101;

/* 서브 쿼리로 변수 할당*/
-- 스칼라 하위 쿼리 형태로 변수를 할당하는 경우
USE [AdventureWorks2019];
declare @empinfo as nvarchar(40); 
set @empinfo     = (select gender + '_' + jobTitle
					from [HumanResources].[Employee]
					where NationalIDNumber = '245797967');
select @empinfo as empinfo;

-- 두 개 이상의 정보를 할당하면 에러
declare @empinfo as nvarchar(40); 
set @empinfo     = (select gender + '_' + jobTitle
					from [HumanResources].[Employee]
					where gender = 'F');
select @empinfo as empinfo;

-- 한 번에 여러 정보를 할당
declare @geninfo as nvarchar(40), @jobinfo as nvarchar(40);
set @geninfo     = (select gender
					from [HumanResources].[Employee]
					where NationalIDNumber = '245797967');
set @jobinfo     = (select jobTitle
					from [HumanResources].[Employee]
					where NationalIDNumber = '245797967');
select @geninfo as gen, @jobinfo as job;					

-- 쿼리를 이용하여 변수 지정하기1
declare @geninfo as nvarchar(40), @jobinfo as nvarchar(40);
select @geninfo = gender
	 , @jobinfo = jobTitle
from [HumanResources].[Employee];
select @geninfo as gen, @jobinfo as job;					

-- 쿼리를 이용하여 변수 지정하기1
/*
조건에 여러 값들이 있어도 그 중 하나를 랜덤으로 출력 / SET을 지정하려면 반드시 스칼라 값만 들어가야 함
*/
declare @job1 as nvarchar(10)
select @job1 = jobtitle
from [HumanResources].[Employee]
where gender = 'M'
select @job1 as job

