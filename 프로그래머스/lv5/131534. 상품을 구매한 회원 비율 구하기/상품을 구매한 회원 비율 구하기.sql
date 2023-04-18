-- 코드를 입력하세요
SELECT
    YEAR(SALES_DATE) AS YEAR,
    MONTH(SALES_DATE) AS MONTH,
    COUNT(DISTINCT s.USER_ID) AS PUCHASED_USERS, 
    ROUND(COUNT(DISTINCT s.USER_ID) / (SELECT
                                            COUNT(*)
                                        FROM USER_INFO
                                        WHERE YEAR(JOINED) = '2021'), 1) AS PUCHASED_RATIO
FROM ONLINE_SALE AS s
INNER JOIN (
    SELECT
        USER_ID
    FROM USER_INFO
    WHERE YEAR(JOINED) = '2021'
) AS u
ON s.USER_ID = u.USER_ID
GROUP BY YEAR(SALES_DATE), MONTH(SALES_DATE)