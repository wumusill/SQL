-- 코드를 입력하세요
SELECT
    USER_ID,
    NICKNAME,
    SUM(PRICE) AS TOTAL_SALES
FROM USED_GOODS_USER AS u
INNER JOIN (SELECT * FROM USED_GOODS_BOARD
            WHERE STATUS = "DONE") AS b
ON u.USER_ID = b.WRITER_ID
GROUP BY b.WRITER_ID
HAVING SUM(PRICE) >= 700000
ORDER BY TOTAL_SALES
