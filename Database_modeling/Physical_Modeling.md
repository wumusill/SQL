# 물리적 모델링
************
> 물리적 모델링 중에서도 시스템 디자인적 요소들은 배제한, 온전히 SQL, ORM 같이 코드로 정할 수 있는 내용들

## 1. 물리적 모델링
* 데이터베이스에 실제로 저장하는 내용에 최대한 가깝게 데이터 모델을 만드는 과정

### (1) 네이밍
#### 단수/복수 정하기
* 단수 단어를 사용할지, 복수 단어를 사용할지 정하는 것
* 컬럼 이름은 단수 사용 : 모든 컬럼 값들은 분리 불가능한 단일 값을 사용해야 하기 때문

#### 대문자/띄어쓰기 정하기

#### 줄임말 정하기

> 어떤 규칙을 정하는지보다 정해진 규칙을 잘 따르는게 중요, 통일성이 있어야 함

> 처음에 규칙을 최대한 명확하게 정하고, 이 규칙을 잘 따라야 함


<br>

### (2) 데이터 타입
* 각 컬럼이 '어떤' 데이터를 저장하는지에 대한 내용
* 데이터베이스의 가장 기본적인 제약 사항

#### 데이터 타입을 잘 정해야 하는 이유
* 데이터의 정확성을 지켜주는 역할
* 데이터베이스 연산/함수들을 제대로 활용하기 위해서
* 데이터베이스 용량을 최적화하기 위해서



<br>


## 2. 인덱스

* 데이터가 정렬돼있으면 원하는 데이터를 더 빠르게 찾을 수 있다는 특성을 데이터베이스에 적용한 개념


### (1) Clustered 인덱스
* 데이터베이스에 저장돼있는 데이터 자체를 특정 순서대로 저장하는 인덱스
* 조회 속도가 굉장히 빠름
* 하나밖에 만들 수 없음
  * 이메일 순서로 정렬돼있으면서 동시에 이름 순서대로 정렬할 수 없음


### (2) Non-clustered 인덱스
* 실제 저장된 순서 자체는 건들지 않고, 아예 데이터베이스 다른 곳에 컬럼 값들의 순서를 저장하는 방법
  * 다른 테이블에 이메일에 대한 해당 로우의 유저가 저장된 주소를 함께 정렬, 저장
* 실제 테이블과 무관하게 순서를 저장하기 때문에 개수의 제한이 없음
* 실제 테이블과 다른 곳에 저장돼있기 때문에 데이터를 찾는게 clustered 인덱스보다 조금 느리다는 단점


### (3) Composite 인덱스
* 인덱스는 단순 하나의 컬럼이 아니라, 여러 개의 컬럼에 대해서, 합쳐서도 만들 수 있음


> 특정 조건의 데이터를 찾는 조회를 굉장히 빠르게 할 수 있음에도 모든 컬럼과 모든 컬럼의 조합에 인덱스를 추가하지는 않는다


> 인덱스를 많이 사용할 수록 여러 단점들 발생

### (4) 인덱스의 단점 (Non-clustered 국한)
* 용량 문제 
* 업데이트 문제
  * 하나의 로우의 값을 바꾸면, 해당 컬럼이 포함된 모든 인덱스를 수정해야 함
  * 조회는 빠르게 할 수 있게 하지만, 삽입, 업데이트, 삭제는 오히려 더 느리게 만듦



* 인덱스를 추가하려는 테이블의 컬럼들이 얼마나 자주 삽입, 업데이트, 삭제되는지 파악
* 이 연산들을 많이 해야되는 테이블의 컬럼들에는 인덱스가 오히려 역효과를 낳는다

#### 인덱스 추가 기본 원칙
* 모든 `primary key`에 대해서 인덱스를 만들어줌
* 모든 `foreign key`에 대해서 인덱스를 만들어줌
* 특정 조회 쿼리가 너무 느려지거나, 느려질 게 확실한 경우 조회에 사용되는 컬럼들에 대해서 인덱스를 만들어줌

<br>

## 3. SQL로 인덱스 만들기
### (1) Clustered 인덱스 만들기
* `primary key`에 대해 자동으로 만들어지기 때문에 삭제 후 아래 코드로 인덱스 추가
```sql
# table_name 테이블에 column_name 컬럼에 대해서 index_name 이라는 이름의 clustered 인덱스를 만들어라
CREATE CLUSTERED INDEX index_name ON table_name (column_name);
```


### (2) Non-clustered 인덱스 만들기
```sql
CREATE INDEX index_name ON table_name (column_name);
```

### (3) Composite 인덱스 만들기
```sql
CREATE INDEX index_name ON table_name (column_name_1, column_2, ...);
```
### (4) 인덱스 확인하기
```sql
SHOW INDEX FROM table_name;
```


### (5) 인덱스 삭제하기
```sql
DROP INDEX index_name ON table_name;
```