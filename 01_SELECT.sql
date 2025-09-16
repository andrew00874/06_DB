/*
SELECT (조회)
지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL

작성법 -1
SELECT 컬럼명, 컬럼명, ...
FROM 테이블명;

작성법 -2 : 테이블 내 모든 컬럼을 선택해서 모든 행과 컬럼 조회
SELECT *
FROM 테이블명;
*/

-- EMPLOYEE 테이블에서 사번, 이름, 이메일 조회
SELECT emp_id, full_name, email
FROM employees;

SELECT emp_id, full_name, email FROM employees;

/*
SQL 의 경우 예약어 기준으로 세로로 작성하는 경우가 많으며,
세로로 작성하다 작성을 마무리하는 마침표는 반드시 ; 으로 작성
*/

# employees 테이블에서 이름(full_name), 입사일(hire_date)만 조회
# ctrl + enter 한 줄 코드만 출력

SELECT full_name, hire_date FROM employees;

SELECT *
FROM employees;

# Departments 테이블의 모든 데이터 조회
SELECT * FROM Departments;
# Departments 테이블에서 부서코드, 부서명 조회
SELECT dept_code, dept_name FROM Departments;
# Employees 테이블에서 (emp_id, full_name, salary) 사번, 이름, 급여 조회
SELECT emp_id, full_name, salary FROM employees;
# Training_programs 테이블에서 모든 데이터 조회
SELECT * FROM training_programs;
# Training_programs 테이블에서 (program_name, duration_hours) 조회
SELECT program_name, duration_hours FROM training_programs;

/***********************
컬럼 값 산술 연산자

-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

SELECT 문 작성 시 컬럼명에 산술 연산을 직접 작성하면
조회 결과 (RESULT SET) 에 연산 결과가 반영되어 조회된다!

***********************/

-- 1. Employee 테이블에서 모든 사원의 이름, 급여, 급여 +500 만원을 했을 때 인상 결과 조회
SELECT full_name, salary, salary + 5000000 as hiked_salary
FROM employees;

-- 2. Employees 테이블에서 모든 사원의 사번, 이름, 연봉(급여 * 12) 조회
SELECT emp_id, full_name, salary * 12 as annual_salary
FROM employees;

-- 3. Training_programs 테이블에서 프로그램명, 교육시간, 하루당 8시간 기준 교육일수 조회
SELECT program_name, duration_hours, duration_hours / 8 as duration_days
FROM training_programs;

-- Employees 테이블에서 이름, 급여, 급여 * 0.8 조회 (세후 급여)
SELECT full_name as 이름, salary as 세전급여, salary * 0.8 as 세후급여
FROM employees;
--  positions 테이블에서 직급명, 최소 급여, 최대 급여, 급여 차이 (최대급여 - 최소급여 조회)
SELECT position_name, min_salary, max_salary, max_salary - min_salary as diff
FROM positions;
-- departments 테이블에서 부서명, 예산, 예산 * 1.1 의 총액 조회
SELECT dept_name as 부서명, budget as 예산, budget * 1.1 as '예산+10%'
FROM departments;

-- 모든 SQL 에서는 DUAL 가상 테이블이 존재함. Mysql 에서는 FROM 을 생략할 경우 자동으로 DUAL 가상테이블 사용
-- 현재 날짜 확인하기 (가상 테이블 필요 없음)
SELECT NOW(), current_timestamp();

SELECT NOW(), current_timestamp
FROM dual;

CREATE DATABASE IF NOT EXISTS 네이버;
CREATE DATABASE IF NOT EXISTS 라인;
CREATE DATABASE IF NOT EXISTS 스노우;

USE 네이버;
USE 라인;
USE 스노우;

-- 날짜 데이터 연산하기 ( + , - 만 가능)

-- > +1 == 1일 추가
-- > -1 == 1일 감소

SELECT NOW() + interval 1 DAY, NOW() - interval 1 DAY; 

-- 날짜 연산 (시간, 분, 초 단위)
SELECT NOW(),
		NOW() + INTERVAL 1 HOUR,
		NOW() + INTERVAL 1 minute,
		NOW() + INTERVAL 1 second;
        
        
-- 어제, 현재 시간, 내일, 모레 조회

SELECT '2025-09-15', STR_TO_DATE('2025-09-15', '%Y-%m-%d');

SELECT DATEDIFF('2025-09-15', '2025-09-14');

-- CURDATE() : 현재시간에서 시간정보를 제외한 년 원 일 만 조회가능한 함수
-- 근무일 수 조회                         현재 시간(날짜) 입사한 날짜
SELECT full_name, hire_date, datediff(curdate(), hire_date)
FROM employees;

-- 컬럼명 별칭 지정하기
/****************
컬럼명 별칭 지정하기
1) 컬럼명 AS 별칭 : 문자 OK, 띄어쓰기 X, 특수문자 X
2) 컬럼명 AS `별칭` : 문자 OK, 띄어쓰기 OK, 특수문자 OK
3) 컬럼명 별칭 : 문자 OK, 띄어쓰기 X, 특수문자 X
4) 컬럼명 `별칭` : 문자 OK, 띄어쓰기 OK, 특수문자 OK

`` 이나 "" 사용 가능
대/소문자 구분
*****************/

-- 별칭 이용해서 근무일수로 컬럼명 설정 후 조회하기
SELECT full_name, hire_date, datediff(curdate(), hire_date) AS `근무일수`
FROM employees;

