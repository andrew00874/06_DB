use delivery_app;
/*
LIBRARY_MEMBER 테이블을 생성하세요.
제약조건명 규칙:
- PK: PK_테이블명_컬럼명
- UK: UK_테이블명_컬럼명  
- CK: CK_테이블명_컬럼명
컬럼 정보:
- MEMBER_NO: 회원번호 (숫자, 기본키)
- MEMBER_NAME: 회원이름 (최대 20자, 필수입력)
- EMAIL: 이메일 (최대 50자, 중복불가)
- PHONE: 전화번호 (최대 15자)
- AGE: 나이 (숫자, 7세 이상 100세 이하만 가능)
- JOIN_DATE: 가입일 (날짜시간, 기본값은 현재시간)
*/
CREATE TABLE LIBRARY_MEMBER(
-- 다른 SQL 에서는 컬럼레벨로 제약조건을 작성할 때 CONSTRAINT 를 이용해서
-- 제약조건의 명칭을 설정할 수 있지만
-- MYSQL 은 제약조건 명칭을 MYSQL 자체에서 자동생성 해주기 때문에 명칭 작성을 컬럼레벨에서 할 수 없음
-- 컬럼명칭  자료형(자료형크기)  제약조건          제약조건명칭            제약조건들설정
-- MEMBER_NO   INT               CONSTRAINT    PK_LIBRARY_MEMBER_MEMBER_NO PRIMARY KEY,
MEMBER_NO INT PRIMARY KEY, -- CONSTRAINT    PK_LIBRARY_MEMBER_MEMBER_NO  와 같은 명칭 자동생성됨
MEMBER_NAME VARCHAR(20) NOT NULL,
EMAIL VARCHAR(5)  UNIQUE, -- CONSTRAINT  UK_LIBRARY_MEMBER_EMAIL   와 같은 제약조건 명칭 자동 생성되고 관리
PHONE VARCHAR(15),
AGE INT CONSTRAINT CK_LIBRARY_AGE CHECK(AGE >=7 AND AGE <= 100),

JOIN_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*
MEMBER_NO ,EMAIL 에는 제약조건 명칭 설정이 안되지만 
단순히 PK, UNIQUE, FK, NOT NULL 과 같이 한 단어로 키 형태를 작성하는 경우 제약조건 명칭 설정 불가능

AGE 에서는 제약조건 명칭이 설정되는 이유
CHECK 처럼 제약조건이 상세할 경우에는 제약조건 명칭 설정 가능
CHECK 만 개발자가 지정한 제약조건 명칭 설정 가능
*/
-- 우리회사는 이메일을 최대 20글자 작성으로 설정 -> 21글자 유저가 회원가입이 안된다!!!! 연락
INSERT INTO LIBRARY_MEMBER (MEMBER_NO, MEMBER_NAME, EMAIL, PHONE, AGE)
VALUES (1, '김독서', 'kim@email.library_memberEMAIL_2EMAIL_2EMAIL_2MEMBER_NOcom', '010-1234-5678', 25);


-- Error Code: 1406. Data too long for column 'EMAIL' at row 1	0.016 sec
-- 컬럼에서 넣을 수 있는 크기에 비해 데이터양이 많을 때 발생하는 문제

-- 방법 1번 : DROP 해서 테이블 새로 생성한다. -> 기존 데이터는.. ? 회사 폐업 엔딩..

-- 방법 2번 : EMAIL 컬럼의 크기 변경 ALTER 수정 사용
-- 1. EMAIL 컬럼을 5자에서 50자로 변경
ALTER TABLE LIBRARY_MEMBER
MODIFY EMAIL VARCHAR(50) UNIQUE;
-- ALTER 로 컬럼 속성을 변경할 경우 컬럼명칭에 해당하는 정보를 하나 더 만들어놓은 후 해당하는 제약조건 동작
-- ALTER 에서 자세한 설명 진행..
/*
ALTER 로 컬럼에 해당하는 조건을 수정할 경우
Indexs 에 컬럼명_1 컬럼명_2 컬럼명_3 ... 과 같은 형식으로 추가가됨


Indexes
EMAIL
EAMIL_2 와 같은 형태로 존재

EMAIL   의 경우 제약조건 VARCHAR(5)  UNIQUE,
EMAIL_2 의 경우 제약조건 VARCHAR(50)  UNIQUE,

컬럼이름    인덱스들
EAMIL        EMAIL, EMAIL_2 중에서 가장 최근에 생성된 명칭으로 연결
			  하지만 새로 생성된 조건들이 마음에 들지 않아 되돌리고 싶은 경우에는
              EMAIL 과 같이 기존에 생성한 조건을 인덱스 명칭을 통해 되돌아 설정할 수 있음
              인덱스 = 제약조건명칭 동일
*/

select * from LIBRARY_MEMBER;


-- 제약조건 위반 테스트 (에러가 발생해야 정상)
INSERT INTO LIBRARY_MEMBER VALUES (1, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복
INSERT INTO LIBRARY_MEMBER VALUES (6, '이나이', 'lee@email.com', '010-7777-6666', 5, DEFAULT); -- 나이 제한 위반
-- rror Code: 3819. Check constraint 'CK_LIBRARY_AGE' is violated.	0.000 sec

INSERT INTO LIBRARY_MEMBER VALUES (2, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복






CREATE TABLE PRODUCT (
PRODUCT_ID VARCHAR(10) PRIMARY KEY, -- AUTO_INCREMENT 정수만 가능 VARCHAR 사용 불가
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT constraint CH_PRODUCT_PRICE CHECK(PRICE >0),
STOCK INT DEFAULT 0 CHECK(STOCK>=0), --  constraint 제약조건 제약조건명칭은 필수가 아님 작성안했을 경우 자동완성
STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);
/*
2) ORDER_ITEM 테이블:
- ORDER_NO: 주문번호 (문자 20자)  
- PRODUCT_ID: 상품코드 (문자 10자)
- QUANTITY: 주문수량 (숫자, 1 이상만 가능)
- ORDER_DATE: 주문일시 (날짜시간, 기본값은 현재시간)
*/
CREATE TABLE ORDER_ITEM(
ORDER_NO varchar(20),
PRODUCT_ID VARCHAR(10),
QUANTITY INT CHECK(QUANTITY >= 1),
ORDER_DATE DATETIME DEFAULT current_timestamp
);


INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- CREATE TABLE 할 때 FK(FOREIGN KEY) 를 작성하지 않아
-- 존재하지 않는 제품번호의 주문이 들어오는 문제가 발생
-- 제품이 존재하고, 제품번호에 따른 주문
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);



-- 테이블 다시 생성
-- 테이블이 존재하는게 맞다면 삭제하겠어
-- 왜래키가 설정되었을 경우 메인 테이블은 
-- 메인을 기준으로 연결된 데이터가 자식테이블에 존재할 경우
-- 자식 테이블을 삭제한 후 메인 테이블을 삭제할 수 있다.
-- > ORDER_ITEM 삭제한 후 PRODUCT 테이블을 삭제할 수 있다.
-- 배달의 민족 - 가게 - 상품 - 주문
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS ORDER_ITEM;

-- 메인이 되는 테이블 생성
CREATE TABLE PRODUCT (
PRODUCT_ID VARCHAR(10) PRIMARY KEY, -- AUTO_INCREMENT 정수만 가능 VARCHAR 사용 불가
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT constraint CH_PRODUCT_PRICE CHECK(PRICE >0),
STOCK INT DEFAULT 0 CHECK(STOCK>=0), --  constraint 제약조건 제약조건명칭은 필수가 아님 작성안했을 경우 자동완성
STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);
-- ORDER_ITEM 에서 
-- CONSTRAINT ABC FOREIGN KEY  (PRODUCT_ID)   references PRODUCT(PRODUCT_ID) 테이블 레벨로 존재하는 외래키를
-- 위 내용 참조하여 컬럼 레벨로 설정해서   ORDER_ITEM  테이블 생성
-- 상품이 있어야 주문 가능
CREATE TABLE ORDER_ITEM(
ORDER_NO varchar(20),
PRODUCT_ID VARCHAR(10),
QUANTITY INT CHECK(QUANTITY >= 1),
ORDER_DATE DATETIME DEFAULT current_timestamp,
/*
--  ORDER_ITEM 테이블 안에서 PRODUCT_ID 컬럼은  PRODUCT 테이블 내에 존재하는 컬럼 중 PRODUCT_ID 컬럼명칭과 연결할 것이다.
-- 단순 참조용
--  PRODUCT_ID VARCHAR(10) references PRODUCT(PRODUCT_ID),CONSTRAINT 제약조건명칭 자동 생성
-- 왜래키를 작성할 때는 반드시 FOREIGN KEY 라는 명칭이 필수로 컬럼 레벨이나 테이블 레벨에 무조건 들어가야함

-- 왜래키의 경우에는 보통 테이블 레벨 형태로 작성
-- ORDER_ITEM 테이블내 존재하는  PRODUCT_ID는 PRODUCT테이블에  PRODUCT_ID 을 참조할 것이다.
-- 라는 조건의 내용을 ABC 라는 명칭 내에 저장하겠다 설정
*/
CONSTRAINT ABC FOREIGN KEY  (PRODUCT_ID)   references PRODUCT(PRODUCT_ID)
);

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- CREATE TABLE 할 때 FK(FOREIGN KEY) 를 작성하지 않아
-- 존재하지 않는 제품번호의 주문이 들어오는 문제가 발생
-- 제품이 존재하고, 제품번호에 따른 주문

INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);
-- PRODUCT 테이블에 존재하지 않은 상품번호로 주문이 들어와 외래키 조건에 위배되는 현상 발생 으로 주문 받지 않음
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`delivery_app`.`order_item`, CONSTRAINT `ABC` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PRODUCT_ID`))	0.016 sec


