-- 문자 함수 

-- 가상테이블
SELECT
    *
FROM dual;  -- 함수 확인용으로 주로 사용됨
SELECT
    '안녕', 'ㅇㅇ'
FROM dual;

-- lower : 소문자로
-- upper : 대문자로
-- initcap : 첫글자만 대문자로
SELECT
    'abcDEF', LOWER('abcDEF'), UPPER('abcDEF'), INITCAP('abcDEF')
FROM dual;

SELECT
    *
FROM EMPLOYEES;

SELECT
    LAST_NAME, LOWER(LAST_NAME), UPPER(LAST_NAME), INITCAP(LAST_NAME)
FROM EMPLOYEES;

-- where 절에서도 사용가능
-- 자료를 소문자로 변환하여 소문자인 bull과 같은글자를 찾아 자료를 보여줌
-- 보여줄때는 자료가 가지고 있는 값으로 보여줌
SELECT
    LAST_NAME
FROM EMPLOYEES WHERE LOWER(LAST_NAME) = 'bull';

-- length() : 길이
-- instr() : 문자검색
SELECT FIRST_NAME, 
    length(FIRST_NAME) AS 길이, 
    instr(FIRST_NAME,'a') AS 포함위치   -- 없으면 0으로 나타냄
FROM EMPLOYEES;

SELECT
    length('abc'), instr('abcdefg', 'a')
FROM dual;

-- substr() : 문자열 자르기
-- concat() : 문자열 붙이기
SELECT
    SUBSTR('abcdef',1,3), CONCAT('abc','def')       -- 1 이상 3 이하로 자름
FROM dual;

SELECT first_name,
    substr(first_name, 1, 3), concat(first_name,last_name)
FROM EMPLOYEES;

-- concat은 2개의 문자열에만 사용할 수 있으므로, 
-- 3개의 문자열을 다루고 싶다면 중첩문으로 가능
SELECT
    first_name,
    concat(concat(first_name,' '),last_name)
FROM EMPLOYEES; 

-- lpad() : 좌측 지정 문자열 채우기
-- rpad() : 우측 지정 문자열 채우기
-- 10칸을 확보하고 그중 왼쪽 빈공간에 *를 채움
SELECT
    lpad('abc', 10,'*')
FROM dual;
-- 10칸을 확보하고 그중 오른쪽 빈공간에 *를 채움
SELECT
    rpad('abc',10,'*')
FROM dual;

SELECT
    lpad(first_name, 10, '-'), rpad(first_name, 10,'-')
FROM EMPLOYEES;

-- ltrim() : 왼쪽 공백제거, 문자제거
-- rtrim() : 오른쪽 공백제거, 문자제거
SELECT
    ltrim('javascript_java','java')
FROM dual;

SELECT
    rtrim('javascript_java','java')
FROM dual;
-- trim() : 양측의 공백을 제거
SELECT
    trim('    java    ')
FROM dual;

-- replace() : 특정 문자열을 바꾸는 함수, 문자열 치환
-- replace( 문자열, A, B) : A를 B로 바꾼다
-- president 를 programmer로 바꾸어 보여줌
SELECT
    REPLACE('my dream is president','president','programmer')
FROM dual; 

-- 공백제거
SELECT
    REPLACE('my dream is president',' ','')
FROM dual;

-- 글자도 바꾸고 공백도 바꾸고 싶다면 중첩으로 사용
SELECT
   REPLACE(REPLACE('my dream is president','president','programmer'),' ','')
FROM dual;
-- 2번 이상, 다른 종류의 함수로도 가능
-- 가장 안쪽의 함수부터 해석해서 나오면 됨.
SELECT
   LTRIM(REPLACE(REPLACE('my dream is president','president','programmer'),' ',''),'my')
FROM dual;

-- -------------------------------연습문제---------------------------------------
--문제 1. EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다.
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다.
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT
    rpad(substr(first_name,1,3),length(first_name),'*') as name, lpad(salary,10,'*') as salary
FROM EMPLOYEES where lower(job_id) = 'it_prog';
-- ***이름 로 착각해서 작성
SELECT
    lpad(substr(first_name,4,length(first_name)),length(first_name),'*') as name, lpad(salary,10,'*') as salary
FROM EMPLOYEES where lower(job_id) = 'it_prog';

--문제 1.
SELECT * FROM EMPLOYEES;
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT
    concat(first_name, last_name) as 이름,
    replace(hire_date, '/', '') as 입사일자
FROM EMPLOYEES order by 이름 asc;

--문제 2.
SELECT * FROM EMPLOYEES;
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT
    lpad(substr(phone_number,4,length(phone_number)),LENGTH(PHONE_NUMBER)-1,'02')
FROM EMPLOYEES;
SELECT
    REPLACE(phone_number,substr(phone_number,1,3),'02') 
FROM EMPLOYEES;

--문제 3.
SELECT * FROM EMPLOYEES;
--EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다.
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다.
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT
    lpad(substr(first_name,4,length(first_name)),length(first_name),'*') as 이름,
    lpad(salary,10,'*') as 급여
FROM EMPLOYEES where lower(job_id) = 'it_prog';

