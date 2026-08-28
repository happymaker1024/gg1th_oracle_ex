/*
===========================================================
 02. DML 실습
 Data Manipulation Language
 INSERT / UPDATE / DELETE / SELECT
===========================================================
*/

-----------------------------------------------------------
-- 1. 회원 데이터 입력
-----------------------------------------------------------

INSERT INTO MEMBER
(MEMBER_ID, MEMBER_NAME, EMAIL, GRADE, JOIN_DATE, PHONE)
VALUES
(1, '김철수', 'chulsoo@example.com', 'BASIC',
 TO_DATE('2026-08-01', 'YYYY-MM-DD'), '010-1111-1111');

INSERT INTO MEMBER
VALUES
(2, '이영희', 'younghee@example.com', 'VIP',
 TO_DATE('2026-07-15', 'YYYY-MM-DD'), '010-2222-2222');

INSERT INTO MEMBER
VALUES
(3, '박민수', 'minsoo@example.com', 'VVIP',
 TO_DATE('2026-06-20', 'YYYY-MM-DD'), '010-3333-3333');

INSERT INTO MEMBER
VALUES
(4, '최지우', 'jiwoo@example.com', 'BASIC',
 SYSDATE, '010-4444-4444');


-----------------------------------------------------------
-- 2. 영화 데이터 입력
-----------------------------------------------------------

INSERT INTO MOVIE VALUES
(101, '인터스텔라', 'SF', 169, 15000);

INSERT INTO MOVIE VALUES
(102, '기생충', '드라마', 132, 14000);

INSERT INTO MOVIE VALUES
(103, '극한직업', '코미디', 111, 13000);

INSERT INTO MOVIE VALUES
(104, '파묘', '미스터리', 134, 16000);

INSERT INTO MOVIE VALUES
(105, '서울의 봄', '드라마', 141, 15000);


-----------------------------------------------------------
-- 3. 예매 데이터 입력
-----------------------------------------------------------

INSERT INTO BOOKING
(BOOKING_ID, MEMBER_ID, MOVIE_ID,
 BOOKING_DATE, SEAT_NO, QUANTITY, TOTAL_PRICE)
VALUES
(1001, 1, 101,
 TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'A10', 2, 30000);

INSERT INTO BOOKING VALUES
(1002, 2, 102,
 TO_DATE('2026-08-21', 'YYYY-MM-DD'), 'B05', 1, 14000);

INSERT INTO BOOKING VALUES
(1003, 2, 104,
 TO_DATE('2026-08-22', 'YYYY-MM-DD'), 'C07', 2, 32000);

INSERT INTO BOOKING VALUES
(1004, 3, 101,
 TO_DATE('2026-08-22', 'YYYY-MM-DD'), 'D03', 1, 15000);

INSERT INTO BOOKING VALUES
(1005, 4, 103,
 TO_DATE('2026-08-23', 'YYYY-MM-DD'), 'E11', 3, 39000);

INSERT INTO BOOKING VALUES
(1006, 3, 105,
 TO_DATE('2026-08-24', 'YYYY-MM-DD'), 'F09', 2, 30000);

COMMIT;


-----------------------------------------------------------
-- 4. SELECT 기본
-----------------------------------------------------------

-- 전체 회원 조회
SELECT *
FROM MEMBER;

-- 원하는 컬럼만 조회
SELECT MEMBER_NAME, GRADE
FROM MEMBER;

-- 중복 제거
SELECT DISTINCT GRADE
FROM MEMBER;


-----------------------------------------------------------
-- 5. WHERE 조건
-----------------------------------------------------------

-- VIP 회원 조회
SELECT *
FROM MEMBER
WHERE GRADE = 'VIP';

-- 가격이 15000원 이상인 영화
SELECT *
FROM MOVIE
WHERE TICKET_PRICE >= 15000;

-- SF 또는 드라마 영화
SELECT *
FROM MOVIE
WHERE GENRE IN ('SF', '드라마');

-- 제목에 '봄'이 들어간 영화
SELECT *
FROM MOVIE
WHERE TITLE LIKE '%봄%';


-----------------------------------------------------------
-- 6. ORDER BY
-----------------------------------------------------------

SELECT *
FROM MOVIE
ORDER BY TICKET_PRICE DESC;


-----------------------------------------------------------
-- 7. UPDATE
-----------------------------------------------------------

-- 김철수 회원을 VIP로 변경
UPDATE MEMBER
SET GRADE = 'VIP'
WHERE MEMBER_ID = 1;

-- 반드시 WHERE 조건을 확인하는 습관이 중요하다.

COMMIT;


-----------------------------------------------------------
-- 8. DELETE
-----------------------------------------------------------

-- 예매번호 1006 삭제
DELETE FROM BOOKING
WHERE BOOKING_ID = 1006;

-- 확인
SELECT *
FROM BOOKING;

-- 삭제를 취소하고 싶으면 COMMIT 전에 ROLLBACK 가능
ROLLBACK;


-----------------------------------------------------------
-- 9. 집계함수
-----------------------------------------------------------

SELECT COUNT(*) AS MOVIE_COUNT
FROM MOVIE;

SELECT AVG(TICKET_PRICE) AS AVG_PRICE
FROM MOVIE;

SELECT
    MAX(TICKET_PRICE) AS MAX_PRICE,
    MIN(TICKET_PRICE) AS MIN_PRICE
FROM MOVIE;


-----------------------------------------------------------
-- 10. GROUP BY / HAVING
-----------------------------------------------------------

-- 장르별 영화 수
SELECT
    GENRE,
    COUNT(*) AS CNT
FROM MOVIE
GROUP BY GENRE;

-- 영화가 2개 이상인 장르
SELECT
    GENRE,
    COUNT(*) AS CNT
FROM MOVIE
GROUP BY GENRE
HAVING COUNT(*) >= 2;


-----------------------------------------------------------
-- 11. JOIN
-----------------------------------------------------------

SELECT
    B.BOOKING_ID,
    M.MEMBER_NAME,
    V.TITLE,
    B.SEAT_NO,
    B.TOTAL_PRICE
FROM BOOKING B
JOIN MEMBER M
    ON B.MEMBER_ID = M.MEMBER_ID
JOIN MOVIE V
    ON B.MOVIE_ID = V.MOVIE_ID
ORDER BY B.BOOKING_ID;


-----------------------------------------------------------
-- 12. 서브쿼리
-----------------------------------------------------------

-- 평균 가격보다 비싼 영화
SELECT *
FROM MOVIE
WHERE TICKET_PRICE >
      (SELECT AVG(TICKET_PRICE)
       FROM MOVIE);


-----------------------------------------------------------
-- 13. CASE 표현식
-----------------------------------------------------------

SELECT
    TITLE,
    TICKET_PRICE,
    CASE
        WHEN TICKET_PRICE >= 16000 THEN '고가'
        WHEN TICKET_PRICE >= 14000 THEN '보통'
        ELSE '저가'
    END AS PRICE_GRADE
FROM MOVIE;


-----------------------------------------------------------
-- SQLD 핵심
-----------------------------------------------------------

/*
INSERT : 행 추가
UPDATE : 행 수정
DELETE : 행 삭제
SELECT : 조회

WHERE    : 행 필터링
GROUP BY : 그룹 생성
HAVING   : 그룹 필터링
ORDER BY : 정렬

논리적 처리 순서를 이해하는 것이 중요하다.

FROM
 -> WHERE
 -> GROUP BY
 -> HAVING
 -> SELECT
 -> ORDER BY
*/
