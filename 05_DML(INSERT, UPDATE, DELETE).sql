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
-- INSERT INTO 테이블이름 VALUES (필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
-- , 로 구분하여 여러 행을 한 번에 입력 후, 데이터를 저장할 수 있다.
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

SELECT *
FROM MEMBER;