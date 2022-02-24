# DATE 데이터 타입 관련 함수
************

# 1. 연도, 월, 일 추출하기
### (1) 1992년에 태어난 회원들만 조회
```sql
SELECT * FROM copang_main.member WHERE YEAR(birthday) = '1992';
```

### (2) 여름(6, 7, 8월)에 가입한 회원들만 조회
```sql
SELECT * FROM copang_main.member WHERE MONTH(sign_up_day) IN (6, 7, 8);
```

### (3) 각 달의 후반부(15일 ~ 31일)에 가입했던 회원들만 조회
```sql
SELECT * FROM copang_main.member WHERE DAYOFMONTH(sign_up_day) BETWEEN 15 AND 31;
```
* DAYOFMONTH 함수는 날짜값에서 일만 추출


<br/>


# 2. 날짜 간의 차이 구하기
```sql
SELECT email, sign_up_day, DATEDIFF(sign_up_day, '2019-01-01') FROM copang_main.member;
SELECT CURDATE(), DATEDIFF(sign_up_day, CURDATE()) FROM copang_main.member;
```
* `DATEDIFF(A, B)` : 날짜 A - 날짜 B
* `CURDATE()` : 오늘 날짜를 구하는 함수


<br/>


# 3. 날짜 더하기 빼기
```sql
DATE_ADD(sign_up_day, INTERVAL 300 DAY)
DATE_SUB(sign_up_day, INTERVAL 300 DAY)
```
* `DATE_ADD()` : 날짜 더하기 함수
* `DATE_SUB()` : 날짜 빼기 함수



<br/>


# 4. UNIX Timestamp 값
* 특정 날짜의 특정 시간을, 1970년 1월 1일을 기준으로, 총 몇 초가 지났는지로 나타낸 값
```sql
UNIX_TIMESTAMP(sign_up_day)
FROM_UNIXTIME(UNIX_TIMESTAMP(sign_up_day))
```
* `UNIX_TIMESTAMP()` : 날짜를 UNIX Timstamp로 변환
* `FROM_UNIXTIME()` : UNIX Timstamp 날짜로 변환

<br/>
<br/>


날짜, 시간 관련 데이터 타입 : https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html

날짜, 시간 관련 함수 : https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html