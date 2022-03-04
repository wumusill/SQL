# 테이블 다루기
**********
## 1. `DESCRIBE`
* 컬럼 정보를 한 눈에 볼 수 있게 해주는 구문

```sql
DESCRIBE <table>;

DESC <table>;
```

<br>

## 2. 컬럼 구조 변경
### (1) 컬럼 추가
* `ALTER TABLE` `테이블 이름` `ADD` `컬럼 이름` `데이터 타입` `속성;`
```sql
ALTER TABLE student ADD gender CHAR(1) NULL;
```

### (2) 컬럼의 이름 변경
```sql
ALTER TABLE student
	RENAME COLUMN student_number TO registration_number;
```

### (3) 컬럼 삭제
```sql
ALTER TABLE student DROP COLUMN admission_date;
```

### (4) 컬럼의 데이터 타입 변경
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


<br>


## 3. 컬럼 속성 다루기
### (1) NOT NULL 속성 주기
* 데이터 타입 변경과 마찬가지로 `MODIFY` 사용
```sql
ALTER TABLE student MODIFY name VARCHAR(35) NOT NULL;
ALTER TABLE student MODIFY registration_number INT NOT NULL;
ALTER TABLE student MODIFY major INT NOT NULL;
```

### (2) DEFAULT 속성 주기

```sql
ALTER TABLE student MODIFY major INT NOT NULL DEFAULT 101;
```

### (3) 현재 시간은 기본 값으로 넣기
* 게시물 최초 업로드 시각과 최근 갱신 시간을 기록하는 두 가지 방법
#### `NOW()` 함수 이용
```sql
INSERT INTO post (title, content, upload_time, recent_modified_time) VALUES ("제목", "내용", NOW(), NOW());
```

```sql
UPDATE post SET content = '새로운 내용', 
    recent_modified_time = NOW()
WHERE id = 1;
```

#### 기본값 속성 주기
* `DATETIME`타입 또는 `TIMESTAMP` 타입의 컬럼에는
* `DEFAULT CURRENT_TIMESTAMP` 속성과 `ON UPDATE CURRENT_TIMESTAMP` 속성을 줄 수 있음
* `DEFAULT CURRENT_TIMESTAMP` 속성은 테이블에 새 `row`를 추가할 때 기본값으로 현재 시간이 설정
* `ON UPDATE CURRENT_TIMESTAMP` 속성 기존 `row`에서 단 하나의 컬럼이라도 갱신되면 갱신될 때 시간이 설정되도록 하는 속성
```sql
ALTER TABLE post
    MODIFY upload_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    MODIFY recent_modified_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
```

### (4) UNIQUE 속성 주기
* 컬럼에 `UNIQUE` 속성을 추가하면 다른 `row`에 같은 값이 추가되는 것을 막을 수 있음

```sql
ALTER TABLE student MODIFY registration_number INT NOT NULL UNIQUE;
```

<br>

## 4. 테이블에 CONSTRAINT 걸기
* 테이블에 이상한 데이터가 추가되는 것을 막기 위해 제약사항을 걸 수 있음
* `CHECK` 뒤 조건에 무조건 괄호 

```sql
ALTER TABLE student ADD CONSTRAINT st_rule CHECK (registration_number < 30000000);
```
* 제약사항은 삭제 가능함
```sql
ALTER TABLE student DROP CONSTRAINT st_rule; 
```

* 다중 제약사항 걸기

```sql
ALTER TABLE student
    ADD CONSTRAINT st_rule
    CHECK (email LIKE '%@%' AND gender IN ('m', 'f'));
```

<br>

## 5. 기타 컬럼 관련 작업들 
### (1) 컬럼 가장 앞으로 당기기
```sql
ALTER TABLE player_info
    MODIFY id INT NOT NULL AUTO_INCREMENT FIRST;
```

### (2) 컬럼 간의 순서 바꾸기
```sql
ALTER TABLE player_info
    MODIFY role CHAR(5) NULL AFTER name;
```

### (3) 컬럼의 이름과 데이터 타입 및 속성 동시에 수정하기
```sql
ALTER TABLE player_info
    CHANGE role position VARCHAR(2) NOT NULL;
```

### (4) 여러 작업 동시에 수행하기
```sql
ALTER TABLE player_info
    RENAME COLUMN id TO registration_number,
    MODIFY name VARCHAR(20) NOT NULL,
    DROP COLUMN position,
    ADD height DOUBLE NOT NULL,
    ADD weight DOUBLE NOT NULL;
```


<br>

## 6. 테이블 이름 변경, 복사본 만들기, 삭제
### (1) 테이블 이름 변경
```sql
RENAME TABLE student TO undergraduate;
```

### (2) 테이블 복사
```sql
CREATE TABLE copy_of_undergraduate AS SELECT * FROM undergraduate;
```

### (3) 테이블 삭제
```sql
DROP TABLE copy_of_undergraduate;
```

### (4) 테이블 컬럼 구조만 복사

```sql
CREATE TABLE copy_of_undergraduate LIKE undergraduate;
```
* 컬럼 구조만 복사된 빈 테이블에 row들을 가져오기
* 두 테이블의 컬럼 구조가 일치해야 가능
```sql
INSERT INTO copy_of_undergraduate SELECT * FROM undergraduate;
```
* 조건 추가도 가능
```sql
INSERT INTO copy_of_undergraduate 
    SELECT * FROM undergraduate WHERE major = 101;
```

### (5) TRUNCATE
* 기존 테이블의 데이터를 전부 다 삭제하고, 같은 테이블에서 다시 시작하고 싶을 때 사용
* `DELETE FROM`과 실행 결과는 같지만 내부적으로 이루어지는 동작에서 차이가 있음
```sql
TRUNCATE final_exam_result;

DELETE FROM final_exam_result;
```