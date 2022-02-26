# 다양한 종류의 조인
*****************
## (1) 서로 다른 3개의 테이블 조인

```sql
SELECT
    i.name, i.id,
    r.item_id, r.star, r.comment, r.mem_id,
    m.id, m.email
FROM
    item AS i LEFT OUTER JOIN review AS r
	ON r.item_id = i.id
    LEFT OUTER JOIN member AS m
	ON r.mem_id = m.id;
```

### 3개의 테이블을 조인하고 유의미한 데이터 추출
* 여성회원이 별점을 준 제품 내림차순 출력
```sql
SELECT 
    i.id, 
    i.name, 
    AVG(star)
FROM
    item AS i LEFT OUTER JOIN review AS r
	ON r.item_id = i.id
    LEFT OUTER JOIN member AS m
	ON r.mem_id = m.id
WHERE m.gender = 'f'
GROUP BY i.id, i.name
ORDER BY AVG(star) DESC; 
```

<br/>


* 리뷰 수가 2개 이상인 제품들만 출력

```sql
SELECT 
    i.id, 
    i.name, 
    AVG(star), 
    COUNT(*)
FROM
    item AS i LEFT OUTER JOIN review AS r
	ON r.item_id = i.id
    LEFT OUTER JOIN member AS m
	ON r.mem_id = m.id
WHERE m.gender = 'f'
GROUP BY i.id, i.name
HAVING COUNT(*) > 1
ORDER BY AVG(star) DESC, COUNT(*) DESC;
```


<br/>

### (2) NATURAL JOIN
* 두 테이블에서 같은 이름의 컬럼을 찾아서 자동으로 그것들을 조인 조건을 설정하고, `INNER JOIN`을 해주는 조인
* `ON`절을 쓸 필요가 없음
```sql
SELECT p.id, p.player_name, p.team_name, t.team_name, t.region
FROM player AS p NATURAL JOIN team AS t;
```

<br/>

### (3) CROSS JOIN
* 한 테이블의 하나의 row에 다른 테이블의 모든 row들을 매칭하고, 그 다음 row에서도 또, 다른 테이블의 모든 row들을 매칭하는 것을 반복함으로써 두 테이블의 모든 조합을 보여주는 조인
* row를 하나의 원소, 테이블을 하나의 집합이라고 본다면, 두 집합의 모든 원소들의 조합을 나타내는 Cartesian Product를 구하는 조인
```sql
SELECT * FROM member CROSS JOIN stock
```

<br/>

### (4) SELF JOIN

* 자기 자신과 조인을 하는 경우
* 하나의 테이블 안에서 다양한 정보들을 추출할 수 있음
* 아래와 같은 경우, age 컬럼을 조인 기준으로 해서 동갑인 다른 회원들을 알 수 있음

```sql
SELECT *
FROM member AS m1 LEFT OUTER JOIN member AS m2
ON m1.age = m2.age;
```

<br/>

### (5) FULL OUTER JOIN
* `LEFT OUTER JOIN` 결과와 `RIGHT OUTER JOIN` 결과를 합치는 조인
* 대신 두 결과에 모두 존재하는 row들은 한번만 표현

```sql
SELECT *
FROM player AS p LEFT OUTER JOIN team AS t
ON p.team_name = t.team_name
UNION
SELECT *
FROM player AS p RIGHT OUTER JOIN team AS t
ON p.team_name = t.team_name;
```
* `Oracle`에는 `FULL OUTER JOIN`을 바로 할 수 있도록 해주는 연산자 내장
```sql
SELECT *
FROM player AS p FULL OUTER JOIN team AS t
ON p.team_name = t.team_name;
```
<br/>

### (6) Non-Equi 조인
* Equi 조인 : 조인 조건에 등호(=)를 사용하는 조인

```sql
SELECT m.email, m.sign_up_day, i.name, i.registration_date
FROM copang_main.member AS m LEFT OUTER JOIN copang_main.item AS i
ON m.sign_up_day < i.registration_date
ORDER BY m.sign_up_day ASC;
```