-- 숫자함수

-- round() : 소수점 n자리로 반올림
-- round(숫자 값, 반올림 원하는 자리수)
-- 옵션값을 주지 않으면 정수형으로 표현 : 34
SELECT
    ROUND(34.145)
FROM dual;
-- 2자리 까지로 반올림 : 34.15
SELECT
    ROUND(34.145, 2)
FROM dual;
-- -입력시 소수점 앞으로 이동되어 반올림, : 30
-- -1 : 일의자리, -2 : 십의자리
SELECT
    ROUND(34.145, -1)
FROM dual;

-- trunc() : 소수점 n자리로 절삭
-- trunc(숫자 값, 절삭을 원하는 자리수
-- 옵션값을 주지 않으면 정수형 표현 : 34
SELECT
    trunc(34.145)
FROM dual;
-- 2자리 까지 절삭 : 34.14
SELECT
    trunc(34.145,2)
FROM dual;
-- -입력시 소수점 앞으로 이동되어 절삭 : 30
-- -1 : 일의자리, -2 : 십의자리
SELECT
    trunc(34.145,-1)
FROM dual;