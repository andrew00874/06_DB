-- 06 CREATE DML 실습문제 (MART 테이블)
-- 자료형 날짜 : YEAR 년도  TIME HH:mm:SS 형태로 저장 (시:분:초)

USE delivery_app;

-- 1. MART 테이블 생성 문제
-- 다음 조건에 맞는 MART 테이블을 생성하세요.
-- - mart_id: 자동증가 기본키
-- - mart_name: 마트명 (100자, NULL 불가)
-- - location: 위치 (255자, NULL 불가)
-- - phone: 전화번호 (20자)
-- - open_time: 개점시간 (TIME 타입)
-- - close_time: 폐점시간 (TIME 타입)
-- - is_24hour: 24시간 운영여부 (BOOLEAN, 기본값 FALSE)
-- - created_at: 등록일시 (TIMESTAMP, 기본값 현재시간)
-- - updated_at: 수정일시 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
--   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
CREATE TABLE `MART` (
    `mart_id` INT AUTO_INCREMENT PRIMARY KEY,
    `mart_name` VARCHAR(100) NOT NULL,
    `location` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20),
    `open_time` TIME,
    `close_time` TIME,
    `is_24hour` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- 2. INSERT 문제
-- 다음 마트 정보를 INSERT하세요.

-- 문제 2-1: 모든 컬럼값을 지정하여 삽입
-- 이마트 강남점, 서울시 강남구 테헤란로 123, 02-123-4567, 08:00, 24:00, 24시간 운영 아님
-- (TIMESTAMP 컬럼은 DEFAULT 사용)
INSERT INTO MART(MART_NAME, LOCATION, PHONE,  OPEN_TIME, CLOSE_TIME, IS_24HOUR)
VALUES ('이마트 강남점', '서울시 강남구 테헤란로 123', '02-123-4567', '08:00', '24:00', FALSE);

-- 문제 2-2: 컬럼명을 명시하여 삽입 (24시간 운영 정보와 TIMESTAMP 없이)
-- 롯데마트 잠실점, 서울시 송파구 올림픽로 456, 02-456-7890, 09:00, 23:00
select * from mart;
INSERT INTO MART(MART_NAME, LOCATION, PHONE,  OPEN_TIME, CLOSE_TIME)
VALUES ('롯데마트 잠실점', '서울시 송파구 올림픽로 123', '02-456-7890', '09:00', '23:00');
-- 문제 2-3: DEFAULT 값 활용하여 삽입
-- CU 편의점 역삼점, 서울시 강남구 역삼로 789, 02-789-0123, 24시간 운영
INSERT INTO MART(MART_NAME, LOCATION, PHONE, OPEN_TIME, CLOSE_TIME, IS_24HOUR)
VALUES ('CU 편의점 역삼점', '서울시 강남구 역삼로 789', '02-789-0123', NULL, NULL, TRUE);
-- 삽입된 데이터 확인
SELECT * FROM mart;

-- 3. UPDATE 문제
-- 문제 3-1: 이마트 강남점의 전화번호를 '02-111-1111'로 변경하세요.
UPDATE MART
SET PHONE = '02-111-1111'
WHERE MART_NAME = '이마트 강남점';


-- 문제 3-2: 24시간 운영이 아닌 마트들의 폐점시간을 22:00으로 일괄 변경하세요.
SET SQL_SAFE_UPDATES = 0;
UPDATE MART
SET CLOSE_TIME = '22:00'
WHERE IS_24HOUR = FALSE;

-- 문제 3-3: CU 편의점 역삼점의 개점시간과 폐점시간을 각각 00:00, 23:59로 변경하세요.
UPDATE MART
SET CLOSE_TIME = '23:59', OPEN_TIME = '00:00'
WHERE MART_NAME = 'CU 편의점 역삼점';

-- 업데이트 결과 확인 (created_at과 updated_at 시간 차이 확인)
SELECT mart_name, created_at, updated_at FROM mart;

-- 4. DELETE 문제
INSERT INTO mart (mart_name, location, phone, open_time, close_time, is_24hour)
VALUES
('세븐일레븐 논현점', '서울시 강남구 논현로 111', '02-111-2222', NULL, NULL, TRUE),
('GS25 삼성점', '서울시 강남구 삼성로 222', NULL, '06:00:00', '24:00:00', FALSE);

-- 삽입 확인
SELECT * FROM mart;

-- 문제 4-1: 전화번호가 NULL인 마트를 삭제하세요.
DELETE FROM MART WHERE PHONE IS NULL;

-- 문제 4-2: 24시간 운영이 아니고 폐점시간이 22:00인 마트를 삭제하세요.
DELETE FROM MART WHERE CLOSE_TIME = '22:00' AND IS_24HOUR = FALSE;


-- 문제 4-3: 마트명에 '편의점'이 포함된 마트를 삭제하세요.
DELETE FROM MART WHERE MART_NAME LIKE '%편의점%';
-- 삭제 결과 확인
SELECT * FROM mart;

