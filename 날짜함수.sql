-- 날짜 함수

-- SYSDATE  
-- 년월일
SELECT
    sysdate
FROM dual;

-- SYSTIMESTAMP
-- 년월일 시분초 시간차
SELECT
    systimestamp
FROM dual;

-- 날짜연산
SELECT
    sysdate, sysdate + 3, sysdate - 3
FROM dual;

SELECT
    sysdate - HIRE_DATE
FROM EMPLOYEES;

-- 입사후 지금까지 지난 일수
SELECT
    (sysdate - HIRE_DATE)
FROM EMPLOYEES;
-- 주수
SELECT
    (sysdate - hire_date)/7
FROM EMPLOYEES;
-- 년수
SELECT
    (sysdate - hire_date)/365
FROM EMPLOYEES;

-- 날짜의 반올림, 절삭
SELECT
    trunc(sysdate - hire_date)
FROM EMPLOYEES;

-- 특정 포맷 형식으로 날짜 절삭
-- 년 기준으로 절삭 : 년/01/01
SELECT
    trunc(sysdate, 'year')
FROM dual;
-- 월 기준으로 절삭 : 년/월/01
SELECT
    trunc(sysdate, 'month')
FROM dual;
-- 일 기준으로 절삭 : 해당주의 일요일기준
SELECT
    trunc(sysdate, 'day')
FROM dual;
