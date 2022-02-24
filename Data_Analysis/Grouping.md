# 그루핑
*****
## 예시 코드
```sql
SELECT SUBSTRING(address, 1, 2) AS region, gender, COUNT(*) FROM copang_main.member
GROUP BY SUBSTRING(address, 1, 2), gender
HAVING region IS NOT NULL
ORDER BY region ASC, gender DESC;
```

## GROUP BY를 사용할 때 지켜야 하는 규칙
###(1) SELECT 절에는 GROUP BY 뒤에서 사용한 컬럼들 또는 
###(2) COUNT, MAX 등과 같은 집계 함수만 쓸 수 있음

<br/>


## WITH ROLLUP
* 그룹별 부분 총계를 표기해주는 함수
* 엑셀의 부분합과 같은 기능
```sql
SELECT YEAR(birthday) AS b_year, YEAR(sign_up_day) AS s_year, gender, COUNT(*)
FROM copang_main.member
GROUP BY YEAR(birthday), YEAR(sign_up_day), gender WITH ROLLUP
ORDER BY b_year DESC;
```

## WITH ROLLUP 관련 문제점
* 상위 그룹에 대한 부분합을 표기해줄 때 하위 그룹은 NULL로 표기됨
* 하지만 하위 그룹 컬럼에 실제 NULL 값이 있을 경우 이것이 부분 총계인지 실제 그룹 중 하나인지 알 수 없음

> GROUPING이라는 함수를 이용해 해결 가능
```sql
SELECT YEAR(sign_up_day) AS s_year, gender, SUBSTRING(address, 1, 2) AS region,
GROUPING(YEAR(sign_up_day)), GROUPING(gender), GROUPING(SUBSTRING(address, 1, 2)),  
COUNT(*)
FROM copang_main.member
GROUP BY YEAR(sign_up_day), gender, SUBSTRING(address, 1, 2) WITH ROLLUP
ORDER BY s_year DESC;
```
* 실제로 NULL을 나타내기 위해 쓰인 NULL인 경우에는 0 출력
* 부분 총계를 나타내기 위해 표시된 NULL은 1 출력