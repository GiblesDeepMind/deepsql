-- CROSS JOIN
SELECT A.personID info_ID
     , B.personID purchase_ID
FROM user_info A, purchase_order B;

-- CROSS JOIN (ANSI)
SELECT A.personID info_ID
     , B.personID purchase_ID
FROM user_info A
CROSS JOIN purchase_order B;

-- INNER JOIN
SELECT A.personID info_ID
     , B.personID purchase_ID
FROM user_info A, purchase_order B
WHERE A.personID = B.personID
order by 1;

-- INNER JOIN(ANSI)
SELECT A.personID info_ID
     , B.personID purchase_ID
FROM user_info A
INNER JOIN purchase_order B
ON A.personID = B.personID
order by 1;

-- LEFT OUTER JOIN
SELECT A.personID info_ID
     , B.personID purchase_ID
FROM user_info A, purchase_order B
WHERE A.personID = B.personID(+)
order by 1;

-- LEFT OUTER JOIN(ANSI)
SELECT A.personID info_ID
     , B.personID purchase_ID
FROM user_info A
LEFT OUTER JOIN purchase_order B
ON A.personID = B.personID
order by 1;
