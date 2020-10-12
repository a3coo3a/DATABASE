-- 그룹 함수

-- avg, max, min, sum, count
SELECT
    avg(SALARY), sum(SALARY), min(SALARY), max(SALARY)
FROM EMPLOYEES;

-- count(*) : 전체 행 데이터의 갯수
SELECT
    count(*)
FROM EMPLOYEES;
-- count(컬럼명) : 컬럼내 null값을 제외한 데이터 갯수
SELECT
    count(first_name)
FROM EMPLOYEES;     -- 107
SELECT
    count(COMMISSION_PCT)
FROM EMPLOYEES;     -- 35

-- 에러! 
-- 그룹 함수는 일반 컬럼과 동시에 사용 할 수 없음.
SELECT
    DEPARTMENT_ID, sum(SALARY)
FROM EMPLOYEES;


-- group by : 그룹핑
-- where절 다음에 사용됨
SELECT
    DEPARTMENT_ID
FROM EMPLOYEES group by department_id ORDER BY DEPARTMENT_ID;

SELECT
    DEPARTMENT_ID, sum(SALARY), avg(SALARY), count(*)
FROM EMPLOYEES group by department_id order by DEPARTMENT_ID;

-- 에러
-- 그룹절에 묶인 컬럼만 조회가 가능
SELECT
    department_id, job_id
FROM EMPLOYEES group by department_id;

-- 2개 이상의 그룹화
SELECT
    DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES group by department_id, job_id order by DEPARTMENT_ID;

-- having
-- group by절의 조건절
-- 그룹핑된 결과의 조건을 주고 싶은데 where절이 먼저 실행 된 후 group by절이 실행되어 원하는 결과가 나오지 않음.
SELECT
    department_id, sum(salary)
FROM EMPLOYEES where salary >= 5000 group by department_id;
SELECT
    department_id, sum(salary)
FROM EMPLOYEES group by department_id;

SELECT
    department_id, sum(salary)
FROM EMPLOYEES group by department_id having sum(salary) >= 100000;

-- 20명 이상인 job_id
SELECT
    job_id, count(*)
FROM EMPLOYEES group by job_id having count(*) >= 20;

