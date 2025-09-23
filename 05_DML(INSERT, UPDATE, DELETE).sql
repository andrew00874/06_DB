-- DML (DATA MANIPULATION LANGUAGE) : 데이터 조작 언어

-- 데이터에 값을 삽입하거나, 수정하거나, 삭제하는 구문

-- 주의 : COMMIT, ROLLBACK을 실무에서 혼자서 하지 말 것 !!

CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);

SELECT * FROM MEMBER;
-- =================================
-- INSERT 구문
-- INSERT INTO 테이블이름 
-- 		  VALUES (데이터, 데이터, 데이터, ...)
-- 모든 COLUMN 에 대한 값을 넣을 때는 컬럼명칭은 생략하고 순서대로 VALUES에 추가할 데이터 작성
-- =================================

-- 모든 컬럼에 대한 값 저장 (AUTO_INCREMENT 제외)
INSERT INTO MEMBER
		VALUES (
        NULL,     -- MEMBER_ID (AUTO_INCREMENT 이므로 NULL)
        'HONG1234', -- USERNAME 닉네임
        'PASS1234', -- PASSWORD 비밀번호
        'HONG@GMAIL.COM', -- EMAIL 이메일
        '홍길동', -- NAME 이름
        '010-1234-2323', -- PHONE 전화번호
        '1999-12-12', -- BIRTH_DATE 생년월일
        'M', -- GENDER 성별
        '서울시 어딘가', -- ADDRESS 주소
        NOW(), -- JOIN_DATE 가입일자 현재시간 기준
        'ACTIVE' -- STATUS 계정 상태
        );

-- =============================================
-- 실습 문제 1: 기본 INSERT 구문
-- =============================================
-- 문제: 다음 회원 정보들을 한 번에 INSERT하세요.
/*
회원1: jane_smith, password456, jane@example.com, 김영희, 010-9876-5432, 1992-08-20, F, 부산시 해운대구, 현재시간, ACTIVE
회원2: mike_wilson, password789, mike@example.com, 이철수, 010-5555-7777, 1988-12-03, M, 대구시 중구, 현재시간, ACTIVE  
회원3: sarah_lee, passwordabc, sarah@example.com, 박미영, 010-3333-9999, 1995-03-10, F, 광주시 서구, 현재시간, INACTIVE
*/

INSERT INTO MEMBER
VALUES 
(NULL, 'jane_smith', 'password456', 'jane@example.com', '김영희', '010-9876-5432', '1992-08-20', 'F', '부산시 해운대구', NOW(), 'ACTIVE');

INSERT INTO MEMBER
VALUES 
(NULL, 'mike_wilson', 'password789', 'mike@example.com', '이철수', '010-5555-7777', '1988-12-03', 'M', '대구시 중구', NOW(), 'ACTIVE');

INSERT INTO MEMBER
VALUES 
(NULL, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'F', '광주시 서구', NOW(), 'INACTIVE');

SELECT *
FROM MEMBER;


-- =================================
-- INSERT 구문 여러 행을 한번에 입력
-- INSERT INTO 테이블이름 
-- 		  VALUES (데이터1, 데이터1, 데이터1, ...),
-- 		  VALUES (데이터2, 데이터2, 데이터2, ...),
-- 		  VALUES (데이터3, 데이터3, 데이터3, ...);
-- , 로 구분하여 여러 행을 한 번에 입력 후, 데이터를 저장할 수 있다.
-- =================================


INSERT INTO MEMBER
VALUES
(NULL, 'mini1004', 'pard456', 'mini1004@example.com', '김미니', '010-9823-2332', '2001-02-02', 'F', '서울시 강남구 역삼동', NOW(), 'ACTIVE'),
(NULL, 'soo5678', 'pa3789', 'soo5678@example.com', '장민수', '010-3353-7777', '2002-02-03', 'M', '서울시 동작구 흑석동', NOW(), 'ACTIVE'),
(NULL, 'soninuki', 'qlalfqjsgh123', 'soninuki@example.com', '손인욱', '010-3331-9999', '1995-03-10', 'M', '이천시 남구', NOW(), 'INACTIVE');

