-- 코드를 입력하세요
# SET @변수 := value
# SET : 변수를 만들 때 사용
# ':=' 변수에 값을 할당할 때 사용

# HOUR 변수를 가진 테이블 선언
SET @HOUR := -1;

# 0부터 23까지 변수 생성
SELECT (@HOUR := @HOUR +1) AS HOUR,

# DATETIME에서 HOUR가 같은 row count
(SELECT COUNT(*) FROM ANIMAL_OUTS WHERE HOUR(DATETIME) = @HOUR) AS COUNT 
FROM ANIMAL_OUTS

# 22까지만 해야 @HOUR +1로 23까지 생성
WHERE @HOUR < 23