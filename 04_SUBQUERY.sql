/********************************
SUBQUERY(서브쿼리)
하나의 SQL 문 안에 포함된 또다른 SQL 문
메인쿼리(기존쿼리)를 위해 보조 역할을 하는 쿼리문
- SELECT, FROM, WHERE, HAVING 절에서 사용가능

STORES
ID, NAME, CATEGORY, ADDRESS, PHONE, RATING, DELIVERY_FEE
MENUS
ID, STORE_ID, NAME, DESCRIPTION, PRICE, IS_POPULAR
********************************/

USE DELIVERY_APP;
SELECT * FROM STORES;
SELECT * FROM MENUS;

-- =====================
-- 1. 기본 서브쿼리 (단일행)
-- =====================
-- 가장 비싼 메뉴 찾기
-- 1단계 : 최고 가격 찾기
SELECT MAX(PRICE) FROM MENUS; -- 38900원

-- 2단계 : 그 가격인 메뉴 찾기
SELECT NAME, PRICE 
FROM MENUS 
WHERE PRICE = 38900;

-- 1단계 + 2단계 퓨전
SELECT NAME, PRICE
FROM MENUS
WHERE PRICE = (SELECT MAX(PRICE) FROM MENUS);

-- 1단계 : 메뉴들의 평균 가격 조회
SELECT AVG(PRICE) FROM MENUS;
-- 2단계 : 그 가격인 메뉴 찾기
SELECT NAME, PRICE
FROM MENUS
WHERE PRICE >= 15221.4286;
-- 1단계 2단계를 조합해서 평균보다 비싼 메뉴들만 조회
SELECT NAME, PRICE
FROM MENUS
WHERE PRICE >= (SELECT AVG(PRICE)
				FROM MENUS);
                
-- 평점이 가장 높은 매장 찾기
-- 1단계 : 최고 평점 찾기
SELECT MAX(RATING)
FROM STORES;
-- 2단계 : 최고평점인 매장 찾기
SELECT NAME
FROM STORES
WHERE RATING = 4.9;
-- 1단계와 2단계 조합하기
SELECT NAME, RATING
FROM STORES
WHERE RATING = (SELECT MAX(RATING)
				FROM STORES);
                
                
-- 배달비가 가장 비싼 매장 찾기
-- 1단계 : 가게에서 가장 비싼 배달비 조회
SELECT MAX(DELIVERY_FEE)
FROM STORES;

-- 2단계 : 배달비가 가장 비싼 매장명칭과 배달비, 카테고리 조회
SELECT NAME, DELIVERY_FEE, CATEGORY
FROM STORES
WHERE DELIVERY_FEE = 5500;

-- 1단계와 2단계 조합
SELECT NAME, DELIVERY_FEE, CATEGORY
FROM STORES
WHERE DELIVERY_FEE = (SELECT MAX(DELIVERY_FEE) FROM STORES);

-- =====================
-- 단일행 서브쿼리 실습 문제

-- 문제1: 가장 싼 메뉴 찾기
-- 1단계: 최저 가격 찾기
SELECT MIN(PRICE) FROM MENUS;
-- 2단계: 그 가격인 메뉴 찾기 (메뉴명, 가격)
SELECT NAME, PRICE FROM MENUS WHERE PRICE = 1500;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, PRICE FROM MENUS WHERE PRICE = (SELECT MIN(PRICE) FROM MENUS);

-- 문제2: 평점이 가장 낮은 매장 찾기 (NULL 제외)
-- 1단계: 최저 평점 찾기
SELECT MIN(RATING) FROM STORES;
-- 2단계: 그 평점인 매장 찾기 (매장명, 평점, 카테고리)
SELECT NAME, RATING, CATEGORY FROM STORES WHERE RATING = 4.2;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, RATING, CATEGORY FROM STORES WHERE RATING = (SELECT MIN(RATING) FROM STORES);
-- 문제3: 배달비가 가장 저렴한 매장 찾기 (NULL 제외)
-- 1단계: 최저 배달비 찾기
SELECT MIN(DELIVERY_FEE) FROM STORES;
-- 2단계: 그 배달비인 매장들 찾기 (매장명, 배달비, 주소)
SELECT NAME, DELIVERY_FEE, ADDRESS FROM STORES WHERE DELIVERY_FEE = 2000;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, DELIVERY_FEE, ADDRESS FROM STORES WHERE DELIVERY_FEE = (SELECT MIN(DELIVERY_FEE) FROM STORES);