-- =================================
-- INSERT 필수 컬럼만 입력 -> 모든 컬럼에 데이터를 넣지 않고
-- 컬럼명칭 옆에 NOT NULL 인 컬럼명칭만 지정하여 데이터를 넣을 수 있음
-- 주의할 점 : NOT NULL은 필수로 데이터를 넣어야하는 공간이기 때문에 생략 불가능

-- 하나의 INSERT 구문 추가하는 방법
-- INSERT INTO 테이블이름 (필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
-- 				VALUES (데이터, 데이터, 데이터, ...);			
	
-- 두개 이상의 INSERT 구문 추가하는 방법
-- INSERT INTO 테이블이름 (필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
-- 				VALUES (데이터1, 데이터1, 데이터1, ...),
-- 				VALUES (데이터2, 데이터2, 데이터2, ...),
-- 				VALUES (데이터3, 데이터3, 데이터3, ...);
-- , 로 구분하여 여러 행을 한 번에 입력 후, 데이터를 저장할 수 있다.
-- AUTO_INCREMENT 가 설정된 컬럼은 번호가 자동으로 부여될 것이고,
-- 이외 컬럼데이터는 모두 NULL 이나 0의 값으로 데이터가 추가될 것이다.
-- 여기서 DEFAULT 설정된 데이터는 DEFAULT 로 설정된 기본 데이터가 추가될 것이다.
-- =================================

-- =============================================
-- 실습 문제 1: 필수 컬럼만 INSERT
-- =============================================
-- 문제: 다음 회원들을 필수 컬럼(username, password, email, name)만으로 INSERT하세요.
-- 나머지 컬럼들은 기본값 또는 NULL이 됩니다.

/*
회원1: user_basic1, basicpass123, basic1@email.com, 기본유저1
회원2: user_basic2, basicpass456, basic2@email.com, 기본유저2  
회원3: user_basic3, basicpass789, basic3@email.com, 기본유저3
*/
DELETE FROM MEMBER WHERE USERNAME = 'user_basic1';
INSERT INTO MEMBER VALUES (NULL ,'user_basic1', 'basicpass123', 'basic1@email.com', '기본유저1', NULL, NULL, NULL, NULL, DEFAULT, DEFAULT),
(NULL ,'user_basic2', 'basicpass456', 'basic2@email.com', '기본유저2', NULL, NULL, NULL, NULL, DEFAULT, DEFAULT),
(NULL ,'user_basic3', 'basicpass789', 'basic3@email.com', '기본유저3', NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);

INSERT INTO MEMBER (username, password, email, name)
VALUES ('user_basic1', 'basicpass123', 'basic1@email.com', '기본유저1'),
('user_basic2', 'basicpass456', 'basic2@email.com', '기본유저2'),
('user_basic3', 'basicpass789', 'basic3@email.com', '기본유저3');

-- =============================================
-- INSERT INTO 테이블명 (컬럼명, ...) VALUES(데이터, ...)
-- 특정 컬럼만 지정하여 데이터 저장 (필수 + 선택사항)
-- =============================================

/*
CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
*   username VARCHAR(50) NOT NULL UNIQUE,
*   password VARCHAR(255) NOT NULL,
*   email VARCHAR(100) NOT NULL UNIQUE,
*   name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);
  * 표시한 컬럼은 INSERT 할 때 반드시 채워야 하는 부분임.
*/
INSERT INTO member (username, password, email, name, phone, gender)
			values ('admin_user', 'admin_pass', 'admin@gmail.com', '관리자', '010-5686-3434', 'M');
            
            
SELECT *
FROM MEMBER;

INSERT INTO member
	   VALUES (
      null, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'f', '광주시 서구', now(), 'INACTIVE'
       );

INSERT INTO member
	   VALUES (
      null, 'sarah_lee', 'abc1234', 'meyoung@example.com', '오미영', '010-4567-1234', '1998-04-10', 'f', '서울시 서초구', now(), 'ACTIVE'
       );
       
       
-- =============================================
-- INSERT 실습문제
-- =============================================

-- 문제 1: 다음 회원 정보를 주어진 컬럼 순서에 맞춰 INSERT하세요.
-- 컬럼 순서: password, username, email, name, phone, gender
-- 회원 데이터: hong123, hong_pass, hong@naver.com, 홍길동, 010-1234-5678, M
INSERT INTO MEMBER(PASSWORD, USERNAME, EMAIL, NAME, PHONE, GENDER)
VALUES('HONG123', 'HONG_PASS', 'HONG@NAVER.COM', '홍길동', '010-1234-5678', 'M');


-- 문제 2: 필수 컬럼 4개를 다른 순서로 INSERT하세요.
-- 컬럼 순서: email, name, password, username  
-- 회원 데이터: kim_student, student123, kim@gmail.com, 김영희
INSERT INTO MEMBER(EMAIL, NAME, PASSWORD, USERNAME)
VALUES('KIM@GMAIL.COM', '김영희', 'STUDENT123', 'KIM_STUDENT');

-- 문제 3: 생년월일과 성별을 포함해서 다른 순서로 INSERT하세요
-- 컬럼 순서: birth_date, username, gender, email, name, password
-- 회원 데이터: park_teacher, teacher456, park@daum.net, 박철수, 1985-03-15, M
INSERT INTO MEMBER(BIRTH_DATE, USERNAME, GENDER, EMAIL, NAME, PASSWORD)
VALUES ('1985-03-15', 'PARK_TEACHER', 'M', 'PARK@DAUM.NET', '박철수', 'TEACHER456');

-- 문제 4: 주소를 포함해서 컬럼 순서를 바꿔 INSERT하세요.
-- 컬럼 순서: address, phone, birth_date, gender, name, email, password, username
-- 회원 데이터: lee_manager, manager789, lee@company.co.kr, 이미영, F, 1990-07-20, 010-9876-5432, 서울시 강남구 역삼동
INSERT INTO member (address, phone, birth_date, gender, name, email, password, username)
VALUES ('서울시 강남구 역삼동', '010-9876-5432', '1990-07-20', 'F', '이미영', 'lee@company.co.kr', 'manager789', 'lee_manager');

-- 문제 5: 회원 상태를 포함해서 INSERT하세요.
-- 컬럼 순서: status, gender, username, password, email, name, phone
-- 회원 데이터: choi_admin, admin999, choi@admin.kr, 최관리, 010-5555-7777, INACTIVE, M
INSERT INTO member (status, gender, username, password, email, name, phone)
VALUES ('INACTIVE', 'M', 'choi_admin', 'admin999', 'choi@admin.kr', '최관리', '010-5555-7777');

-- 문제 6: 3명의 회원을 각각 다른 컬럼 순서로 한 번에 INSERT하세요.
-- 순서: username, password, email, name, phone, gender
/*
회원1: jung_user1, pass1234, jung1@kakao.com, 정수민, 010-1111-2222, F
회원2: kang_user2, pass5678, kang2@nate.com, 강동원, 010-3333-4444, M  
회원3: yoon_user3, pass9012, yoon3@hanmail.net, 윤서연, 010-5555-6666, F
*/
INSERT INTO member (username, password, email, name, phone, gender)
VALUES
('jung_user1', 'pass1234', 'jung1@kakao.com', '정수민', '010-1111-2222', 'F'),
('kang_user2', 'pass5678', 'kang2@nate.com', '강동원', '010-3333-4444', 'M'),
('yoon_user3', 'pass9012', 'yoon3@hanmail.net', '윤서연', '010-5555-6666', 'F');


-- 문제 7: 다음 잘못된 INSERT문을 올바르게 수정하세요.
-- 잘못된 예제 (실행하지 마세요.):
-- INSERT INTO member (username, password, email, name, phone) 
-- VALUES ('010-7777-8888', 'song_user', 'song@lycos.co.kr', 'songpass', '송지효');
INSERT INTO member (username, password, email, name, phone)
VALUES ('song_user', 'songpass', 'song@lycos.co.kr', '송지효', '010-7777-8888');	

-- 문제 8: 전화번호와 주소는 제외하고 다른 순서로 INSERT하세요.
-- 컬럼 순서: gender, birth_date, name, email, username, password
-- 회원 데이터: oh_student, student321, oh@snu.ac.kr, 오수진, 1995-12-03, F
INSERT INTO member (gender, birth_date, name, email, username, password)
VALUES ('F', '1995-12-03', '오수진', 'oh@snu.ac.kr', 'oh_student', 'student321');

-- 문제 9: 모든 컬럼을 포함해서 순서를 바꿔 INSERT하세요.
-- 컬럼 순서: address, status, gender, birth_date, phone, name, email, password, username
-- 회원 데이터: han_ceo, ceo2024, han@bizmail.kr, 한대표, 010-8888-9999, 1975-05-25, M, ACTIVE, 부산시 해운대구 우동
INSERT INTO member (address, status, gender, birth_date, phone, name, email, password, username)
VALUES ('부산시 해운대구 우동', 'ACTIVE', 'M', '1975-05-25', '010-8888-9999', '한대표', 'han@bizmail.kr', 'ceo2024', 'han_ceo');

-- 문제 10: 5명의 한국 회원을 서로 다른 컬럼 순서로 INSERT하세요.

/*
회원1: 김민수, minsoo_kim, minpass1, minsoo@gmail.com, 010-1010-2020, M
회원2: 이소영, soyoung_lee, sopass2, soyoung@naver.com, 010-3030-4040, F
회원3: 박준혁, junhyuk_park, junpass3, junhyuk@daum.net, 010-5050-6060, M
회원4: 최유진, yujin_choi, yujinpass4, yujin@hanmail.net, 010-7070-8080, F  
회원5: 장태현, taehyun_jang, taepass5, taehyun@korea.kr, 010-9090-1010, M
*/

-- 회원1 순서: name, username, password, email, phone, gender

-- 회원2 순서: username, gender, email, name, password, phone  

-- 회원3 순서: email, phone, username, password, name, gender

-- 회원4 순서: gender, name, phone, email, username, password

-- 회원5 순서: phone, email, gender, username, password, name

-- 회원 1
INSERT INTO member (name, username, password, email, phone, gender)
VALUES ('김민수', 'minsoo_kim', 'minpass1', 'minsoo@gmail.com', '010-1010-2020', 'M');

-- 회원 2
INSERT INTO member (username, gender, email, name, password, phone)
VALUES ('soyoung_lee', 'F', 'soyoung@naver.com', '이소영', 'sopass2', '010-3030-4040');

-- 회원 3
INSERT INTO member (email, phone, username, password, name, gender)
VALUES ('junhyuk@daum.net', '010-5050-6060', 'junhyuk_park', 'junpass3', '박준혁', 'M');

-- 회원 4
INSERT INTO member (gender, name, phone, email, username, password)
VALUES ('F', '최유진', '010-7070-8080', 'yujin@hanmail.net', 'yujin_choi', 'yujinpass4');

-- 회원 5
INSERT INTO member (phone, email, gender, username, password, name)
VALUES ('010-9090-1010', 'taehyun@korea.kr', 'M', 'taehyun_jang', 'taepass5', '장태현');

-- =============================================
-- UPDATE 이미 존재하는 데이터의 값을 수정(변경)할 때 사용하는 조작 언어
-- UPDATE 테이블이름
-- SET 컬럼명1 = 새롭게 추가할 값1
-- SET 컬럼명2 = 새롭게 수정할 값2,
-- ... 
-- WHERE 조건;
-- 주의할점 : WHERE 절이 없으면 해당 테이블의 모든 데이터가
-- 한번에 변경되므로 데이터 유실이 발생할 수 있음
-- 모든 데이터를 한 번에 변경해야 하는 일이 아닌 한 WHERE 은 사용이 필수다.
-- UPDATE 는 ERROR 가 거의 일어나지 않음
-- 왜냐하면 WHERE 에 해당하는 조건을 찾고, 해당하는 조건이 없으면 없는대로
-- 있으면 있는대로 조건에 맞춰 변경하기 때문이다.
-- =============================================

-- USERNAME 이 HONG1234인 홍길동 회원의 핸드폰 번호를 변경
-- WHERE 절을 이용해서 특정 회원 한 명만 정확히 변경하는게 중요!!!!

UPDATE member
SET PHONE= '010-8765-4321'
WHERE
	username = 'hong1234';
    
SELECT * FROM MEMBER WHERE USERNAME = 'HONG1234';

UPDATE MEMBER
SET EMAIL = 'HONG1234@GMAIL.COM',
	ADDRESS = '인천시 남구'
WHERE USERNAME = 'HONG1234';

-- 1175 : 모든 데이터를 한 번에 수정하거나 삭제하는 것을 방지하기 위한 MYSQL 안전장치
-- 안전모드 비 활성화
SET SQL_SAFE_UPDATES =0;

UPDATE MEMBER
SET JOIN_DATE = CURRENT_TIMESTAMP;

-- 안전모드 활성화
SET SQL_SAFE_UPDATES = 1;


-- 문제 1: username이 'mike_wilson'인 이철수 회원의 이메일 주소를 'mike.w@naver.com'으로 변경하세요.
UPDATE MEMBER
SET EMAIL = 'MIKE.W@NAVER.COM'
WHERE USERNAME = 'MIKE_WILSON';
-- 문제 2: member_id가 5번인 회원의 상태(status)를 'SUSPENDED'로, 주소(address)를 '확인 필요'로 변경하세요.
UPDATE MEMBER
SET STATUS = 'SUSPENDED',
	ADDRESS = '확인필요'
WHERE MEMBER_ID = 5;
-- 문제 3: 1990년 이전에 태어난 모든 회원의 상태(status)를 'INACTIVE'로 변경하세요.
UPDATE MEMBER
SET STATUS = 'INACTIVE'
WHERE BIRTH_DATE < '1990-01-01';

-- ===========================================
-- DELETE
-- 테이블의 행을 삭제하는 구문
-- [작성법]
-- DELETE FROM 테이블명 WHERE 조건설정
-- 만약 WHERE 조건을 설정하지 않으면 모든 행이 다 삭제됨

-- DELETE 작업을 하기 전에 개발자가 잠시 수행하는 작업 중 하나
-- 가볍게 저용량의 테이블을 삭제할 경우 많이 사용

-- 테스트용 테이블 생성 (기존 STORES 테이블 복사)
CREATE TABLE STORES_COPY AS SELECT * FROM STORES;
-- 테스트용 테이블 삭제
DROP TABLE STORES_COPY;
-- ===========================================

USE DELIVERY_APP;
CREATE TABLE STORES_COPY AS SELECT * FROM STORES;
SELECT * FROM STORES_COPY_2;

SELECT @SQL_MODE; -- SQL 에서 아무런 설정이 되어있지 않은 상태
INSERT INTO STORES_COPY_2
VALUES(NULL, '솔라나치킨', '치킨', '서울시 강남구 테스토스테론 999', '02-000-1234', 4.8, 3000);
-- member 테이블은 null이 되고, stores_copy null이 안되는 이유
-- member 테이블은 직접적으로 create table 부터 모두 작성해서 만든 상태인데,
-- stores_copy는 만들어진 테이블을 가볍게 복제한 형태 (auto_increment) 는 복제되지않는다.
-- 속성은 추가로 설정해야함
-- 속성까지 모두 복제하려면
CREATE TABLE STORES_COPY_2 LIKE STORES; -- 속성 복제
INSERT INTO STORES_COPY_2 SELECT * FROM STORES; -- 데이터 주입
DROP TABLE STORES_COPY;
-- Error Code: 1048. Column 'id' cannot be null	0.000 sec
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM STORES_COPY_2;

-- 배달비 4000원 이상 매장 삭제
DELETE
FROM STORES_COPY_2
WHERE DELIVERY_FEE >= 4000;

-- 평점 4.5 미만의 치킨집 삭제
DELETE
FROM STORES_COPY_2
WHERE RATING < 4.5 AND CATEGORY = '치킨';

-- 전화번호가 NULL 인 매장들 삭제
DELETE
FROM STORES_COPY_2
WHERE PHONE IS NULL;

DROP TABLE STORES_COPY_2;


CREATE TABLE STORE_DEV_TEST LIKE STORES;
INSERT INTO STORE_DEV_TEST SELECT * FROM STORES;

SELECT * FROM STORE_DEV_TEST;

DELETE FROM STORE_DEV_TEST
WHERE ID IN (1,2,3);

DELETE FROM STORE_DEV_TEST
WHERE NAME LIKE '%치킨%';