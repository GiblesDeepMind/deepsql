-- TSQL������ IF, ELSE, WHILE ������ ���

/* �帧 ���� ��� */

-- 1. IF...ELSE �帧 ���� ���

if year(sysdatetime()) <> year(dateadd(day, 1, sysdatetime()))
	print 'this is the last day'
else -- ��� false �Ǵ� unknown�� �� ���� 
	print 'not yet'



