/*
    DML(데이터 조작어)
    1. Data Manipulation Language
    2.Select, Insert, Delete, Update
    5.종류
     1) 행 삽입 : INSERT INTO 테이블명(테이블 컬럼명, 생략가능) VALUES (넣을 데이터 값)
     2) 행 수정 : UPDATE 테이블명 SET 값1, 값2, 값3 WHERE(조건)
     3) 행 삭제 : DELETE FROM 테이블명 WHERE(조건)
     
*/
/*
    트랜잭션 (ACID)
    원자성(Atomicity), 독립성(isolation), 일관성(Consistency), 지속성(Durability)
    1. 한번에 수행해야하는 작업을 의미한다.
    2. 2가지 이상의 작업이 하나의 트랜잭션으로 구성된다.
    3. Commit -> 작업 저장 / RollBack -> 작업 취소
    4. 예시 : 은행 이체
        1) 내 통장에서 돈 빼기
        2) 상대방 통장에 돈 넣기
*/

/*
    시퀀스
    1. 일련번호를 생성하는 데이터베이스 객체 ex) MySQL = AUTO_INCREMENT
    2. 주로 기본키의 값을 생성할 때 사용한다.
    3. 함수
        1) 새 번호 생성하기 : NEXTVAL
        2) 현재 번호 확인하기 : CURRVAL

*/

-- 부서 테이블의 부서 번호를 생성하는 시퀀스 만들기

DROP SEQUENCE DEPT_SEQ;
DROP SEQUENCE EMPLO_SEQ;

CREATE SEQUENCE DEPT_SEQ
    INCREMENT BY 1  -- 1 씩 증가하는 번호
    START WITH 1    -- 1부터 번호 생성
    NOMAXVALUE      -- 상한선 없음
    NOMINVALUE      -- 하한선 없음
    NOCYCLE         -- 번호 순환 없음
    NOCACHE        -- 20개의 번호를 미리 생성 (번호를 미리 생성하지 않는 NOCACHE 옵션을 사용함)
    NOORDER         -- 번호를 순서 없이 사용
;


CREATE sequence EMPLO_SEQ
    START WITH 1001
    NOCACHE
    ;

DROP TABLE EMPLOYEE_T;
DROP TABLE DEPARTMENT_T;

CREATE TABLE DEPARTMENT_T (
    DEPT_NO NUMBER NOT NULL ,
    DEPT_NAME VARCHAR2(15) NOT NULL,
    LOCATION  VARCHAR2(15) NOT NULL,
    CONSTRAINT PK_DEPT PRIMARY KEY(DEPT_NO)
);

CREATE TABLE EMPLOYEE_T (
    EMP_NO NUMBER NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    DEPART NUMBER,
    POSITION VARCHAR(20) ,
    GENDER CHAR(2),
    HIRE_DATE DATE,
    SALARY NUMBER,
    CONSTRAINT PK_EMPLOYEE PRIMARY KEY(EMP_NO),
    CONSTRAINT FK_EMPLOYEE FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_T(DEPT_NO) ON DELETE SET NULL
    );
    
INSERT INTO DEPARTMENT_T VALUES(DEPT_SEQ.NEXTVAL,'영업부', '대구');
INSERT INTO DEPARTMENT_T VALUES(DEPT_SEQ.NEXTVAL,'인사부', '서울');
INSERT INTO DEPARTMENT_T VALUES(DEPT_SEQ.NEXTVAL,'총무부', '대구');
INSERT INTO DEPARTMENT_T VALUES(DEPT_SEQ.NEXTVAL,'기획부', '서울');

INSERT INTO EMPLOYEE_T VALUES(EMPLO_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95/05/01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(EMPLO_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17/09/01', 2500000);
INSERT INTO EMPLOYEE_T VALUES(EMPLO_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90/09/01', 5500000);
INSERT INTO EMPLOYEE_T VALUES(EMPLO_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93/04/01', 5000000);



--SELECT D.DEPT_NAME, D.LOCATION, E.NAME, E.POSITION, E.SALARY FROM department_t D ,EMPLOYEE_T E
--WHERE D.DEPT_NO = E.DEPART;

--SELECT  * FROM EMPLOYEE_T
--WHERE NAME LIKE '%민%';

COMMIT;

-- 1. DEPARTMENT_T에서 부서번호(DEPT_NO)가 3인 부서의 지역(LOCATION)을 '인천'으로 수정하시오.
UPDATE DEPARTMENT_T
    SET LOCATION = '인천' -- SET절의 등호(=)는 대입연산자
WHERE DEPT_NO = 3; -- WHERE 절의 등호(=)는 동등 비교 연산자 EQUAL



-- 2. Emp

UPDATE EMPLOYEE_T
    SET SALARY = (SALARY*1.1)
WHERE DEPART = 2;



/*
    삭제
    
    DELETE FROM 테이블명 WHERE 조건식

*/
-- 1. DEPARTMENT_T에서 부서번호가(DEPT_NO) 3인 부서를 삭제하시오. (부서번호가 3인 사원은 없다.) 참조 무결성에 영향 X
SELECT * FROM DEPARTMENT_T;
DELETE 
  FROM DEPARTMENT_T 
WHERE DEPT_NO = 3;

-- 2.EMPLOYEE_T에서 부서번호(DEPART)가 1과 4인 사원을 삭제하시오.
SELECT * FROM EMPLOYEE_T;
DELETE 
FROM EMPLOYEE_T 
WHERE DEPART IN(1,4);
-- 3. DEPARTMENT_T에서 부서번호가(DEPT_NO) 2인 부서를 삭제하시오. (부서번호가 2인 사원이 있다. 부서가 없어지면 사원 정보가 참조 무결성 위배된다.
DELETE 
  FROM DEPARTMENT_T 
WHERE DEPT_NO = 2;

ROLLBACK;