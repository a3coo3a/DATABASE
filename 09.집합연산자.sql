-- 집합 연산자
-- 집합 연산자 사용시에는 컬럼 갯수를 맞춰 주어야 함.

SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%';

SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;
-- 위에서 세미콜론을 떼어내고 합칠 두 select 구문 사이에 [집합연산자]를 작성
-- union : 합집합, 중복x
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
union
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;

-- union all : 합집합, 중복o
-- 컬럼 갯수를 꼭 맞춰야함.
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
union all
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;


-- intersect : 교집합
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
intersect
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;

-- minus
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
minus
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;

-- union all을 사용한 더미데이터
-- 가짜테이블이라고 함.
-- 컬럼명은 첫번째 데이터로 만들어짐 
SELECT
    '홍길동' as name,'20200211' as year  
FROM dual union all
SELECT
    '이순신','20200321'    
FROM dual union all
SELECT
    '김유신','20190231'    
FROM dual union all
SELECT
    '이성계','20180301'    
FROM dual;