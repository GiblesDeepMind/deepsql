-- TSQL에서는 IF, ELSE, WHILE 정도만 사용

/* 흐름 제어 요소 */

-- 1. IF...ELSE 흐름 제어 요소

if year(sysdatetime()) <> year(dateadd(day, 1, sysdatetime()))
	print 'this is the last day'
else -- 술어가 false 또는 unknown일 때 실행 
	print 'not yet'



