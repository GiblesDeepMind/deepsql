/*
딥상어동의 딥한 쿼리<10장 - Group By 쿼리>
*/

-- 날짜 형식 데이터 파라미터 수정
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

/*
-- 데이터 활용을 위해 0을 NULL로 업데이트
UPDATE customerorder
SET 
unit_price = NULL,
total_price = NULL
WHERE
unit_price = 0
and total_price = 0;
*/

/*데이터 구조 확인*/;

SELECT COUNT(*)
     , COUNT(name)
     , COUNT(distinct name)
     , COUNT(unit_price)
     , COUNT(NVL(unit_price, 0)) -- 값을 지정해주니 다시 카운트
FROM customerorder;

/*고객별 구매 수량*/
SELECT name
     , SUM(QUANTITY)
FROM customerorder
GROUP BY name;

SELECT MAX(sum_quantity)
FROM ( 
    SELECT name
         , SUM(QUANTITY) as sum_quantity
    FROM customerorder
    GROUP BY name
    ) A

-- 가장 많이 상품을 구매한 고객, row_number 활용
SELECT name, sum_quantity
FROM ( 
    SELECT name
         , SUM(QUANTITY) as sum_quantity
         , row_number() over(order by SUM(QUANTITY) desc) row_nums
    FROM customerorder
    GROUP BY name
    ) A
where row_nums = 1;

--연도별 구매 수량 합계
SELECT TO_CHAR(order_date, 'YYYY') order_year
     , SUM(quantity) sum_quantity
FROM customerorder
GROUP BY TO_CHAR(order_date, 'YYYY')
ORDER BY order_year; -- 약어는 order by 절에서만 사용 가능

--DECODE 사용
SELECT name
     , SUM(DECODE(TO_CHAR(order_date, 'YYYY'), '2013', quantity)) AS sumQuan_2013
     , SUM(DECODE(TO_CHAR(order_date, 'YYYY'), '2014', quantity)) AS sumQuan_2014
FROM customerorder
GROUP BY name;

/*GROUP BY절 확장*/

-- /*ROLLUP
SELECT NVL(name, 'total') AS new_name
     -- COALESCE(name, 'total') AS new_name2
     , COUNT(item_no) as cnt_item
FROM customerorder
WHERE quantity >= 100
GROUP BY ROLLUP(name);

-- 굳이 엑셀 작업을 거치지 않고 최종 결과를 출력할 때
-- concatenated grouping이라고 하기도 함
SELECT name
     , COALESCE(item_no, 'total') AS item_no
     --, TO_CHAR(order_date, 'YYYY') AS year
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY name, ROLLUP(item_no);


--ROLLUP에는 명백한 위계가 존재, name만 토탈을 정리
SELECT NVL(name, 'total') AS new_name
     , COALESCE(item_no, 'total') AS item_no
     --, TO_CHAR(order_date, 'YYYY') AS year
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY ROLLUP(name, item_no);

-- /*CUBE
-- cube에는 위계가 없다. name과 item_no 모두 토탈을 정리
SELECT NVL(name, 'total') AS new_name
     , COALESCE(item_no, 'total') AS item_no
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY CUBE(name, item_no);

-- /* GROUPING SETS
-- 결과를 열별로 각각 집계
SELECT NVL(name, 'groupingSets_null') AS new_name
     , COALESCE(item_no, 'groupingSets_null') AS item_no
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY GROUPING SETS(name, item_no);

-- 특정 이름으로 결과 비교
SELECT SUM(quantity)
FROM customerorder
where name = 'AIRBUS OPERATIONS GMBH'
and quantity >= 100;

-- ROLLUP IN GROUPING SETS
SELECT NVL(name, 'groupingSets_null') AS new_name
     , COALESCE(item_no, 'groupingSets_null') AS item_no
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY GROUPING SETS(name, ROLLUP(item_no));

-- /* 조합열 - composite column 하나의 단위로 처리
SELECT NVL(name, 'total') AS new_name
     , COALESCE(item_no, 'total') AS item_no
     --, TO_CHAR(order_date, 'YYYY') AS year
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY ROLLUP(name, item_no);

-- composite column
SELECT NVL(name, 'total') AS new_name
     , COALESCE(item_no, 'total') AS item_no
     --, TO_CHAR(order_date, 'YYYY') AS year
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY ROLLUP((name, item_no)); -- composite column

-- Grouping 함수, GROUPING_ID 추후 필요 시 공부

/*HAVING 절*/
-- GROUP BY에 조건 사용
SELECT TO_CHAR(order_date, 'YYYY') order_year
     , SUM(quantity) sum_quantity
FROM customerorder
GROUP BY TO_CHAR(order_date, 'YYYY')
HAVING SUM(quantity) > 100;

