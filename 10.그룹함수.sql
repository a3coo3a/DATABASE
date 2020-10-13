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

-- 부서 아이디가 50이상인 컬럼을 그룹화 시키고 그룹 평균중 급여 5000이상만 조회
SELECT
    *
FROM EMPLOYEES;
select 
    department_id, trunc(avg(SALARY)) 
from employees 
    where department_id >= 50 
    group by department_id having trunc(avg(SALARY)) >= 5000 
    ORDER BY DEPARTMENT_ID;


-- ------------------연습문제-------------------------
-- 문제 1.
-- 사원 테이블에서 JOB_ID별 사원 수를 구하세요.
SELECT
    JOB_ID, count(*)
FROM EMPLOYEES
GROUP BY JOB_ID;
-- 사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요 
SELECT
    JOB_ID, trunc(avg(salary)), count(*)
FROM EMPLOYEES
GROUP BY JOB_ID order by trunc(avg(salary)) desc;

-- 문제 2.
-- 사원 테이블에서 입사 년도 별 사원 수를 구하세요.
SELECT
    to_char(HIRE_DATE, 'YYYY') as 입사년도, count(*) as 사원수
FROM EMPLOYEES group by to_char(HIRE_DATE, 'YYYY') order by to_char(HIRE_DATE, 'YYYY');

-- 문제 3.
-- 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
-- 단 부서 평균 급여가 2000이상인 부서만 출력
SELECT
    DEPARTMENT_ID, trunc(avg(SALARY))
FROM EMPLOYEES 
where SALARY >= 1000
GROUP BY DEPARTMENT_ID having avg(SALARY) >= 2000;

-- 문제 4.
-- 사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
-- department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
-- 조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
-- 조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
SELECT
    DEPARTMENT_ID, 
    trunc(avg(salary+SALARY*COMMISSION_PCT),2) as 평균급여, 
    sum(SALARY) as 급여합계, 
    count(*)
FROM EMPLOYEES
where COMMISSION_PCT is not null
group by DEPARTMENT_ID;