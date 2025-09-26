-- 조건문

-- 직원 테이블
DROP DATABASE TJE;
CREATE DATABASE tje;
USE tje;

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    age INT,
    hire_date DATE,
    performance_score DECIMAL(3,1)
);

INSERT INTO employees VALUES
(1, '김철수', 'IT', 5500000, 28, '2020-03-15', 4.2),
(2, '이영희', 'HR', 4800000, 32, '2019-07-22', 3.8),
(3, '박민수', 'Sales', 6200000, 35, '2018-11-10', 4.5),
(4, '정수진', 'IT', 4200000, 25, '2021-01-08', 3.9),
(5, '홍길동', 'Finance', 5800000, 40, '2017-05-20', 4.1),
(6, '송미영', 'Sales', 3800000, 27, '2022-02-14', 3.5),
(7, '장동건', 'IT', 7200000, 45, '2015-09-03', 4.8),
(8, '김미나', 'HR', 5200000, 30, '2020-10-12', 4.0);

-- 제품 테이블
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT,
    stock_quantity INT,
    supplier VARCHAR(30)
);

INSERT INTO products VALUES
(1, '노트북', 'Electronics', 1200000, 15, 'TechCorp'),
(2, '마우스', 'Electronics', 25000, 50, 'TechCorp'),
(3, '키보드', 'Electronics', 80000, 30, 'InputDevice'),
(4, '의자', 'Furniture', 150000, 8, 'ComfortSeats'),
(5, '책상', 'Furniture', 300000, 5, 'OfficeFurniture'),
(6, '모니터', 'Electronics', 450000, 12, 'DisplayTech'),
(7, '램프', 'Furniture', 75000, 20, 'LightingSolutions');


-- IF 함수
-- 기본 문법
-- IF (조건, 참일때 값, 거짓일 때 값);

-- EMPLOYEES 테이블에서 급여에 따른 등급 분류
-- 								  조건문			  참 	   거짓
SELECT EMP_NAME, SALARY, IF(SALARY >= 6000000, '고액연봉', '일반연봉') AS 연봉상태
FROM EMPLOYEES;

-- EMPLOYEES 나이대별 분류
-- 이름, 나이, 나이 30을 기준으로 30 이전이면 30이전 아니면 30이후 AS  30대 기준 분류
SELECT EMP_NAME, IF(AGE >= 30 , '30이후', '30이전') AS '30대 기준 분류'
FROM EMPLOYEES;

-- 다양한 IF 사용
-- 성과급에 따른 결과를 계산하기
SELECT EMP_NAME, SALARY ,PERFORMANCE_SCORE, SALARY + IF(PERFORMANCE_SCORE >= 4.5, SALARY * 0.1, IF(PERFORMANCE_SCORE >= 4.0 , SALARY * 0.05, 0)) AS `월급 + 성과급`
FROM EMPLOYEES;

/*
-- 기본 문법
CASE 컬럼명칭
	WHEN 값1 THEN 결과1
    WHEN 값2 THEN 결과2
    WHEN 값3 THEN 결과3
    ELSE 기본값
END

-- 조건식 CASE
CASE
	WHEN 컬럼명 조건1 THEN 결과1
    WHEN 컬럼명 조건2 THEN 결과2
    WHEN 컬럼명 조건3 THEN 결과3
    ELSE 기본값
END
*/
-- 기본 CASE 실습

-- 부서별 한글명 변환해서 반환 후 조회
SELECT EMP_NAME, DEPARTMENT,
CASE DEPARTMENT -- 부서 컬럼에서
	WHEN 'IT' THEN '정보기술팀'
    WHEN 'HR' THEN '인사팀' 
    WHEN 'Sales' THEN '영업팀'
    WHEN 'Finance' THEN '재무팀'
    ELSE '기타부서' -- 생략 가능하나 이외 작업에 default 처럼 사용 가능
END as '한글부서명'
FROM EMPLOYEES;

-- products 테이블에서 카테고리를 한국어로 변환해서 출력
SELECT * FROM PRODUCTS;
SELECT PRODUCT_NAME, CASE CATEGORY
							WHEN 'ELECTRONICS' THEN '전자제품'
                            WHEN 'FURNITURE' THEN '가구'
                            ELSE '기타'
					 END AS '명칭변경후'
FROM PRODUCTS;

-- 다중의 조건이 존재할 경우 BETWEEN AND나 OR 과 같은 것을 사용할 수 있다.
SELECT PRODUCT_NAME AS '제품명',SUPPLIER AS '공급업체' ,CASE SUPPLIER
						WHEN 'TECHCORP' THEN 'A급'
						WHEN 'INPUTDEVICE' THEN 'B급'
                        WHEN 'DISPLAYTECH' THEN 'A급'
                        ELSE 'C급'
					 END AS '공급업체등급'
FROM PRODUCTS;

-- SEARCHED CASE

-- 나이별로 세대 분류
SELECT EMP_NAME,
	   AGE,
       CASE
		WHEN AGE BETWEEN 20 AND 29 THEN '20대'
        WHEN AGE BETWEEN 30 AND 39 THEN '30대'
        WHEN AGE BETWEEN 40 AND 49 THEN '40대'
        ELSE '기타' -- 선택사항
	   END AS 세대분류
FROM EMPLOYEES;

-- SEARCH CASE 이용해서
-- PRODUCTS 에서 제품 가격에 따른 등급
SELECT PRODUCT_NAME, PRICE, CASE
								WHEN PRICE < 100000 THEN '보급형'
								WHEN PRICE < 500000 THEN '중급형'
								ELSE '고급형'
							END AS '가격등급'
FROM PRODUCTS;

/*
SIMPLE CASE 특징
정확한 값 매칭이 필요할 때 사용
문자열이나 고정값 비교에 적합

SEARCHED CASE 특징
복잡한 조건식이 필요할 때 사용
범위검사 , 복합조건에 적합

BETWEEN AND OR >= 등 다양한 연산자를 사용하여 조건 설정

ELSE 절은 선택사항이나 NULL 을 방지하기 위하여 항상 포함하는 것이 좋음
조건의 순서 중요
데이터 타입은 일치

WHEN 으로 설정한 조건을 VIEW 형태의 테이블로 만들어주기도 함
*/