-- 문제4: 평균 평점보다 높은 매장들 찾기
-- 1단계: 전체 매장 평균 평점 구하기
SELECT AVG(RATING) FROM STORES;
-- 2단계: 평균보다 높은 평점의 매장들 찾기 (매장명, 평점, 카테고리)
SELECT NAME, RATING, CATEGORY FROM STORES WHERE RATING > 4.67;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, RATING, CATEGORY FROM STORES WHERE RATING > (SELECT AVG(RATING) FROM STORES);

-- 문제5: 평균 배달비보다 저렴한 매장들 찾기 (NULL 제외)
-- 1단계: 전체 매장 평균 배달비 구하기
SELECT AVG(DELIVERY_FEE) FROM STORES;
-- 2단계: 평균보다 저렴한 배달비의 매장들 찾기 (매장명, 배달비, 카테고리)
SELECT NAME, DELIVERY_FEE, CATEGORY FROM STORES WHERE DELIVERY_FEE <= 3180;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, DELIVERY_FEE, CATEGORY FROM STORES WHERE DELIVERY_FEE <= (SELECT AVG(DELIVERY_FEE) FROM STORES);
-- 문제6: 치킨집 중에서 평점이 가장 높은 곳
-- 1단계: 치킨집들의 최고 평점 찾기
SELECT MAX(RATING) FROM STORES WHERE CATEGORY = '치킨';
-- 2단계: 치킨집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT NAME, RATING, ADDRESS FROM STORES WHERE CATEGORY = '치킨' AND RATING = 4.9;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, RATING, ADDRESS FROM STORES WHERE CATEGORY = '치킨' AND RATING = (SELECT MAX(RATING) FROM STORES WHERE CATEGORY = '치킨');

-- 문제7: 치킨집 중에서 배달비가 가장 저렴한 곳 (NULL 제외)
-- 1단계: 치킨집들의 최저 배달비 찾기
SELECT MIN(DELIVERY_FEE) FROM STORES WHERE CATEGORY = '치킨';
-- 2단계: 치킨집 중 그 배달비인 매장 찾기 (매장명, 배달비)
SELECT NAME, DELIVERY_FEE FROM STORES WHERE CATEGORY = '치킨' AND DELIVERY_FEE = 2000;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, DELIVERY_FEE FROM STORES WHERE CATEGORY = '치킨' AND DELIVERY_FEE = (SELECT MIN(DELIVERY_FEE) FROM STORES WHERE CATEGORY = '치킨');

-- 문제8: 중식집 중에서 평점이 가장 높은 곳
-- 1단계: 중식집들의 최고 평점 찾기
SELECT MAX(RATING)
FROM STORES
WHERE CATEGORY = '중식';
-- 2단계: 중식집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT NAME, RATING, ADDRESS
FROM STORES
WHERE CATEGORY = '중식' AND RATING = 4.7;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, RATING, ADDRESS
FROM STORES
WHERE CATEGORY = '중식' AND RATING = (SELECT MAX(RATING)
FROM STORES
WHERE CATEGORY = '중식');

