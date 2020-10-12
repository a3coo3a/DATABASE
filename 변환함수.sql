-- 변환함수 (아주중요)

-- to_char()
-- 날짜 -> 문자 : to_char(날짜, 형식)
-- 날짜 포맷 형식은 대문자로 표기
SELECT
    TO_CHAR(sysdate, 'YYYY-MM-DD')
FROM dual;              -- 2020-10-12 표기

-- 연월일 시분초 : 분은 MI
SELECT
    to_char(sysdate,'YYYY-MM-DD HH:MI:SS')
FROM dual;              -- 2020-10-12 01:37:47 표기

SELECT
    to_char(sysdate, 'YY-MM-DD HH24:MI')
FROM dual;              -- 20-10-12 13:37 표기

-- 지정된 날짜 포맷 형식이 아닌 직접 지정해서 포맷을 할 경우
-- "" 로 묶어 사용
SELECT
    to_char(sysdate, 'YYYY"년" MM"월" DD"일"')
FROM dual;              -- 2020년 10월 12일 표기

SELECT 
    first_name, hire_date, to_char(hire_date, 'YYYY-MM-DD')
FROM EMPLOYEES;

-- 숫자 -> 문자 : to_char(숫자, 형식)
-- 9 : 자리수의 표현
SELECT
    to_char(20000, '99999') as 다섯자리,
    to_char(20000, '999999999') as 아홉자리
FROM dual;

-- 자리수가 부족한 경우 (요청한 자리수+1만큼)#으로 표기
SELECT
    to_char(20000,'99')
FROM dual;

-- 소수점은 잘려나가고 5자리가 표기되는 모습 ; 20000
SELECT
    to_char(20000.21,'99999')
FROM dual;
-- 온전히 표현됨.
SELECT
    to_char(20000.21,'99999.99')
FROM dual;

-- salary가 우측으로 표기되는걸로 보아 숫자인걸 확인
SELECT
    salary, to_char(SALARY,'$99,999')
FROM EMPLOYEES order by SALARY DESC;

-- 문자 -> 숫자 : to_number(문자, 형식)
-- 보통 숫자만 있는 경우는 자동형변환(verchar2로)이 일어남
-- 자동형변환이 일어나지 못하는 특별한 포맷($ or ,)을 가진 숫자의 경우 사용
SELECT
    '2000' + 2000
FROM dual;          -- 자동형변환

SELECT
    to_number('2000') + 2000
FROM dual;          -- 명시적형변환 : 직접 형변환하는 경우

SELECT
    '$2000' + 2000 
FROM dual;          -- error : 문자형이 $ , 같은 특정 문자를 지니고 있을때는 자동형변환이 불가
-- 만약 '2000원' 으로 써있으면 지원된 숫자형 포맷이 아닌 경우
-- 스트링으로 잘라서 날릴 생각해야해

-- 숫자형 포맷형식이 지원하는 형식을 가진 경우, 명시적형변환이 가능.
SELECT
    to_number('$2000','$9999') + 2000
FROM dual;

-- 문자 -> 숫자 : ★to_date(문자, 형식)
-- 이런경우는 바로 변경 가능
SELECT
    to_date('2020-03-31'), to_date('2020-03-31')+3
FROM dual;          -- 날짜로 변경 되는건 연산이 가능 하다는 것

-- 원하는 형식으로 뽑아내
SELECT
    to_date('2020/12/12', 'YY/MM/DD')
FROM dual;

SELECT
    to_date('2020-03-21 12:23:03','YYYY-MM-DD HH:MI:SS')
FROM dual;              
-- 시분초 형태까지 있는데 연월일만 포맷을 지정하면 불필요한 것이 있다며 변환 되지 않음.
-- 그래서 시분초도 함께 지정해 주어야함.

-- null값 변환 함수 : null값 제거
-- ★NVL() : 값, null일 경우
SELECT
    *
