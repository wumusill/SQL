# SELECT 문의 실행 순서
*****
## 각 절들의 표기 순서
1. SELECT
2. FROM
3. WHERE
4. GROUP BY
5. HAVING
6. ORDER BY
7. LIMIT

## 각 절들의 실행 순서
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT

## 해석
1. FROM
   1. 어느 테이블을 대상으로 할 것인지를 먼저 결정
2. WHERE
   1. 해당 테이블에서 특정 조건(들)을 만족하는 row들만 선별
3. GROUP BY
   1. row들을 그루핑 기준대로 그루핑, 하나의 그룹은 하나의 row로 표현
4. HAVING
   1. 그루핑 작업 후 생성된 여러 그룹들 중에서, 특정 조건(들)을 만족하는 그룹들만 선별
5. SELECT
   1. 모든 컬럼 또는 특정 컬럼들을 조회
   2. SELECT 절에서 컬럼 이름에 alias를 붙인게 있다면, 이 이후 단계(ORDER BY, LIMIT)부터는 해당 alias를 사용할 수 있음
6. ORDER BY
   1. 각 row를 특정 기준에 따라서 정렬
7. LIMIT
   1. 이전 단계까지 조회된 row들 중 일부 row들만을 추림
