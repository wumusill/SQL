# 테이블 다루기
**********
##`DESCRIBE`
* 컬럼 정보를 한 눈에 볼 수 있게 해주는 구문

```sql
DESCRIBE <table>;

DESC <table>;
```
## 컬럼 다루기
### 컬럼 추가
* `ALTER TABLE` `테이블 이름` `ADD` `컬럼 이름` `데이터 타입` `속성;`
```sql
ALTER TABLE student ADD gender CHAR(1) NULL;
```


<br>


### 컬럼의 이름 변경
```sql
ALTER TABLE student
	RENAME COLUMN student_number TO registration_number;
```

<br>

### 컬럼 삭제
```sql
ALTER TABLE student DROP COLUMN admission_date;
```



<br>


### 컬럼의 데이터 타입 변경
```sql
ALTER TABLE student MODIFY major INT;
```
* 만약 전공 이름이 한글로 저장되어 있다면 에러가 남
* 기존에 저장된 값 변경하려는 새 데이터 타입에 적합한지 미리 확인
* 데이터 타입을 바꿈으로써 기존 데이터가 날아가는 것을 방지해주는 것
* 데이터 값들을 모두 정수로 바꿔주고 데이터 타입을 변경해야 함

```sql
SET SQL_SAFE_UPDATES = 0;
UPDATE student SET major = 10 WHERE major = '국제경영학과';
UPDATE student SET major = 12 WHERE major = '컴퓨터공학과';
UPDATE student SET major = 7 WHERE major = '수의학과';

ALTER TABLE student MODIFY major INT;
```