-- 문제9: 피자집들의 평균 평점보다 높은 치킨집들
-- 1단계: 피자집들의 평균 평점 구하기
SELECT AVG(RATING)
FROM STORES
WHERE CATEGORY = '피자';
-- 2단계: 그보다 높은 평점의 치킨집들 찾기 (매장명, 평점)
SELECT NAME, RATING
FROM STORES
WHERE CATEGORY = '피자' AND RATING >= 4.7;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, RATING
FROM STORES
WHERE CATEGORY = '피자' AND RATING >= (SELECT AVG(RATING)
FROM STORES
WHERE CATEGORY = '피자');
-- 문제10: 한식집들의 평균 배달비보다 저렴한 일식집들 (NULL 제외)
-- 1단계: 한식집들의 평균 배달비 구하기
SELECT AVG(DELIVERY_FEE)
FROM STORES
WHERE CATEGORY = '한식';
-- 2단계: 그보다 저렴한 배달비의 일식집들 찾기 (매장명, 배달비)
SELECT NAME, DELIVERY_FEE
FROM STORES
WHERE CATEGORY = '일식' AND DELIVERY_FEE < 3200;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT NAME, DELIVERY_FEE
FROM STORES
WHERE CATEGORY = '일식' AND DELIVERY_FEE < (SELECT AVG(DELIVERY_FEE) FROM STORES WHERE CATEGORY = '한식');


-- ======================
-- 1. IN 연산자 - 가장 많이 사용되는 다중행 서브쿼리

-- 인기 메뉴가 있는 매장들 조회

-- 1단계 : 인기 메뉴가 있는 매장 ID들 확인
SELECT DISTINCT STORE_ID
FROM MENUS
WHERE IS_POPULAR = TRUE;

-- 2단계 ; 인기있는 매장 ID들에 해당하는 매장 정보 찾기
SELECT NAME, CATEGORY, RATING
FROM STORES
WHERE ID IN (SELECT DISTINCT STORE_ID
FROM MENUS
WHERE IS_POPULAR = TRUE);

-- ========================

-- 2. NOT IN 연산자
-- 인기 메뉴가 없는 매장들 조회
-- name, category, rating
-- 1단계 인기 메뉴가 있는 매장들 id 확인
SELECT S.NAME, S.CATEGORY, S.RATING
FROM STORES S JOIN MENUS M ON S.ID = M.STORE_ID
WHERE M.IS_POPULAR = 1;
-- 2단계 1단계를 조합하여 그 id들에 해당하지 않는 매장들 가져오기



-- 20000원 이상 메뉴를 파는 매장들 조회

-- 1단계 : 20000원 이상 메뉴를 가진 매장 id들 확인
SELECT DISTINCT S.ID
FROM STORES S JOIN MENUS M ON S.ID = M.STORE_ID
WHERE M.PRICE IN (SELECT PRICE FROM MENUS WHERE PRICE >= 20000);
-- 2단계 : 1단계 결과를 조합하여 해당 매장들에 대한 정보 가져오기
--        name, category, rating
SELECT DISTINCT S.NAME, S.CATEGORY, S.RATING 
FROM STORES S JOIN MENUS M ON S.ID = M.STORE_ID
WHERE M.PRICE IN (SELECT PRICE FROM MENUS WHERE PRICE >= 20000)
ORDER BY S.NAME;
-- name 순으로 오름차순 



/**********************************************************
           다중행 서브쿼리 실습문제 (1 ~ 10 문제)
           IN / NOT IN 연산자
***********************************************************/
-- 문제 1: 카테고리별 최고 평점 매장들 조회
-- 1단계: 카테고리별 최고 평점들 확인
SELECT CATEGORY, MAX(RATING)
FROM STORES
GROUP BY CATEGORY;
-- GROUP BY category
-- 2단계: 1단계 결과를 조합하여 각 카테고리의 최고 평점 매장들 가져오기
SELECT S.CATEGORY, S.NAME, S.RATING
FROM STORES S JOIN (SELECT CATEGORY, MAX(RATING) AS MAX_RATING
FROM STORES
GROUP BY CATEGORY) AS K ON S.CATEGORY = K.CATEGORY AND S.RATING = K.MAX_RATING
WHERE S.RATING IS NOT NULL
ORDER BY S.CATEGORY;
-- SUM에 대한 결과인지, 평점인지, 가격을 합친건지, 나눈 것인지 카테고리별로 무엇을 했는지 알 수 없음
-- 문제에서 평점을 기준으로 가게 데이터를 조회하려 하기 때문에
-- 카테고리별로 그룹을 짓고, 그룹별로 최고평점만 조회하여
-- 평점을 기준으로 가게 데이터 조회

