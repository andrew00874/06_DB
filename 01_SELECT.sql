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
        
		NOW() + INTERVAL 1 HOUR,
        
-- 어제, 현재 시간, 내일, 모레 조회

SELECT '2025-09-15', STR_TO_DATE('2025-09-15', '%Y-%m-%d');

SELECT DATEDIFF('2025-09-15', '2025-09-14');

-- CURDATE() : 현재시간에서 시간정보를 제외한 년 원 일 만 조회가능한 함수
-- 근무일 수 조회                         현재 시간(날짜) 입사한 날짜
SELECT full_name, hire_date, datediff(curdate(), hire_date)
FROM employees;