-- 코드를 입력하세요
SELECT
    HISTORY_ID,
    ROUND(a.DAILY_FEE * (1 - IFNULL(b.DISCOUNT_RATE / 100, 0)) * a.PERIOD, 0) AS FEE
FROM (
    SELECT 
        HISTORY_ID,
        h.CAR_ID,
        c.CAR_TYPE,
        c.DAILY_FEE,
        DATEDIFF(END_DATE, START_DATE) + 1 AS PERIOD,
        CASE 
            WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 90 THEN '90일 이상'
            WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 30 THEN '30일 이상'
            WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 7 THEN '7일 이상'
        END AS DURATION_TYPE
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY AS h
    INNER JOIN CAR_RENTAL_COMPANY_CAR AS c
    ON h.CAR_ID = c.CAR_ID
) AS a
LEFT JOIN (
    SELECT
        DURATION_TYPE,
        DISCOUNT_RATE
    FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
    WHERE CAR_TYPE = "트럭"
) AS b
ON a.DURATION_TYPE = b.DURATION_TYPE
WHERE a.CAR_TYPE = "트럭"
ORDER BY FEE DESC, HISTORY_ID DESC