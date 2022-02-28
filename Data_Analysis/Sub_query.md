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
* 단일값을 리턴하는 서브쿼리
* 스칼라 서브쿼리
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
* 하나의 컬럼에 여러 row들이 있는 형태의 결과를 리턴하는 서브쿼리
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


<br/>

## (3) FROM 절에 있는 서브쿼리
* 하나의 테이블 형태의 결과를 리턴하는 서브쿼리
* `derived table` : 서브쿼리로 만들게된 테이블
* `derived table`에는 반드시 alias를 붙여줘야 함
```sql
SELECT
    AVG(review_count),
    MAX(review_count),
    MIN(review_count),
FROM
(SELECT
    SUBSTRING(address, 1, 2) AS region,
    COUNT(*) AS review_count
FROM review AS r LEFT OUTER JOIN member AS m
ON r.mem_id = m.id
GROUP BY SUBSTRING(address, 1, 2)
HAVING region IS NOT NULL
    AND region != '안드') AS review_count_summary;
```

<br/>

## (4) 서브쿼리의 또 다른 분류 방식
### 비상관 서브쿼리
```sql
SELECT * FROM item
    WHERE id IN (SELECT item_id FROM reivew GROUP BY item_id HAVING COUNT(*) >= 3);
```
* 위 코드는 `WHERE`절에서 서브쿼리가 사용되고 있는 모습
* 서브쿼리는 그 자체만으로도 실행이 가능한 서브쿼리
* `outer query`와 별개로, 독립적으로 실행되는 코드를 **비상관 쿼리**라고 함

### 상관 서브쿼리
```sql
SELECT * FROM item
    WHERE EXISTS (SELECT * FROM review WHERE review.item_id = item.id);
```
* 위 `WHERE`절에 사용된 서브쿼리는 단독으로 실행되지 못함
* `item` 테이블이 `FROM`절이 아닌 `outer query`에 있기 때문


#### 위 코드 해석
1. `item` 테이블의 첫 번째 `row` 생각
2. 그 `row`의 `id`값이 `review` 테이블의 `item_id` 컬럼에 같은게 있는지 조회
3. 만약에 존재한다면 `(EXISTS)` `WHERE` 절은 `TRUE`
4. 따라서 리뷰가 달린 제품들만 출력

> 만약 리뷰가 없는 제품들만 출력하고 싶다면
```sql
SELECT * FROM item
    WHERE NOT EXISTS (SELECT * FROM review WHERE review.item_id = item.id);
```
 <br/>

> 상관 쿼리라고 반드시 (NOT) EXISTS 키워드를 써야하는 것이 아님
```sql
SELECT *
(SELECT MIN(height)
FROM member AS m2 WHERE birthday is NOT NULL AND height IS NOT NULL
AND YEAR(m1.birthday) = YEAR(m2.birthday)) AS min_height_in_the_year
FROM member AS m1
ORDER BY min_height_in_the_year ASC;
```