SELECT temp.CATEGORY, temp.MAX_PRICE, FOOD_PRODUCT.PRODUCT_NAME
FROM (SELECT CATEGORY, MAX(PRICE) AS MAX_PRICE FROM FOOD_PRODUCT GROUP BY CATEGORY HAVING CATEGORY IN ("김치", "식용유", "국", "과자")) AS temp
INNER JOIN FOOD_PRODUCT ON temp.CATEGORY = FOOD_PRODUCT.CATEGORY AND temp.MAX_PRICE = FOOD_PRODUCT.PRICE
ORDER BY temp.MAX_PRICE DESC