-- 문제 2: 배달비가 가장 저렴한 매장들의 인기 메뉴들 조회
-- 1단계: 가장 저렴한 배달비 매장 ID들 확인
SELECT ID, MIN(DELIVERY_FEE)
FROM STORES
WHERE DELIVERY_FEE = (SELECT MIN(DELIVERY_FEE) FROM STORES)
GROUP BY ID;
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 인기 메뉴들 가져오기
-- JOIN stores s ON m.store_id = s.id
SELECT M.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE S.DELIVERY_FEE = (SELECT MIN(DELIVERY_FEE) FROM STORES) AND M.IS_POPULAR = 1;

-- 문제 4: 15000원 이상 메뉴가 없는 매장들 조회
-- 1단계: 15000원 이상 메뉴를 가진 매장 ID들 확인
SELECT STORE_ID
FROM MENUS
WHERE PRICE >= 15000;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기
SELECT DISTINCT S.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE STORE_ID NOT IN (SELECT STORE_ID
FROM MENUS
WHERE PRICE >= 15000);

-- 문제 5: 메뉴 설명이 있는 메뉴를 파는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT STORE_ID
FROM MENUS
WHERE DESCRIPTION IS NOT NULL;
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT DISTINCT S.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE STORE_ID IN (SELECT DISTINCT STORE_ID
FROM MENUS
WHERE DESCRIPTION IS NOT NULL);

-- 문제 6: 메뉴 설명이 없는 메뉴만 있는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT STORE_ID
FROM MENUS
WHERE DESCRIPTION IS NOT NULL;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기 (단, 메뉴가 있는 매장만)
SELECT S.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE STORE_ID NOT IN (SELECT DISTINCT STORE_ID
FROM MENUS
WHERE DESCRIPTION IS NOT NULL);

-- 문제 7: 치킨 카테고리 매장들의 메뉴들 조회
-- 1단계: 치킨 카테고리 매장 ID들 확인
SELECT ID
FROM STORES
WHERE CATEGORY = '치킨';
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 메뉴들 가져오기
SELECT S.NAME, M.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE S.ID IN (SELECT ID
FROM STORES
WHERE CATEGORY = '치킨');

-- 문제 8: 피자 매장이 아닌 곳의 메뉴들만 조회
-- 1단계: 피자 매장 ID들 확인
SELECT ID
FROM STORES
WHERE CATEGORY = '피자';
-- 2단계: 1단계 결과에 해당하지 않는 매장들의 메뉴들 가져오기
SELECT S.NAME, M.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE S.ID NOT IN (SELECT ID
FROM STORES
WHERE CATEGORY = '피자');

-- 문제 9: 평균 가격보다 비싼 메뉴를 파는 매장들 조회
-- 1단계: 평균 가격보다 비싼 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT STORE_ID
FROM MENUS
WHERE PRICE >= (SELECT AVG(PRICE) FROM MENUS);
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT S.NAME, M.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE S.ID IN (SELECT DISTINCT STORE_ID
FROM MENUS
WHERE PRICE >= (SELECT AVG(PRICE) FROM MENUS));

-- 문제 10: 가장 비싼 메뉴를 파는 매장들 조회
-- 1단계: 가장 비싼 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT STORE_ID
FROM MENUS
WHERE PRICE = (SELECT MAX(PRICE) FROM MENUS);
-- 2단계: 1단계 결과를 조합하여 해당 매장과 메뉴 정보 가져오기
SELECT S.NAME, M.NAME
FROM STORES S JOIN MENUS AS M ON S.ID = M.STORE_ID
WHERE S.ID IN (SELECT DISTINCT STORE_ID
FROM MENUS
WHERE PRICE = (SELECT MAX(PRICE) FROM MENUS));