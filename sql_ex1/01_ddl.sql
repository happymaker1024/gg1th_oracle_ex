/*
===========================================================
 01. DDL 실습
 Data Definition Language
 CREATE / ALTER / DROP / TRUNCATE
===========================================================
주제: 영화관 예매 시스템
===========================================================
*/

-----------------------------------------------------------
-- 1. 기존 객체 제거
-- 반복 실습을 위해 기존 테이블이 있으면 직접 DROP 한다.
-----------------------------------------------------------

-- 자식 테이블부터 삭제해야 FK 오류를 피할 수 있다.
-- DROP TABLE BOOKING CASCADE CONSTRAINTS;
-- DROP TABLE MOVIE CASCADE CONSTRAINTS;
-- DROP TABLE MEMBER CASCADE CONSTRAINTS;


-- ORCL은 연결 이름이고, 실제 접속 대상 PDB가 MOVIE_DB

-- joy 계정에서 movie_db 연결하기
ALTER SESSION SET CONTAINER = movie_db;

-- 연결된 db 확인하기
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS CON_NAME
FROM DUAL;

-- 현재 사용자 확인
SELECT USER
FROM DUAL;

-----------------------------------------------------------
-- 2. MEMBER 테이블 생성
-----------------------------------------------------------

CREATE TABLE MEMBER (
    MEMBER_ID      NUMBER          CONSTRAINT PK_MEMBER PRIMARY KEY,
    MEMBER_NAME    VARCHAR2(50)    NOT NULL,
    EMAIL          VARCHAR2(100)   CONSTRAINT UQ_MEMBER_EMAIL UNIQUE,
    GRADE          VARCHAR2(10)    DEFAULT 'BASIC',
    JOIN_DATE      DATE            DEFAULT SYSDATE,

    -- CHECK 제약조건
    CONSTRAINT CK_MEMBER_GRADE
        CHECK (GRADE IN ('BASIC', 'VIP', 'VVIP'))
);


-----------------------------------------------------------
-- 3. MOVIE 테이블 생성
-----------------------------------------------------------

CREATE TABLE MOVIE (
    MOVIE_ID       NUMBER          CONSTRAINT PK_MOVIE PRIMARY KEY,
    TITLE          VARCHAR2(100)   NOT NULL,
    GENRE          VARCHAR2(30),
    RUNNING_TIME   NUMBER,
    TICKET_PRICE   NUMBER(10, 0),

    CONSTRAINT CK_MOVIE_PRICE
        CHECK (TICKET_PRICE >= 0)
);


-----------------------------------------------------------
-- 4. BOOKING 테이블 생성
-----------------------------------------------------------

CREATE TABLE BOOKING (
    BOOKING_ID     NUMBER          CONSTRAINT PK_BOOKING PRIMARY KEY,
    MEMBER_ID      NUMBER          NOT NULL,
    MOVIE_ID       NUMBER          NOT NULL,
    BOOKING_DATE   DATE            DEFAULT SYSDATE,
    SEAT_NO        VARCHAR2(10)    NOT NULL,
    QUANTITY       NUMBER          DEFAULT 1,
    TOTAL_PRICE    NUMBER(10, 0),

    -- MEMBER와 관계 설정
    CONSTRAINT FK_BOOKING_MEMBER
        FOREIGN KEY (MEMBER_ID)
        REFERENCES MEMBER(MEMBER_ID),

    -- MOVIE와 관계 설정
    CONSTRAINT FK_BOOKING_MOVIE
        FOREIGN KEY (MOVIE_ID)
        REFERENCES MOVIE(MOVIE_ID),

    CONSTRAINT CK_BOOKING_QTY
        CHECK (QUANTITY > 0)
);


-----------------------------------------------------------
-- 5. 테이블 구조 확인
-----------------------------------------------------------

SELECT TABLE_NAME
FROM USER_TABLES
ORDER BY TABLE_NAME;


-----------------------------------------------------------
-- 6. ALTER TABLE 실습
-----------------------------------------------------------

-- MEMBER 테이블에 전화번호 컬럼 추가
ALTER TABLE MEMBER
ADD PHONE VARCHAR2(20);

-- MOVIE의 GENRE 크기 변경
ALTER TABLE MOVIE
MODIFY GENRE VARCHAR2(50);


-----------------------------------------------------------
-- 7. SQLD 핵심 정리
-----------------------------------------------------------

/*
CREATE
- 테이블, 뷰, 인덱스 등의 객체 생성

ALTER
- 기존 객체 구조 변경

DROP
- 객체 자체를 삭제
- 구조 + 데이터 삭제

TRUNCATE
- 테이블 데이터 전체 삭제
- 테이블 구조는 유지
- 일반적인 ROLLBACK 대상이 아님

DELETE
- DML
- 조건을 사용하여 데이터 삭제 가능
- COMMIT 이전에는 ROLLBACK 가능
*/
