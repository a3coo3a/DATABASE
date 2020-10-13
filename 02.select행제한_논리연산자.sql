-- 행제한 : where, between, in, like

-- where 조건절
-- 사용 방법 : where 찾고자하는 조건
select * from employees;

select first_name, last_name from employees where job_id = 'IT_PROG';

select first_name, last_name, job_id from employees where job_id = 'IT_PROG';

select * from employees where last_name = 'King'; --같은

select * from employees where department_id = 90;

select * from employees where salary >= 15000; -- 15000원 이상인 사람

select * from employees where salary <> 15000; -- 15000원이 아닌 사람

select * from employees where hire_date = '06/03/07'; -- 날짜도 문자형식으로 조회

-- between 연산자
select * from employees where salary BETWEEN 10000 AND 12000;

select * from employees where salary >= 10000 and salary <= 12000; --위와 동일

select * from employees where hire_date BETWEEN '03/01/01' and '03/12/31';

-- in 연산자
-- : 목록의 특정값을 비교할 때 사용
select * from employees where manager_id in(100,101,102);   -- 100,101,102값이 있는 자료 조회

select * from employees where job_id in('AD_VP','FI_MGR','SA_MAN');


-- like 연산자
-- % : 모든
-- _ : 데이터의 위치를 찾아낼때
select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '03%'; -- 03으로 시작

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '%15'; -- 15로 끝나는

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '%05%'; -- 05가 포함되어 있는

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '___05___'; -- 05월 

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '___05%'; -- 05월 

select email from employees where email like '_A%';

-- is null, is not null (null값 조회)
select * from employees where manager_id = null;  -- 안나옴

select * from employees where manager_id is null;  -- 이렇게 해야 나옴.

select * from employees where commission_pct is not null;

-- 논리연산자 : and, or, not
-- 연산자를 동시에 사용시 not > and > or 의 우선순위로 계산됨.

select * from employees where department_id = 100 and salary >= 500;

select * from employees where job_id = 'IT_PROG' or job_id = 'FI_MGR' and salary >= 6000;

select * from employees where (job_id = 'IT_PROG' or job_id = 'FI_MGR') and salary >= 6000;


