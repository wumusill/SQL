# 데이터베이스와 테이블 구축
****************
## (1) 데이터베이스 생성하기
```sql
CREATE DATABASE (데이터베이스 이름);
```
* 위 코드를 두 번 실행하면 에러가 남
```sql
CREATE DATABASE IF NOT EXISTS (데이터베이스 이름);
```
* 이미 같은 이름의 데이터베이스가 있다면 에러가 아닌 경고 메세지를 출력

<br/>

## (2) 테이블 생성하기
```sql
CREATE TABLE `course_rating`, `student` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(20) NULL,
    `student_number` INT NULL,
    `major` VARCHAR(15) NULL,
    `email` VARCHAR(50) NULL,
    `phone` VARCHAR(15) NULL,
    `admission_date` DATE NULL,
    PRIMARY KEY (`id`));
```


<br/>

## (3) 테이블에 row 추가하기
### 모든 값이 있는 경우
```sql
INSERT INTO student
# 컬럼 이름     (id, name, student_number, major, email, phone, admission_date)
# 대응 값들     VALUES (1, '구자현', 2017, '국제경영학과','jahyungu@naver.com', '010-####-####', '2017-03-02');


# 만약 모든 값들이 채워진 row라면 컬럼 이름 입력을 생략해도 됨
INSERT INTO student
    VALUES (1, '구자현', 2017, '국제경영학과','jahyungu@naver.com', '010-####-####', '2017-03-02');
```


### 없는 값이 있는 경우
```sql
INSERT INTO student
    (id, name, student_number, major, admission_date)
    VALUES (3, '민정호', 2017, '수의학과', '2017-03-02');
```
> id 컬럼은 `auto_increment` 속성 설정으로 값을 주지 않아도 자동으로 이전 row의 1이 큰 값이 들어감


<br/>

## (4) 테이블의 row 갱신하기
```sql
UPDATE student SET major = '컴퓨터공학과' WHERE id = 2;
```
> `WHERE` 값을 설정해주지 않으면 `SET`에 설정된 컬럼의 모든 값이 변경

### 컬럼의 기존 값을 기준으로 갱신하기
* 만약 시험 점수를 나타내는 테이블에서 모든 학생에 대해 (기존 점수 + 3)을 해주고 싶다면
```sql
UPDATE final_exam_result SET score = score + 3;
```
* `safe upate mode`로 인해 에러가 난다면 아래 코드를 추가하거나
* `edit - preferences` 에서 `SQL EDITOR` 메뉴의 `Safe Updates` 를 해제
```sql
SET SQL_SAFE_UPDATES = 0; 
```


<br/>

## (5) 테이블의 row 삭제하기
```sql
DELETE FROM student WHERE id = 4;
```
> `WHERE` 절을 설정하지 않으면 모든 데이터가 삭제


### 물리 삭제
* 데이터를 삭제해야할 때 row를 바로 삭제해버리는 것


### 논리 삭제
* 삭제해야할 row를 삭제하지 않고, **'삭제 여부'를 나타내는 별도의 컬럼을 두고, 거기에 '삭제 되었음'을 나타내는 값을 넣는 것**
#### 논리 삭제를 하는 이유
* 회원이 탈퇴하더라도 활동내역 관련 데이터가 사라지지 않음
#### 논리 삭제의 단점

* 삭제되지 않은 유효한 row들만 조회해야할 때는 별도의 조건을 추가해줘야하는 번거로움
* 보통 논리 삭제를 하되 이미 데이터 분석에 활용되었거나 고객이 동의한 데이터 보유기간이 지난 row들은 물리 삭제