# 집합 연산
********

## 1. 결합 연산과 집합 연산
* 테이블을 합치는 연산은 크게 **결합 연산**과 **집합 연산**으로 나눌 수 있음
  * 결합 연산 : 테이블을 **가로 방향**으로 합치는 것에 관한 연산
  * 집합 연산 : 테이블을 **세로 방향**으로 합치는 것에 관한 연산
    * `join`은 결합 연산에 해당

### (1) 집합 연산
* 집합 연산은 같은 종류의 테이블끼리만 가능
* 같은 컬럼 구조를 가진 테이블

### (2) A, B의 교집합 (INTERSECT 연산자 사용)
```sql
SELECT * FROM member_A
INTERSECT
SELECT * FROM member_B
```

### (3) A, B의 차집합 (MINUS or EXCEPT 연산자 사용)
```sql
SELECT * FROM member_A
MINUS
SELECT * FROM member_B
```


### (4) A, B의 합집합 (UNION 연산자 사용)
```sql
SELECT * FROM member_A
UNION
SELECT * FROM member_B
```

> MySQL에서는 UNION 연산자만 지원
> 
> INTERSECT, MINUS 연산은 결합 연산에 해당하는 join을 이용해 간접적으로 원하는 결과를 얻을 수 있음



<br/>

## 2. 같은 종류의 테이블 조인하기
```sql
SELECT
    old.id AS old_id,
    old.name AS old_name,
    new.id AS new_id,
    new.name AS new_name
FROM item AS old LEFT OUTER JOIN item_new AS new
ON old.id = new.id;
```
* `LEFT OUTER JOIN`으로 `A-B`와 같은 결과물 출력 가능


<br/>


```sql
SELECT
    old.id AS old_id,
    old.name AS old_name,
    new.id AS new_id,
    new.name AS new_name
FROM item AS old RIGHT OUTER JOIN item_new AS new
ON old.id = new.id;
```
* `RIGHT OUTER JOIN`으로 `B-A`와 같은 결과물 출력 가능



<br/>


```sql
SELECT
    old.id AS old_id,
    old.name AS old_name,
    new.id AS new_id,
    new.name AS new_name
FROM item AS old INNER JOIN item_new AS new
ON old.id = new.id;
```
* `INNER JOIN`으로 `INTERSECT`와 같은 결과물 출력 가능


### (1) ON & USING
* 만약 조인 조건으로 두 컬럼의 이름이 같으면 ON 대신 USING을 쓰는 경우도 있음
```sql
SELECT
    old.id AS old_id,
    old.name AS old_name,
    new.id AS new_id,
    new.name AS new_name
FROM item AS old INNER JOIN item_new AS new
USING(id)

ON old.id = new.id와 같은 의미
```

<br/>

## 3. UNION 관련 부가 기능
### (1) 다른 종류의 테이블도, 조회하는 컬럼을 일치시키면 집합 연산 가능
* Summer_Olympic_Medal 테이블과 Summer_Olympic_Medal 테이블은 다른 구조
```sql
# ERROR

SELECT * FROM Summer_Olympic_Medal
UNION
SELECT * FROM Summer_Olympic_Medal
```
```sql
# NOT ERROR

SELECT id, nation, count FROM Summer_Olympic_Medal
UNION
SELECT id, nation, count FROM Winter_Olympic_Medal
```

### (2) UNION ALL
* `UNION ALL`은 `UNION`처럼 두 테이블의 합집합을 보여줌
* 하지만 겹치는 것을 중복 제거하지 않고, 그대로 둘다 보여준다는 차이점
```sql
SELECT id, nation, count FROM Summer_Olympic_Medal
UNION ALL
SELECT id, nation, count FROM Winter_Olympic_Medal
```