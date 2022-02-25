# 테이블 조인
************

## Foreign Key 개념
* A 테이블에 a 컬럼, B 테이블에 b 컬럼이 있고 a 컬럼이 b 컬럼을 참조할 때
* a 컬럼 처럼 다른 테이블의 특정 row를 식별할 수 있게 해주는 컬럼을 말함


* 이 때, 참조를 하는 테이블인 A 테이블은 **자식 테이블**
* 참조를 당하는 테이블인 B 테이블은 **부모 테이블** 이라고 함


* Foreign Key는 다른 테이블의 특정 row를 식별할 수 있어야 하기 때문에 주로 다른 테이블의 Primary Key를 참조할 때가 많음

<br/>

## 테이블 조인하기 1, Outer join
```sql
SELECT
    item.id,
    item.name,
    stock.item_id,
    stock.inventory_count
FROM item LEFT OUTER JOIN stock
ON item.id = stock.item_id;
```
* `FROM item LEFT OUTER JOIN stock`
  * 왼쪽에 있는 item 테이블을 기준으로 stock 테이블을 합쳐라 
* `ON item.id = stock.item_id`
  * 어떤 기준으로 합치냐, item 테이블의 id 컬럼과 stock 테이블의 item_id 컬럼이 같은 것끼리 연결해라


<br/>

## 조인할 때 테이블에 alias 붙이기
* 테이블에도 컬럼과 마찬가지로 alias를 붙일 수 있음
* 조인을 할 때는 SQL문의 길이가 길어지기 때문에 보통 테이블에 alias를 많이 붙임
```sql
SELECT
    i.id,
    i.name,
    s.item_id,
    s.inventory_count
FROM item AS i LEFT OUTER JOIN stock AS s 
ON i.id = s.item_id;
```

### 컬럼의 alias vs 테이블의 alias
* 둘다 원래 이름 뒤에 AS를 쓰거나, 스페이스 하나를 띄우고 그 뒤에 alias를 쓰면 됨
> 하지만 두 종류의 alias는 약간의 용도 차이가 있음
* 컬럼의 alias는 각 컬럼 이름이 실제로 우리에게 그 alias로 변환되어서 보여지게 하기 위한 용도


* 이와 달리 테이블의 alias는 조회 결과에서 보기 위한게 아니라 SQL문의 길이를 줄여 가독성을 높이기 위함
* 조인할 때, 서로 다른 테이블에 같은 이름의 컬럼이 존재한다면, SQL문 안에서 그 컬럼을 가리킬 때 무슨 테이블의 컬럼인지를 더 짧게 표현해주기 위해서도 사용


<br/>

## 테이블 조인하기 2, Inner join
* 각 테이블에서 조인 기준으로 사용된 컬럼들의 일치하는 값 둘 다 존재하는 로우들만 합치는 조인
```sql
SELECT
    i.id,
    i.name,
    s.item_id,
    s.inventory_count
FROM item AS i INNER JOIN stock AS s 
ON i.id = s.item_id;
```

* item 테이블의 id 컬럼과 stock 테이블의 item_id 컬럼의 값이 같은 로우들만 추려서 합침
* 이 점은 outer join과 동일하나 inner join에는 기준이 되는 테이블이 따로 없음
* 두 테이블 모두 기준 컬럼에 일치하는 값이 있는 로우들만 연결
* 기준 컬럼이 NULL이 되는 경우가 없음
* 집합으로 치면 교집합을 구하는 것