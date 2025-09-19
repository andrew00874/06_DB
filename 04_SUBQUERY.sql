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