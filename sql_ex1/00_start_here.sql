/*
===========================================================
 SQLD Oracle 실습 프로젝트
 주제: 영화관 예매 시스템(Movie Booking)
 DBMS: Oracle Database Free / FREEPDB1
 사용자: JOY
===========================================================

[중요]
Oracle에서는 MySQL처럼 일반 사용자가 CREATE DATABASE로
새 데이터베이스를 만드는 방식으로 학습하지 않는다.

현재 구성은 다음과 같이 이해하면 된다.

  Oracle Database : FREE
  PDB             : FREEPDB1
  Schema(User)    : JOY

JOY 계정으로 FREEPDB1에 접속한 뒤,
JOY 스키마 안에 테이블을 생성하여 실습한다.

실행 순서
1. 01_ddl.sql
2. 02_dml.sql
3. 03_dml_practice.sql
4. 04_dcl_admin.sql   <-- 관리자(SYSTEM/SYS) 계정에서 실행
===========================================================
*/

-- 현재 접속 사용자 확인
SELECT USER FROM DUAL;

-- 현재 PDB 확인
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS CON_NAME
FROM DUAL;

-- JOY 계정에서 실행한다면 USER 결과는 JOY,
-- CON_NAME 결과는 FREEPDB1이어야 한다.
