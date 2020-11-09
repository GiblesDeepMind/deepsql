-- NATURAL JOIN
SELECT * FROM user_info NATURAL JOIN purchase_order;

-- USING
SELECT * FROM user_info JOIN purchase_order USING(personID);

-- #1. Outer Join ON_Condition 조건 -> 실제 Outer Join
SELECT A.*
     , B.*
FROM user_info A
LEFT JOIN purchase_order B
ON A.personid < 3
AND A.personid = B.personid;

-- #2. Outer Join WHERE 조건 -> INNER JOIN으로 들어감
SELECT A.*
     , B.*
FROM user_info A
LEFT JOIN purchase_order B
ON A.personid = B.personid
WHERE A.personid < 3;

-- #1과 동치
SELECT A.*
     , B.*
FROM user_info A, purchase_order B
WHERE A.personid < 
    CASE WHEN B.personid(+) IS NOT NULL THEN 3 ELSE 3 END
AND B.personid(+) = A.personid;

-- #2와 동치
SELECT A.*
     , B.*
FROM user_info A, purchase_order B
WHERE B.personid(+) = A.personid
AND A.personid < 3;

/*번외*/
-- 아우터 기준이 아닌 테이블의 일반 조건
SELECT A.*
     , B.*
FROM user_info A
LEFT JOIN purchase_order B
ON A.personid = B.personid
AND B.personid < 3;

SELECT A.*
     , B.*
FROM user_info A, purchase_order B
WHERE B.personid(+) = A.personid
AND B.personid(+) < 3;