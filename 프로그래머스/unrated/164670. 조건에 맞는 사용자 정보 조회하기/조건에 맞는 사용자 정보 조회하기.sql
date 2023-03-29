-- 코드를 입력하세요
SELECT 
    USER_ID, 
    NICKNAME, 
    CONCAT(CITY, " ", STREET_ADDRESS1, " ", STREET_ADDRESS2) AS 전체주소,
    CONCAT(LEFT(TLNO, 3), "-", MID(TLNO, 4, 4), "-", RIGHT(TLNO, 4)) AS 전화번호
FROM USED_GOODS_USER AS u
LEFT JOIN (SELECT WRITER_ID, COUNT(WRITER_ID) AS cnt
            FROM USED_GOODS_BOARD
            GROUP BY WRITER_ID) AS b
ON u.USER_ID = b.WRITER_ID
WHERE b.cnt >= 3
ORDER BY USER_ID DESC
    