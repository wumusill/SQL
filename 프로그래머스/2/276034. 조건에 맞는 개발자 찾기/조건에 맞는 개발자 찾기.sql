-- 코드를 작성해주세요
-- SKILL_CODE(INT)를 이진 수로 변환하지 않아도 비트 연산자를 활용하면 비트 연산 수행
-- 비트의 길이가 다르면 짧은 비트의 왼쪽에 0이 패딩 됨
-- 1 & 1 = True
-- 둘 다 비트가 1이면 1을 반환 -> 0이 아니므로 True
SELECT
    ID, EMAIL, FIRST_NAME, LAST_NAME
FROM 
    DEVELOPERS
WHERE 
    SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME = 'C#')
    OR SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME = 'Python')
ORDER BY 
    ID