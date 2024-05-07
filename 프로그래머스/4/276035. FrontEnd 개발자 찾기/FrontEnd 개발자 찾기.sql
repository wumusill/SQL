-- 서브쿼리와 비트연산 활용
# SELECT
#     ID,
#     EMAIL,
#     FIRST_NAME,
#     LAST_NAME
# FROM DEVELOPERS
# WHERE SKILL_CODE & (
#     SELECT SUM(CODE) 
#     FROM SKILLCODES 
#     WHERE CATEGORY = 'Front End'
# )
# ORDER BY ID

-- WITH, JOIN 활용 
WITH FE AS (
    SELECT
        *
    FROM
        SKILLCODES
    WHERE
        CATEGORY = 'Front End'
)

-- 한 개발자가 여러 개의 FE 기술을 갖고 있어도 하나만 출력되도록 하기 위해 DISTINCT
SELECT
    DISTINCT ID, 
    EMAIL,
    FIRST_NAME,
    LAST_NAME
FROM
    DEVELOPERS A
    INNER JOIN FE B
        ON A.SKILL_CODE & B.CODE
ORDER BY ID