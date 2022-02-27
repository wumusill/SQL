# 서브쿼리
******************
* SQL 문 안에 '부품'처럼 들어가는 SELECT 문
* 전체 별점의 평균보다 낮은 별점을 받은 제품 출력
```sql
SELECT i.id, i.name, AVG(star) AS avg_star
FROM item AS i LEFT OUTER JOIN review AS r
ON r.item_id = i.id
GROUP BY i.id, i.name
HAVING avg_star < (SELECT AVG(star) FROM review)
ORDER BY avg_star DESC; 
```
* `(SELECT AVG(star) FROM review)`가 서브쿼리
* **반드시 괄호로 감싸줘야 함**
* 서브쿼리를 포함하는 전체 SQL문을 outer query(외부 쿼리), 서브쿼리를 inner query(내부 쿼리)라고 하기도 함


<br/>

## (1) SELECT 절에 있는 서브쿼리
* SELECT 절에 서브쿼리를 쓴다는 것은 보통 원래 테이블에는 없던 새로운 컬럼을 추가해서 보기 위함
```sql
SELECT
    id,
    name, 
    price,
    (SELECT AVG(price) FROM item) AS avg_price
FROM copang_main.item; 
```

<br/>

## (2) WHERE 절에 있는 서브쿼리
* 평균 가격보다 높은 제품들 출력
```sql
SELECT
    id,
    name, 
    price,
    (SELECT AVG(price) FROM item) AS avg_price
FROM copang_main.item
WHERE price > (SELECT AVG(pirce) FROM item); 
```

<br/>

* 최고 가격 제품 출력
```sql
SELECT id, name, price
FROM item
WHERE price = (SELECT MAX(price) FROM item);
```

<br/>

* 리뷰가 3개 이상인 제품들 출력
```sql
SELECT * FROM item
WHERE id IN
(
SELECT item_id
FROM review
GROUP BY item_id HAVING COUNT(*) >= 3
); 
```

### ANY (SOME) & ALL
#### ANY (SOME)
* `ANY` : ~중 하나라도
* 서브쿼리의 결과에 있는 각 row의 값들 중 **하나라도 조건을 만족하는 경우가 있으면 True 리턴**
* 서브쿼리의 값 중 최솟값보다만 큰 값이라면 조건을 만족하게 될 것

```sql
SELECT * FROM theater
    WHERE view_count > ANY(SELECT view_count FROM theater WHERE category = 'ACTION')
        AND category != 'ACTION'
```

#### ALL
* 모든 경우에 대해서 해당 조건이 성립해야 True 리턴
* 서브쿼리의 값 중 최댓값보다는 커야 조건을 만족하게 될 것
```sql
SELECT * FROM theater
    WHERE view_count > ALL(SELECT view_count FROM theater WHERE category = 'ACTION')
        AND category != 'ACTION'
```
