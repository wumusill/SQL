-- 코드를 입력하세요
SELECT
    t.AUTHOR_ID,
    AUTHOR_NAME,
    CATEGORY,
    SUM(TOTAL) AS TOTAL_SALES
FROM (
    SELECT
        b.BOOK_ID,
        CATEGORY,
        AUTHOR_ID,
        PRICE,
        SUM(SALES) AS SUM_SALES,
        (PRICE * SUM(SALES)) AS TOTAL
    FROM BOOK AS b
    INNER JOIN BOOK_SALES AS s
    ON b.BOOK_ID = s.BOOK_ID
    WHERE YEAR(SALES_DATE) = '2022' AND MONTH(SALES_DATE) = '1'
    GROUP BY BOOK_ID
) AS t
INNER JOIN AUTHOR AS a
ON t.AUTHOR_ID = a.AUTHOR_ID
GROUP BY AUTHOR_NAME, CATEGORY
ORDER BY AUTHOR_ID, CATEGORY DESC