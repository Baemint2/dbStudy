/* 
    DDL(데이터 정의어)
    종류
    1) CREATE : 생성
    2) ALTER : 수정
    3) DROP : 삭제(완전삭제)
    4) TRUNCATE : 삭제(내용만 삭제)
    DML(데이터 조작어)
    DCL(데이터 제어어)
    TCL(Commit, Rollback, SAVEPOINT)
*/

-- 스크립트 생성시 삭제를 먼저 작성한 뒤(실행한 뒤) 생성

-- 테이블 삭제
DROP TABLE CUSTOMER_T;
DROP TABLE BANK_T;

-- 테이블 생성
CREATE TABLE BANK_T(
    BANK_CODE                       VARCHAR2(20) NOT NULL,
    BANK_NAME                       VARCHAR2(30),
    CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE)
    );
    
CREATE TABLE CUSTOMER_T(
    CUST_NO                            NUMBER NOT NULL,
    CUST_NAME                          VARCHAR2(30) NOT NULL,
    CUST_PHONE                         VARCHAR2(30) UNIQUE,
    CUST_AGE                           NUMBER(3) CHECK(CUST_AGE >= 0 AND CUST_AGE <= 120),
                                                    -- CHECK(CUST_AGE 0 BETWEEN 120)
    BANK_CODE                          VARCHAR2(20),
    CONSTRAINT PK_CUSTOMER  PRIMARY KEY(CUST_NO),
    CONSTRAINT FK_CUSTOMER_BANK FOREIGN KEY (BANK_CODE) REFERENCES BANK_T(BANK_CODE)
    );
    -- FK 적을 때 자식 테이블 먼저 작성 후 부모 테이블
    -- ex) FK_자식_부모
    -- CONSTRAINT 제약조건명 제약조건 (테이블명)  REFERENCES 부모 테이블 명(테이블)
SELECT * FROM USER_CONSTRAINTS;

/*
    테이블 수정하기
    1. 컬럼 추가하기 (ADD) : ALTER TABLE 테이블명 ADD                         칼럼명 DATA TYPE 제약 조건
    2. 컬럼 수정하기 (MODIFY)  : ALTER TABLE 테이블명 MODIFY            칼럼명 DATA TYPE 제약 조건
    3. 컬럼 삭제하기 (DROP) : ALTER TABLE 테이블명 DROP COLUMN 칼럼명
    4. 컬럼 이름바꾸기 ( RENAME) : ALTER TABLE 테이블명 RENAME COLUMN 기존 칼럼 TO 신규 칼럼
    5. 테이블 이름 바꾸기 (RENAME) : ALTER TABLE 테이블명 RENAME TO 신규테이블
*/

-- 1. BANK_T에 연락처 (BANK_TEL) 칼럼을 추가하시오.
ALTER TABLE BANK_T ADD BANK_TEL VARCHAR2(30)
-- 2. bank_T의 은행명 (BANK_NAME) 칼럼을 VARCHAR2(15)로 바꾸고 필수 제약 조건을 지정
ALTER TABLE BANK_T MODIFY BANK_NAME VARCHAR2(15) NOT NULL;
---- 3. CUSTOMER_T의 나이(CUST_AGE) 칼럼을 삭제하시오.
ALTER TABLE CUSTOMER_T DROP COLUMN CUST_AGE;
-- 4. CUSTOMER_T의 연락처(CUST_PHONE) 칼럼명을 CUST_TEL로 수정하시오.
ALTER TABLE CUSTOMER_T RENAME COLUMN CUST_PHONE TO CUST_TEL;
-- 5. CUSTOMER_T에 등급(GRADE) 칼럼을 추가하시오. 'VIP', 'GOLD', 'SILVER', 'BRONZE' 중 하나의 값을 가지도록 설정
ALTER TABLE CUSTOMER_T ADD GRADE VARCHAR2(20) CHECK(GRADE IN('VIP','GOLD','SILVER','BRONZE'));
SELECT * FROM CUST_T;
SELECT * FROM BANK_T;
INSERT INTO CUST_T VALUES(1, '테스트', '010-1234-2134', 1, 'TEST');
INSERT INTO CUST_T VALUES(1, '테스트', '010-1234-2134', 1, 'VIP');
INSERT INTO BANK_T VALUES(1, '구디은행', '010-1234-1234');
-- 6. CUSTOMER_T의 고객명(CUST_NAME) 칼럼의 필수 제약 조건을 없애시오.
ALTER TABLE CUST_T MODIFY CUST_NAME VARCHAR2(30) NULL;
-- 7. CUSTOMER_T의 테이블명을 CUST_T로 수정하시오
ALTER TABLE CUSTOMER_T RENAME TO CUST_T

/* 테이블 수정하기 - PK/FK 제약조건
        1. PK
            1)추가 : ALTER TABLE 테이블명 ADD CONSTRAINT 제약 조건명 PRIMARY KEY(지정할 칼럼명)
            2)삭제
                (1) ALTER TABLE 테이블명 DROP CONSTRAINT 제약 조건명?
                (2) ALTER TABLE 테이블명 DROP PRIMARY KEY
        2. FK
            1) 추가 : ALTER TABLE 자식 테이블명 ADD CONSTRAINT 제약 조건명
                      FOREIGN KEY (자식 칼럼명) REFERENCES 부모 테이블(참조할 칼럼명) [ 옵션 ];
                      옵션 -> ON DELETE SET NULL, ON DELETE CASCADE;
            2) 삭제 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약 조건명
            3) 비활성화 : ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약조건명;
            4) 활성화 : ALTE TABLE 테이블명 ENABLE CONSTRAINT 제약조건명;
*/

-- FK_CUSTOMER_BANK 제약조건을 비활성화 하시오.
SELECT * FROM CUST_T;
SELECT * FROM BANK_T;
SELECT * FROM USER_CONSTRAINTS;
ALTER TABLE CUST_T DISABLE CONSTRAINT FK_CUSTOMER_BANK;
INSERT INTO CUST_T VALUES(2, '테스트', '010-1234-1324', 2, 'SILVER');
ALTER TABLE CUST_T ENABLE CONSTRAINT FK_CUSTOMER_BANK;
DELETE FROM CUST_T WHERE(CUST_TEL = '010-1234-1324');
