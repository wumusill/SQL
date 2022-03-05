# Foreign Key
********
## 1. Foreign Key란?
* 다른 테이블의 특정 row를 참조하는 컬럼
* 참조 무결성을 지키기 위한 수단으로 특정 컬럼을 Foreign Key로 설정


## 2. Foreign Key 설정하기
### (1) 이미 테이블이 만들어진 후 설정하기
```sql
ALTER TABLE `course_rating`.`review` 
ADD CONSTRAINT `fk_review_table`
  FOREIGN KEY (`course_id`)
  REFERENCES `course_rating`.`course` (`id`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
```

### (2) 테이블을 만들 때 설정하기
```sql
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `star` int DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_review_table` (`course_id`),
  CONSTRAINT `fk_review_table` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) 
```
<br>

## 3. Foreign Key로 지켜지는 참조 무결성
### (1) 부모 테이블에 없는 데이터를 참조할 때
* `course` 테이블에 없는 `id` 를 추가하는 코드로 참조 무결성으로 인해 에러 
```sql
INSERT INTO review (course_id, star, comment)
	VALUES (10, 5, '정말 좋은 수업이에요!');
```

### (2) 부모 테이블의 row가 삭제될 때 
* 자식 테이블의 데이터들은 어떻게 해야하는지 정답은 없음
* 사용자가 일종의 정책을 통해 정함
* 대표적인 3가지 정책
#### RESTRICT 정책 (= NO ACTION)
* 자신을 참조하고 있는 자식 테이블의 row가 하나라도 있는 부모 테이블의 row는 아예 삭제 불가능
* 만약 삭제하고 싶다면 참조하고 있는 자식 row들을 다 지워야만 가능


#### CASCADE 정책
* '폭포수처럼 떨어지다.', '연쇄 작용을 일으키다.'
* 부모 테이블의 row와 함께 그것을 참조하고 있는 자식 테이블의 row까지 같이 삭제

#### SET NULL 정책
* 부모 테이블의 row가 삭제됐을 때 참조하던 자식 테이블의 foreign key 컬럼의 값을 NULL로 변경


### (3) 부모 테이블의 row가 갱신될 때
* 삭제될 때와 마찬가지로 RESTRICT, CASCADE, SET NULL 3가지 정책이 있음
* 기능 역시 삭제될 때와 동일

<br>

## 4. 논리적 Foreign Key, 물리적 Foreign Key
* 논리적 Foreign Key : 논리적으로 성립하나 Foreign Key로 설정하지 않은 경우
* 물리적 Foreign Key : DBMS 상에서 실제로 특정 컬럼을 Foreign Key로 설정한 경우

> 하지만 실무에서는 논리적 Foreign Key라고 해서 반드시 그것을 물리적 Foreign Key로 설정하지 않음

> 참조 무결성도 보장되고 좋을텐데 설정하지 않는 이유는?

### (1) 성능 문제
* 실제 서비스에 의해 사용되고 있는 데이터베이스의 테이블은 1초에 수많은 작업 발생
* 물리적 Foreign Key가 있는 자식 테이블의 경우 약간의 속도 저하가 발생할 가능성
* 참조 무결성보다는 빠른 성능이 중요하다면 Foreign Key를 굳이 설정하지 않음



### (2) 레거시(Legacy) 데이터의 참조 무결성이 이미 깨진 상태


> 하지만 참조 무결성을 완벽하게 지켜야하는 서비스(은행, 학적 관리 서비스 등)에서는 논리적 Foreign Key를 반드시 물리적 Foreign Key로 설정해야 함

<br>


5. Foreign Key 삭