-- 1. employees 테이블에서 사번, 이름 이메일로 해당컬럼 데이터 조회
-- (별칭에서 as 사용하지 않고 조회)
SELECT emp_id 사번, full_name 이름, email
FROM employees;

-- 2. employees 테이블에서 이름, 급여, 연봉(급여*12) 로 해당칼럼 데이터 조히
-- (별칭에서 as `` 사용하고 조회)
SELECT full_name as `이름`, salary as `급여`, (salary * 12) as `연봉`
FROM employees;

-- 3. positions 테이블에서 직급명, 최소급여, 최대급여, 급여차이 명칭으로
-- 해당 컬럼 데이터 조회 (별칭에서 as "" 사용하고 조회)
SELECT position_name as "직급명", ceil(min_salary) as "최소급여", ceil(max_salary) as "최대급여",  ceil(max_salary - min_salary) as "급여차이"
FROM positions;


use employee_management;
select distinct dept_id
from employees;

/***********************
WHERE 절
테이블에서 조건을 충족하는 행을 조회할 때 사용
WHERE 절에는 조건식(true/false)만 작성

비교 연산자 : >, <, >=, <=, =(같다), !=(같지 않다), <>(같지 않다)
논리 연산자 : AND, OR, NOT

SELECT 컬럼명, 컬럼명, ...
FROM 테이블명
WHRE 조건식;
***********************/
-- employees 테이블에서 급여가 300만원 초과하는 사원의
-- 사번, 이름, 급여, 부서코드 조회
/*3*/SELECT emp_id, full_name, salary, dept_id
/*1*/FROM employees
/*2*/WHERE salary > 3000000;
/* FROM 절에 지정된 테이블에서
** WHERE 절로 행을 먼저 추려내고, 추려진 결과 행들 중에서
*  SELECT 절에 원하는 컬럼만 조회 */

-- employees 테이블에서 연봉이 5천만원 이하인 사원의 사번 이름 연봉 조회
SELECT emp_id, full_name, salary
FROM employees
WHERE salary <= 50000000;

-- employees 테이블에서 부서 코드가 2번이 아닌 사원의 이름, 부서코드, 전화번호 조회
SELECT full_name, dept_id, phone
FROM employees
WHERE dept_id != 2;

/* 연결 연산자 CONCAT() */

SELECT CONCAT(emp_id, full_name) as 사번이름연결
from employees;


/*********************
       LIKE 절
*********************/

-- EMPLOYEES 테이블에서 성이 '김' 씨인 사원의 사번, 이름 조회
SELECT EMP_ID, FULL_NAME
FROM EMPLOYEES
WHERE FULL_NAME LIKE '김%';

-- EMPLOYEES 테이블에서 FULL_NAME 이름에 '민'이 포함되는 사원의 사번, 이름 조회
SELECT EMP_ID, FULL_NAME
FROM EMPLOYEES
WHERE FULL_NAME LIKE '%민%';

SELECT *
FROM EMPLOYEES;

-- EMPLOYEES 테이블에서 전화번호가 010 으로 시작하는 사원의 이름, 전화번호 조회
SELECT FULL_NAME, PHONE
FROM EMPLOYEES
WHERE PHONE LIKE '010%'; 

-- EMPLOYEES 테이블에서 EMAIL 의 아이디가 3글자인 사원의 이름, 이메일 조회
SELECT FULL_NAME, EMAIL
FROM EMPLOYEES
WHERE EMAIL LIKE '___@%';

-- EMPLOYEES 테이블에서 사원코드가 EMP로 시작하고 EMP 포함해서 총 6자리인 사원 조회
SELECT FULL_NAME, EMP_CODE
FROM EMPLOYEES
WHERE EMP_CODE LIKE 'EMP___';


/**********************
WHERE절
AND OR BETWEEN IN()
*********************/

SELECT EMP_CODE, FULL_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 40000000 AND 70000000;

SELECT EMP_CODE, FULL_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 40000000 AND 70000000;

SELECT FULL_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2020-01-01' AND '2020-12-31';

SELECT FULL_NAME, DATE_OF_BIRTH
FROM EMPLOYEES
WHERE DATE_OF_BIRTH BETWEEN '1980-01-01' AND '1989-12-31';

SELECT FULL_NAME, DATE_OF_BIRTH
FROM EMPLOYEES
WHERE DATE_OF_BIRTH LIKE '198_______';

-- ORER 절 WHERE 응용 IN() 절 JOIN 문

-- EMPLOYEES 테이블에서
-- 부서코드가 2, 4, 5 인 사원의
-- 이름, 부서코드, 급여 조회
SELECT FULL_NAME, DEPT_ID, SALARY
FROM EMPLOYEES
WHERE DEPT_ID = 2
OR DEPT_ID = 4
OR DEPT_ID = 5;

-- 컬럼의 값이 () 내 값과 일치하면 true

SELECT FULL_NAME, DEPT_ID, SALARY
FROM EMPLOYEES
WHERE DEPT_ID IN (2,4,5);

-- EMPLOYEES 테이블에서
-- 부서코드가 2, 4, 5 인 사원을 제외
SELECT FULL_NAME, DEPT_ID, SALARY
FROM EMPLOYEES
WHERE DEPT_ID NOT IN (2,4,5);


