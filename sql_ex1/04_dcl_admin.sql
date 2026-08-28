/*
===========================================================
 04. DCL 실습
 Data Control Language
 GRANT / REVOKE

주의:
이 파일은 JOY가 아니라 SYSTEM 또는 SYS 등
관리자 권한을 가진 계정에서 실행한다.
현재 PDB는 FREEPDB1이어야 한다.
===========================================================
*/

-----------------------------------------------------------
-- 1. 현재 컨테이너 확인
-----------------------------------------------------------

SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS CON_NAME
FROM DUAL;


-----------------------------------------------------------
-- 2. JOY 계정 존재 여부 확인
-----------------------------------------------------------

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS
WHERE USERNAME = 'JOY';


-----------------------------------------------------------
-- 3. 시스템 권한 부여
-----------------------------------------------------------

GRANT CREATE SESSION TO joy;
GRANT CREATE TABLE TO joy;
GRANT CREATE VIEW TO joy;
GRANT CREATE SEQUENCE TO joy;
GRANT CREATE PROCEDURE TO joy;
GRANT CREATE TRIGGER TO joy;


-----------------------------------------------------------
-- 4. 권한 확인
-----------------------------------------------------------

SELECT GRANTEE, PRIVILEGE
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'JOY'
ORDER BY PRIVILEGE;


-----------------------------------------------------------
-- 5. REVOKE 실습
-----------------------------------------------------------

-- 예: VIEW 생성 권한 회수
REVOKE CREATE VIEW FROM joy;

-- 다시 부여
GRANT CREATE VIEW TO joy;


/*
===========================================================
 DCL 핵심
===========================================================

GRANT
- 사용자 또는 역할에 권한 부여

REVOKE
- 부여한 권한 회수

권한 종류
1. 시스템 권한
   CREATE SESSION
   CREATE TABLE
   CREATE VIEW 등

2. 객체 권한
   SELECT
   INSERT
   UPDATE
   DELETE 등

예:
GRANT SELECT ON MEMBER TO 다른사용자;

SQLD에서는
'누가 무엇에 대해 어떤 권한을 갖는가'
구분하는 것이 중요하다.
*/
