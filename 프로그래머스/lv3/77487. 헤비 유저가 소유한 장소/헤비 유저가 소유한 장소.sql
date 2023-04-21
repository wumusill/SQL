-- 코드를 입력하세요
SELECT
    ID,
    NAME,
    a.HOST_ID
FROM PLACES AS a
RIGHT JOIN (
    SELECT
        HOST_ID,
        COUNT(*) AS cnt
    FROM PLACES
    GROUP BY HOST_ID
    HAVING cnt > 1
) AS b
ON a.HOST_ID = b.HOST_ID
ORDER BY ID