/*
===========================================================
 03. SQLD 단계별 문제
 직접 먼저 작성한 후 아래 정답을 확인한다.
===========================================================
*/

-----------------------------------------------------------
-- LEVEL 1. SELECT / WHERE
-----------------------------------------------------------

-- 문제 1
-- 영화 제목과 가격만 조회하시오.


-- 문제 2
-- 가격이 15000원 이상인 영화를 조회하시오.


-- 문제 3
-- BASIC 등급 회원만 조회하시오.


-- 문제 4
-- 영화 가격을 내림차순으로 정렬하시오.


-----------------------------------------------------------
-- LEVEL 2. 함수 / GROUP BY
-----------------------------------------------------------

-- 문제 5
-- 영화 전체 평균 가격을 조회하시오.


-- 문제 6
-- 회원 등급별 회원 수를 조회하시오.


-- 문제 7
-- 장르별 평균 영화 가격을 조회하시오.


-----------------------------------------------------------
-- LEVEL 3. JOIN
-----------------------------------------------------------

-- 문제 8
-- 예매번호, 회원명, 영화명을 조회하시오.


-- 문제 9
-- 이영희가 예매한 영화명을 조회하시오.


-----------------------------------------------------------
-- LEVEL 4. 서브쿼리
-----------------------------------------------------------

-- 문제 10
-- 평균 영화 가격보다 비싼 영화를 조회하시오.


-- 문제 11
-- 예매 금액이 가장 큰 예매 건을 조회하시오.


-----------------------------------------------------------
-- LEVEL 5. SQLD 응용
-----------------------------------------------------------

-- 문제 12
-- 회원별 총 예매 금액을 조회하시오.


-- 문제 13
-- 총 예매금액이 30,000원 이상인 회원만 조회하시오.


-- 문제 14
-- 한 번도 예매하지 않은 영화를 조회하시오.


/*
===========================================================
 정답
===========================================================
*/

-- 정답 1
SELECT TITLE, TICKET_PRICE
FROM MOVIE;

-- 정답 2
SELECT *
FROM MOVIE
WHERE TICKET_PRICE >= 15000;

-- 정답 3
SELECT *
FROM MEMBER
WHERE GRADE = 'BASIC';

-- 정답 4
SELECT *
FROM MOVIE
ORDER BY TICKET_PRICE DESC;

-- 정답 5
SELECT AVG(TICKET_PRICE)
FROM MOVIE;

-- 정답 6
SELECT GRADE, COUNT(*)
FROM MEMBER
GROUP BY GRADE;

-- 정답 7
SELECT GENRE, AVG(TICKET_PRICE)
FROM MOVIE
GROUP BY GENRE;

-- 정답 8
SELECT
    B.BOOKING_ID,
    M.MEMBER_NAME,
    V.TITLE
FROM BOOKING B
JOIN MEMBER M
    ON B.MEMBER_ID = M.MEMBER_ID
JOIN MOVIE V
    ON B.MOVIE_ID = V.MOVIE_ID;

-- 정답 9
SELECT V.TITLE
FROM BOOKING B
JOIN MEMBER M
    ON B.MEMBER_ID = M.MEMBER_ID
JOIN MOVIE V
    ON B.MOVIE_ID = V.MOVIE_ID
WHERE M.MEMBER_NAME = '이영희';

-- 정답 10
SELECT *
FROM MOVIE
WHERE TICKET_PRICE >
      (SELECT AVG(TICKET_PRICE)
       FROM MOVIE);

-- 정답 11
SELECT *
FROM BOOKING
WHERE TOTAL_PRICE =
      (SELECT MAX(TOTAL_PRICE)
       FROM BOOKING);

-- 정답 12
SELECT
    M.MEMBER_NAME,
    SUM(B.TOTAL_PRICE) AS TOTAL_AMOUNT
FROM MEMBER M
JOIN BOOKING B
    ON M.MEMBER_ID = B.MEMBER_ID
GROUP BY M.MEMBER_NAME;

-- 정답 13
SELECT
    M.MEMBER_NAME,
    SUM(B.TOTAL_PRICE) AS TOTAL_AMOUNT
FROM MEMBER M
JOIN BOOKING B
    ON M.MEMBER_ID = B.MEMBER_ID
GROUP BY M.MEMBER_NAME
HAVING SUM(B.TOTAL_PRICE) >= 30000;

-- 정답 14
SELECT *
FROM MOVIE M
WHERE NOT EXISTS (
    SELECT 1
    FROM BOOKING B
    WHERE B.MOVIE_ID = M.MOVIE_ID
);