-- 현재시간과 10분이라는 시간 간격 단위
-- DATE_SUB() 날짜에서 지정한 간격을 빼는 함수
-- DATE_SUB(NOW(), INTERVAL 10 MINUTE);
-- 이용해서 등록된 지 10분 이내의 마트만 조회하기
select *
from mart
where created_at > date_sub(now(), interval 10 minute);
-- 최종 확인
SELECT * FROM mart;
DESCRIBE mart;



-- ========================================
-- MySQL DML 문제
-- ========================================
-- ========================================
-- 1. CREATE TABLE 문제
-- ========================================

use delivery_app;
-- 문제 1-1: 다음 조건에 맞는 employees 테이블을 생성하세요.
/*
조건:
- emp_id: 자동증가 기본키
- emp_name: 직원명 (50자, NULL 불가)
- department: 부서명 (30자, 기본값 'GENERAL')
- position: 직급 (20자, NULL 불가)
- salary: 급여 (정수, 기본값 0)
- hire_date: 입사일 (DATE 타입, NULL 불가)
- email: 이메일 (100자, 유니크 제약조건)
- phone: 전화번호 (20자)
- is_active: 재직여부 (BOOLEAN, 기본값 TRUE)
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
- updated_at: 수정시간 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
*/
CREATE TABLE employees (
	emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name varchar(50) NOT NULL,
    DEPARTMENT VARCHAR(30) DEFAULT 'GENERAL',
    POSITION VARCHAR(20) NOT NULL,
    SALARY INT DEFAULT 0,
    HIRE_DATE DATE NOT NULL,
    EMAIL VARCHAR(100) UNIQUE,
    PHONE VARCHAR(20),
    IS_ACTIVE BOOLEAN DEFAULT TRUE,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- 문제 1-2: 다음 조건에 맞는 projects 테이블을 생성하세요.
/*
조건:
- project_id: 자동증가 기본키
- project_name: 프로젝트명 (100자, NULL 불가)
- manager_id: 매니저ID (INT)
- budget: 예산 (DECIMAL(12,2))
- start_date: 시작일 (DATE)
- end_date: 종료일 (DATE)
- status: 상태 (ENUM 타입: 'PLANNING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 기본값 'PLANNING')
- description: 설명 (TEXT)
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
*/
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    manager_id INT,
    budget DECIMAL(12, 2),
    start_date DATE,
    end_date DATE,
    status ENUM('PLANNING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') DEFAULT 'PLANNING',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 2. INSERT 
-- ========================================
-- 문제 2-1: employees 테이블에 다음 직원들을 INSERT하세요.
/*
직원1: 김철수, IT, 팀장, 5000000, 2023-01-15, kim.cs@company.com, 010-1111-2222
직원2: 이영희, HR, 대리, 4000000, 2023-03-20, lee.yh@company.com, 010-3333-4444  
직원3: 박민수, FINANCE, 과장, 5500000, 2022-11-10, park.ms@company.com, 010-5555-6666
*/
DESCRIBE EMPLOYEES;
INSERT INTO EMPLOYEES(EMP_NAME, DEPARTMENT, POSITION, SALARY, HIRE_DATE, EMAIL, PHONE)
VALUES ('김철수', 'IT', '팀장', 5000000, '2023-01-15', 'kim.cs@company.com', '010-1111-2222'),
('이영희', 'HR', '대리', 4000000, '2023-03-20', 'lee.yh@company.com', '010-3333-4444'),
('박민수', 'FINANCE', '과장', 5500000, '2022-11-10', 'park.ms@company.com', '010-5555-6666');

-- 문제 2-2: projects 테이블에 다음 프로젝트들을 INSERT하세요.
/*
프로젝트1: 웹사이트 리뉴얼, 매니저ID: 1, 예산: 50000000, 시작일: 2024-01-01, 종료일: 2024-06-30, 상태: IN_PROGRESS
프로젝트2: 모바일 앱 개발, 매니저ID: 3, 예산: 80000000, 시작일: 2024-02-15, 종료일: 2024-12-31, 상태: PLANNING
*/
DESCRIBE PROJECTS;
INSERT INTO PROJECTS(PROJECT_NAME, MANAGER_ID, BUDGET, START_DATE, END_DATE, STATUS)
VALUES('웹사이트 리뉴얼', '1', 50000000, '2024-01-01', '2024-06-30', 'IN_PROGRESS'),
('모바일 앱 개발', '3', 80000000, '2024-02-15', '2024-12-31', 'PLANNING');

-- 문제 2-3: 필수 컬럼만으로 INSERT하세요.
/*
직원4: 최수진, MARKETING, 사원, 3500000, 2024-01-05
직원5: 정태현, IT, 주임, 4200000, 2023-08-12
*/
INSERT INTO EMPLOYEES(EMP_NAME, DEPARTMENT, POSITION, SALARY,HIRE_DATE)
VALUES('최수진', 'MARKETING', '사원', 3500000, '2024-01-05'),
('정태현', 'IT', '주임', 4200000, '2023-08-12');


-- ========================================
-- 3. INSERT 서브쿼리
-- ========================================
-- 문제 3-1: employees 테이블에 새로운 직원을 추가하는데,
-- salary는 같은 부서의 평균 급여로 설정하세요.
/*
직원명: 홍길동, 부서: IT, 직급: 사원, 입사일: 2024-09-01, 이메일: hong.gd@company.com
급여: IT 부서의 평균 급여로 설정
*/
SET @평균월급 = (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT = 'IT');
INSERT INTO EMPLOYEES(EMP_NAME, DEPARTMENT, POSITION, HIRE_DATE, EMAIL, SALARY)
VALUES ('홍길동', 'IT', '사원', '2024-09-01', 'HONG.GD@COMPANY.COM', @평균월급);

-- 문제 3-2: projects 테이블에 새 프로젝트를 추가하는데,
-- manager_id는 IT 부서에서 급여가 가장 높은 직원의 ID로 설정하세요.
/*
프로젝트명: AI 챗봇 개발, 예산: 120000000, 시작일: 2024-10-01, 종료일: 2025-03-31, 상태: PLANNING
매니저ID: IT 부서에서 급여가 가장 높은 직원의 ID
*/

SET @직원아이디 = (SELECT EMP_ID FROM EMPLOYEES WHERE DEPARTMENT = 'IT' AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPARTMENT = 'IT'));

