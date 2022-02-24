# 데이터 분석 단계로 나아가기
*******

## 1. 집계 함수 & 산술 함수
+ 집계 함수 : 특정 컬럼의 여러 row의 값들을 동시에 고려해서 실행되는 함수
* 산술 함수 : 특정 컬럼의 각 row의 값마다 실행되는 함수


* `COUNT()` : 개수
* `MAX()` : 최댓값
* `MIN()` : 최솟값
* `AVG()` : 평균값
* `SUM()` : 합계
* `STD()` : 표준편차
* `ABS()` : 절댓값
* `SQRT()` : 제곱근
* `CEIL()` : 올림
* `FLOOR()` : 내림
* `ROUND()` : 반올림



<br/>

## 2. CASE 함수
* CASE 함수는 크게 두 종류로 나뉨
  * 단순 CASE 함수
  * 검색 CASE 함 
  
### (1) 단순 CASE 함수
* CASE 문 바로 뒤에 컬럼 이름을 쓰고, 그 컬럼의 값과 어떤 값이 **같은지**를 비교하는 CASE 함수
```sql
CASE 컬럼 이름
    WHEN 값 THEN 값
    WHEN 값 THEN 값
    ELSE 값
END
```
```sql
SELECT email,
CASE age
    WHEN 29 THEN '스물 아홉 살'
    WHEN 30 THEN '서른 살'
    ELSE age
END
FROM copang_main.member; 
```

### (2) 검색 CASE 함수
* 등호 연산만 하는 단순 CASE 함수와 달리 사용자가 직접 원하는 대로 조건 설정
```sql
CASE 
    WHEN 조건1 THEN 값
    WHEN 조건2 THEN 값
    ELSE 값
END
```
```sql
SELECT email,
CASE 
    WHEN weight IS NULL OR height IS NULL THEN '비만 여부 알 수 없음'
    WHEN weight / ((height/100) * (height/100)) >= 25 THEN '과제충 또는 비만'
    WHEN weight / ((height/100) * (height/100)) >= 18.5 
        AND weight / ((height/100) * (height/100)) < 25 
        THEN '정상'
    ELSE '저체중'
END
FROM copang_main.member; 
```


<br/>

## 3. NULL을 다른 값으로 변환하는 함수
### (1) COALESCE 함수
* `COALESCE(A,B)` : A를 B로 반환
```sql
SELECT COALESCE(height, 'N/A')
SELECT COALESCE(height, weight * 2.3, 'N/A') 
# height가 NULL 이면 weight * 2.3 값 반환
# weight도 NULL 이면 'N/A' 반환
```

### (2) IFNULL 함수
```sql
SELECT IFNULL(height, 'N/A') FROM copang_main.member;
```

### (3) IF 함수
* `IF(조건, True일 경우, False일 경우)`
```sql
SELECT IF(height IS NULL, height, 'N/A') FROM copang_main.member; 
```

### (4) CASE 함수
```sql
SELECT
    CASE 
        WHEN height IS NOT NULL THEN height
        ELSE 'N/A'
    END
FROM copang.main.member;
```

<br/>

##  기타 함수
* `CONCAT()` : 여러 컬럼을 이어주는 함수
```sql
SELECT email, CONCAT(height, 'cm', ', ', weight, 'kg') AS '키와 몸무게'
```
* `DISTINCT(col)` : 컬럼의 고유값 출력
* `SUBSTRING(col, 1, 2)` : 해당 컬럼에서 1번째 부터 총 2글자 추출
* `LPAD(col, 10, 0), RPAD(col, 10, 0)` : 컬럼의 각각 왼쪽, 오른쪽에 0을 채워 10자리 문자로 만듦
