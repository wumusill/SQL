# SQL 작성 형식의 4가지
**********
## 1. SQL 문 끝에는 항상 세미콜론을 써줘야 함.
```sql
SELECT * FROM copang_main.member WHERE id = 5;
```

<br/>

## 2. SQL 문 안에는 공백이나 개행 등을 자유롭게 넣을 수 있음.
```sql
SELECT * FROM copang_main.member            WHERE id = 5;

SELECT * FROM copang_main.member
    WHERE id = 5;
```
* 어떤 방식으로 쓰든, 구분되어야할 키워드들이 최소한 하나 이상은 공백으로 구분되어 있고, 세미콜론으로 마무리되어 있으면 실행에는 문제가 없음
* 이런 점을 이용해서 길이가 긴 SQL 문을 쓸 때 개행, 탭 등을 적절하게 활용해서 가독성을 높이자

<br/>

## 3. SQL 문의 대소문자 구분 문자
```sql
SELECT * FROM copang_main.member WHERE id = 5;
```
* 예약어 : MySQL에 기본으로 내장된 키워드들 
  * ex) `SELECT`, `WHERE`, `FROM` 
* **MySQL의 예약어는 대문자로 적는 것이 관례**이고, 보기에도 좋음
* 소문자로 실행해도 문제 없으나 가독성을 위해 대문자로 쓰는 습관을 들이자

<br/>

## 4. 데이터베이스 이름과 테이블
```sql
SELECT * FROM copang_main.member;
```
* 데이터베이스 이름 뒤에 점(.)을 붙이고 그 다음에 테이블 이름 작성
* 실무에서는 서로 다른 데이터베이스에, 같은 이름의 테이블이 존재할 수도 있기 때문에 이렇게 써주는 것이 좋음

>하지만 항상 그럴 필요는 없음
```sql
USE copang_main;
SELECT * FROM member; 
```
* SQL 문으로 어떤 데이터베이스를 쓰겠다고 확실히 정하거나
* 왼쪽 `SCHEMAS` 패널 부분의 `copang_main`을 클릭해서 활성화하면 `copang_main` 데이터베이스를 사용할 것이라고 지정한 것과 마찬가지, 이런 상태에서는 `member` 라고 테이블 이름만 적어줘도 됨 