/*
        외래키(foreign key)
        1. 다른 테이블을 참조할 때 사용하는 키(key)다.
        2. 외래키는  중복 값을 가질 수 있고 NULL 값을 가질 수 있다.
        3. 참조 무결성을 가져야 한다.
            1) 참조하는 테이블에 존재하는 데이터만 가져올 수 있다.
            2) 참조 무결성이 위배되는 경우를 대비해 추가 옵션을 사용할 수 있다.
                    (1)  ON DELETE SET NULL  : 부모 키가 삭제되는 경우 자식 키만 삭제한다.
                    (2) ON DELETE CASCADE  : 부모 키가 삭제되는 경우 자식 키를 가진 행(Row) 전체를 삭제한다.
        4. 형식
            부모 테이블 - 자식 테이블
            부모 키         - 자식 키
            기본 키/ UNIQUE - 외래 키
*/


/*
  일대다 관계 (1:M)
  1. 2개의 테이블을 관계 짓는 가장 흔한 관계
  2. PK : FK
      UQ
      부모 : 자식
3. 반드시 부모 테이블을 먼저 만들어야 한다.
4. 반드시 자식 테이블을 먼저 삭제해야한다.ㅣ
5. 테이블 생성/삭제 규칙
        생성과 삭제 순서는 반대이다.
  일대일
  
  다대다 관계 (N:M)
  
*/

CREATE TABLE PRODUCT_T (
    PRODUCT_NO NUMBER NOT NULL PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(255)  NOT NULL,
    PRICE NUMBER NOT NULL,
    STOCK NUMBER NULL
);

CREATE TABLE ORDER_T(
    ORDER_NO NUMBER NOT NULL PRIMARY KEY,
    MEMBER_ID VARCHAR2(255) NOT NULL,
    PRODUCT_NO NUMBER REFERENCES PRODUCT_T(PRODUCT_NO),
    ORDER_AT DATE NOT NULL
);

INSERT INTO PRODUCT_T VALUES(1, '새우깡', 1000, 15);
INSERT INTO PRODUCT_T VALUES(2 , '감자깡',1000,10);
INSERT INTO PRODUCT_T VALUES(3 , '양파링',2000,20);
INSERT INTO PRODUCT_T VALUES(4, '맛동산', 3000, 15);
INSERT INTO PRODUCT_T VALUES(5, '먹태깡', 5000, null);