INSERT INTO PROJECTS(PROJECT_NAME, BUDGET, START_DATE, END_DATE, STATUS, MANAGER_ID)
VALUES ('AI챗봇개발', 120000000, '2024-10-01', '2025-03-31', 'PLANNING', @직원아이디);

-- 문제 3-3: employees 테이블에 새 직원을 추가하는데,
-- hire_date는 가장 최근에 입사한 직원의 입사일로 설정하세요.
/*
직원명: 윤서연, 부서: HR, 직급: 사원, 급여: 3800000, 이메일: yoon.sy@company.com
입사일: 가장 최근 입사 직원의 입사일과 동일하게 설정
*/
SELECT MAX(HIRE_DATE)
FROM EMPLOYEES;
SET @가장최근 = (SELECT MAX(HIRE_DATE) AS HIRE_DATEE FROM EMPLOYEES);

INSERT INTO EMPLOYEES(EMP_NAME, DEPARTMENT, POSITION, SALARY, EMAIL, HIRE_DATE)
VALUES('윤서연', 'HR', '사원', 3800000, 'YOON.SY@COMPANY.COM', @가장최근);
-- ========================================
-- 4. UPDATE
-- ========================================
-- 문제 4-1: IT 부서 직원들의 급여를 10% 인상하세요.
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT = 'IT';

-- 문제 4-2: 김철수 직원의 직급을 '부장'으로, 급여를 6000000으로 변경하세요.
UPDATE EMPLOYEES
SET POSITION = '부장', SALARY = 6000000
WHERE EMP_NAME = '김철수';


-- 문제 4-3: 2023년에 입사한 모든 직원의 부서를 'TRAINING'으로 변경하세요.
UPDATE EMPLOYEES
SET DEPARTMENT = 'TRAINING'
WHERE YEAR(HIRE_DATE) = 2023;

-- ========================================
-- 5. UPDATE 서브쿼리
-- ========================================
-- 문제 5-1: FINANCE 부서의 모든 직원 급여를 
-- 전체 직원의 평균 급여로 업데이트하세요.
SET @평균급여 = (SELECT AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES);

UPDATE EMPLOYEES
SET SALARY = @평균급여
WHERE DEPARTMENT = 'FINANACE';

-- 문제 5-2: 각 부서에서 가장 높은 급여를 받는 직원의 직급을 '팀장'으로 변경하세요.
UPDATE EMPLOYEES e
JOIN (
    SELECT
        DEPARTMENT,
        MAX(SALARY) AS max_salary
    FROM
        EMPLOYEES
    GROUP BY
        DEPARTMENT
) AS max_salaries 
ON e.DEPARTMENT = max_salaries.DEPARTMENT AND e.SALARY = max_salaries.max_salary
SET
    e.POSITION = '팀장';

SELECT * FROM EMPLOYEES;
-- 문제 5-3: 'COMPLETED' 상태인 프로젝트의 매니저들의 급여를 20% 인상하세요.
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.2
WHERE EMP_ID IN (SELECT MANAGER_ID FROM PROJECTS WHERE STATUS = 'COMPLETED');


-- ========================================
-- 6. DELETE 문제
-- ========================================

-- 문제 6-1: 재직하지 않는 직원(is_active = FALSE)들을 삭제하세요.
DELETE FROM EMPLOYEES
WHERE IS_ACTIVE = FALSE;


-- 문제 6-2: 급여가 3000000 미만이고 2024년 이전에 입사한 직원들을 삭제하세요.
DELETE FROM EMPLOYEES
WHERE SALARY < 3000000 AND YEAR(HIRE_DATE) < 2024;


-- 문제 6-3: 'CANCELLED' 상태인 프로젝트들을 모두 삭제하세요.
DELETE FROM PROJECTS
WHERE STATUS = 'CANCELLED';