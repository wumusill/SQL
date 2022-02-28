# 데이터 분석 전 데이터베이스의 현황 파악하기
******************
1. 어떤 데이터베이스들이 있는지
2. 각 데이터베이스 안에 어떤 테이블들이 있는지
3. 각 테이블의 컬럼 구조는 어떻게 되는지
4. 테이블들 간의 `Foreign Key` 관계는 어떤지 등을 조사해야 함


## (1) 존재하는 데이터베이스들 파악
```sql
SHOW DATABASES;
```
* `information_schema/mysql/performance_schema/sys`는 기본 데이터베이스


## (2) 한 데이터베이스 안의 테이블(뷰도 포함)들 파악
```sql
SHOW FULL TABLES IN copang_main;
```

## (3) 한 테이블의 컬럼 구조 파악
```sql
DESCRIBE item;
```
* 각 컬럼의 이름, 데이터 타입, 속성 유무 등이 표시되어 있음

## (4) Foreign Key(외래키) 파악
* Foreign Key 관계가 성립한다고 해도 관리자가 그것을 Foreign Key로 설정하지 않는 경우도 많음
* 따라서 Foreign Key들을 정확하게 파악하려면 해당 회사의 데이터베이스를 설계한 분의 설명을 듣거나, 본인이 직접 데이터의 관계 및 흐름을 파악해서 스스로 파악해야 함