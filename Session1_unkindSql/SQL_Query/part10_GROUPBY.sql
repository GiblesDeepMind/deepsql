/*
������ ���� ����<10�� - Group By ����>
*/

-- ��¥ ���� ������ �Ķ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

/*
-- ������ Ȱ���� ���� 0�� NULL�� ������Ʈ
UPDATE customerorder
SET 
unit_price = NULL,
total_price = NULL
WHERE
unit_price = 0
and total_price = 0;
*/

/*������ ���� Ȯ��*/;

SELECT COUNT(*)
     , COUNT(name)
     , COUNT(distinct name)
     , COUNT(unit_price)
     , COUNT(NVL(unit_price, 0)) -- ���� �������ִ� �ٽ� ī��Ʈ
FROM customerorder;

/*���� ���� ����*/
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

-- ���� ���� ��ǰ�� ������ ��, row_number Ȱ��
SELECT name, sum_quantity
FROM ( 
    SELECT name
         , SUM(QUANTITY) as sum_quantity
         , row_number() over(order by SUM(QUANTITY) desc) row_nums
    FROM customerorder
    GROUP BY name
    ) A
where row_nums = 1;

--������ ���� ���� �հ�
SELECT TO_CHAR(order_date, 'YYYY') order_year
     , SUM(quantity) sum_quantity
FROM customerorder
GROUP BY TO_CHAR(order_date, 'YYYY')
ORDER BY order_year; -- ���� order by �������� ��� ����

--DECODE ���
SELECT name
     , SUM(DECODE(TO_CHAR(order_date, 'YYYY'), '2013', quantity)) AS sumQuan_2013
     , SUM(DECODE(TO_CHAR(order_date, 'YYYY'), '2014', quantity)) AS sumQuan_2014
FROM customerorder
GROUP BY name;

/*GROUP BY�� Ȯ��*/

-- /*ROLLUP
SELECT NVL(name, 'total') AS new_name
     -- COALESCE(name, 'total') AS new_name2
     , COUNT(item_no) as cnt_item
FROM customerorder
WHERE quantity >= 100
GROUP BY ROLLUP(name);

-- ���� ���� �۾��� ��ġ�� �ʰ� ���� ����� ����� ��
-- concatenated grouping�̶�� �ϱ⵵ ��
SELECT name
     , COALESCE(item_no, 'total') AS item_no
     --, TO_CHAR(order_date, 'YYYY') AS year
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY name, ROLLUP(item_no);


--ROLLUP���� ����� ���谡 ����, name�� ��Ż�� ����
SELECT NVL(name, 'total') AS new_name
     , COALESCE(item_no, 'total') AS item_no
     --, TO_CHAR(order_date, 'YYYY') AS year
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY ROLLUP(name, item_no);

-- /*CUBE
-- cube���� ���谡 ����. name�� item_no ��� ��Ż�� ����
SELECT NVL(name, 'total') AS new_name
     , COALESCE(item_no, 'total') AS item_no
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY CUBE(name, item_no);

-- /* GROUPING SETS
-- ����� ������ ���� ����
SELECT NVL(name, 'groupingSets_null') AS new_name
     , COALESCE(item_no, 'groupingSets_null') AS item_no
     , SUM(quantity) as sum_quan
FROM customerorder
WHERE quantity >= 100
GROUP BY GROUPING SETS(name, item_no);

-- Ư�� �̸����� ��� ��
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

-- /* ���տ� - composite column �ϳ��� ������ ó��
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

-- Grouping �Լ�, GROUPING_ID ���� �ʿ� �� ����

/*HAVING ��*/
-- GROUP BY�� ���� ���
SELECT TO_CHAR(order_date, 'YYYY') order_year
     , SUM(quantity) sum_quantity
FROM customerorder
GROUP BY TO_CHAR(order_date, 'YYYY')
HAVING SUM(quantity) > 100;

