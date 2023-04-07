-- 코드를 입력하세요
SELECT
    APNT_NO,
    PT_NAME,
    PT_NO,
    a.MCDP_CD,
    DR_NAME,
    APNT_YMD
FROM (
    SELECT
        APNT_YMD,
        APNT_NO,
        a.PT_NO,
        PT_NAME,
        MCDP_CD,
        MDDR_ID
    FROM APPOINTMENT AS a
    LEFT JOIN PATIENT AS p
    ON a.PT_NO = p.PT_NO
    WHERE APNT_CNCL_YN = "N" 
            AND MCDP_CD = "CS" 
            AND DATE_FORMAT(APNT_YMD, "%Y-%m-%d") = DATE("2022-04-13")
) AS a
LEFT JOIN DOCTOR as b
ON a.MDDR_ID = b.DR_ID
ORDER BY APNT_YMD