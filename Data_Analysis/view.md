# 뷰
*******
* 조인 등의 작업을 해서 만든 '결과 테이블'이 가상으로 저장된 형태



* 중첩된 서브쿼리와 중복된 코드로 복잡한 코드
```sql
SELECT i.id, i.name, AVG(star) AS avg_star, COUNT(*) AS count_star
FROM item AS i LEFT OUTER JOIN review AS r ON r.item_id = i.id
    LEFT OUTER JOIN member AS m ON r.mem_id = m.id
WHERE m.gender = 'f'
GROUP BY i.id, i.name
HAVING COUNT(*) >= 2 AND avg_star = 
(
    SELECT MAX(avg_star) FROM (
        SELECT i.id, i.name, AVG(star) AS avg_star, COUNT(*) AS count_star
        FROM item AS i LEFT OUTER JOIN review AS r ON r.item_id = i.id
            LEFT OUTER JOIN member AS m ON r.mem_id = m.id
        WHERE m.gender = 'f'
        GROUP BY i.id, i.name
        HAVING COUNT(*) >= 2
        ORDER BY AVG(star) DESC, COUNT(*) DESC
    ) AS final
)
ORDER BY AVG(star) DESC, COUNT(*) DESC;
```
> 뷰 생성 : CREATE VIEW (뷰 이름) AS (뷰로 만들고 싶은 SELECT 문)
```sql
CREATE VIEW three_tables_joined AS
SELECT i.id, i.name, AVG(star) AS avg_star, COUNT(*) AS count_star
FROM item AS i LEFT OUTER JOIN review AS r ON r.item_id = i.id
    LEFT OUTER JOIN member AS m ON r.mem_id = m.id
WHERE m.gender = 'f'
GROUP BY i.id, i.name
HAVING COUNT(*) >= 2
ORDER BY AVG(star) DESC, COUNT(*) DESC; 
```
>뷰 생성 후 복잡했던 코드 간결화

```sql
SELECT * FROM copang_main.three_tables_joined
WHERE avg_star = (
    SELECT MAX(avg_star) FROM copang_main.three_tables_joined
);
```

<br/>


## 뷰 관련 정보
* 뷰는 가상의 테이블
* 실제 테이블과의 차이점은 데이터가 물리적으로 컴퓨터에 저장되어 있지 않음

### 뷰의 장점
(1) 사용자에게 높은 편의성을 제공


(2) 각 직무별 데이터 수요에 알맞은, 다양한 구조의 데이터 분석 기반을 구축
* 같은 테이블에서도 직무, 상황에 따라 필요한 데이터의 종류, 구조가 다를 수 있음
* 뷰를 사용하여 각자에게 적합한 구조로 데이터들을 준비


(3) 데이터 보안을 제공
* 민감한 정보가 담겨 있는 테이블을 분석해야 할 경우 분석가에게 민감 정보가 담긴 컬럼을 제외하고 보여줄 수 있음