FROM dual;
SELECT
    nvl(null, 0)
FROM dual;

SELECT
   first_name, SALARY, COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT
FROM EMPLOYEES;         -- null값은 계산이 안되므로 null로 표기되는 모습
SELECT
   first_name, SALARY, COMMISSION_PCT, 
   SALARY + SALARY * nvl(COMMISSION_PCT,0)
FROM EMPLOYEES;         -- 정상적인 계산결과를 확인 할 수 있음.


-- ★NVL2() : 값, null이 아닐경우, null일 경우
SELECT
    nvl2(null, 'null아님', 'null임')
FROM dual;

SELECT
    first_name, NVL2(commission_pct, 'true', 'false')
FROM EMPLOYEES;

SELECT
    first_name, SALARY, COMMISSION_PCT, 
    NVL2(commission_pct, salary + (salary * commission_pct), salary) as 최종급여
FROM EMPLOYEES;

-- decode(데이터, 비교값, 결과, 비교값, 결과, 비교값, 결과...., 그외 결과)
SELECT
    decode('A','A','A입니다')
FROM dual;

SELECT
    decode('ㅇ','A','A입니다',
               'B','B입니다',
               'C','C입니다',
               'A,B,C가 아닙니다')
FROM dual;

SELECT job_id, salary,
    decode(job_id, 'IT_PROG', salary * 100,
                   'AD_VP', salary * 200,
                   'FI_MGR', salary * 300,
                   salary) as 최종급여
FROM EMPLOYEES;

-- case when then end
SELECT job_id, salary,
    CASE job_id WHEN 'IT_PFOG' THEN salary * 100
                WHEN 'AD_VP' THEN salary * 200
                WHEN 'FI_MGR' THEN salary * 300
                ELSE salary 
    END as 최종급여
FROM EMPLOYEES;

-- --------------------연습문제-----------------------------
--문제 1.
SELECT
    *
FROM EMPLOYEES;
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요.
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
SELECT
    EMPLOYEE_ID as 사원번호,
    concat(first_name,last_name) as 사원명,
    hire_date as 입사일자,
    trunc((sysdate - hire_date)/365) as 근속년수
FROM EMPLOYEES where trunc((sysdate - hire_date)/365) >= 10 ORDER BY 근속년수 DESC; 

--문제 2.
SELECT
    *
FROM EMPLOYEES;
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘사원’,
--120이라면 ‘주임’
--121이라면 ‘대리’
--122라면 ‘과장’
--나머지는 ‘임원’ 으로 출력합니다.
--조건 1) manager_id가 50인 사람들을 대상으로만 조회합니다
SELECT first_name, manager_id,
    decode(MANAGER_ID, 100, '사원',
                       120, '주임',
                       121, '대리',
                       122, '과장',
                       '임원') as 직급,
        DEPARTMENT_ID                    
FROM EMPLOYEES where department_id = 50 ; 

-- 문제3.
-- 1월 부터 12월까지 각 월의 마지막 날짜를 출력하세요
SELECT
    to_char(LAST_DAY(TO_DATE('01','MM')),'dd') as "1월", 
    to_char(last_day(to_date('02','MM')),'dd') as "2월",
    to_char(last_day(to_date('03','MM')),'dd') as "3월",
    to_char(last_day(to_date('04','MM')),'dd') as "4월",
    to_char(last_day(to_date('05','MM')),'dd') as "5월",
    to_char(last_day(to_date('06','MM')),'dd') as "6월",
    to_char(last_day(to_date('07','MM')),'dd') as "7월",
    to_char(last_day(to_date('08','MM')),'dd') as "8월",
    to_char(last_day(to_date('09','MM')),'dd') as "9월",
    to_char(last_day(to_date('10','MM')),'dd') as "10월",
    to_char(last_day(to_date('11','MM')),'dd') as "11월",
    to_char(last_day(to_date('12','MM')),'dd') as "12월"
FROM dual;

