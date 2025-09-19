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
