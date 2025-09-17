/*
SELECT 문 해석 순서

5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
1 : FROM 참조할 테이블 명
2 : WHERE 컬럼명 | 함수식 비교연산자 비교값
3 : GROUP BY 그룹을 묶을 컬럼명
4 : HAVING 그룹함수식 비교연산자 비교값
6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST];

*/
-- EMPLOYEES 테이블에서 사원 수 조회
SELECT DEPT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPT_ID;

-- EMPLOYEES 테이블에서
-- 부서별 보너스를 받는 사원 수 조회
SELECT DEPT_ID, COUNT(*)
FROM EMPLOYEES
WHERE SALARY >= 60000000
GROUP BY DEPT_ID;

-- EMPLOYEES 테이블에서
-- 부서 ID, 부서별 급여의 합계 as 급여 합계
-- 부서 별 급여의 평균(정수처리) as 급여 평균
-- 인원 수 조회 as 인원수
-- 부서 ID 순으로 오름차순 정렬
SELECT DEPT_ID, SUM(SALARY) AS '급여 합계', FLOOR(AVG(SALARY)) AS '평균 급여', COUNT(*) AS '인원수'
FROM EMPLOYEES
GROUP BY DEPT_ID;

-- 부서 ID 가 4, 5 인 부서의 평균 급여조회
SELECT DEPT_ID, FLOOR(AVG(SALARY)) AS '평균 급여'
FROM EMPLOYEES
WHERE DEPT_ID IN (4,5)
GROUP BY DEPT_ID;

-- EMPLOYEES 테이블에서 직급 별 2020년도 이후 입사자들의 급여 합 조회
-- POSITION_ID YEAR(HIRE_DATE) SALARY

SELECT POSITION_ID, SUM(SALARY)
FROM EMPLOYEES
WHERE YEAR(HIRE_DATE) >= 2020
GROUP BY POSITION_ID;

/*
GROUP BY 사용시 주의사항
SELECT 문에 GROUP BY 절을 사용할 경우
SELECT 절에 명시한 조회하려는 칼럼 중에서
GROUP 함수가 적용되지 않은 컬럼은 모두
다 GROUP BY 절에 작성해야함
*/

-- EMPLOYEES 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서 ID 오름차순으로 정렬

SELECT DEPT_ID, POSITION_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPT_ID, POSITION_ID
ORDER BY DEPT_ID;

-- EMPLOYEES 테이블에서 부서 별로 직급이 같은 직원의 수를 조회하고
-- 부서 ID, 직급 ID 오름차순으로 정렬
SELECT POSITION_ID, DEPT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY POSITION_ID, DEPT_ID
ORDER BY POSITION_ID, DEPT_ID;

-- 부서별 평균 급여를 조회하고
-- 부서를 조회하여 부서ID 오름차순으로 정렬
SELECT DEPT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPT_ID
ORDER BY DEPT_ID;