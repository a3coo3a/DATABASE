-- 데이터 정렬
-- order by
-- 실행순서상 가장 늦게 실행됨 그래서 앨리어스(as) 구문을 적용해도됨. // as로 적은 별칭을 사용해도 된다는 말
-- select구문의 가장 마지막에 사용됨

select * from employees order by hire_date;     -- 날짜에 대한 오름차순 정렬
select * from employees order by hire_date asc; -- 위와 동일

select * from employees order by hire_date desc;  -- 날짜에 대한 내림차순 정렬

select * from employees where job_id = 'IT_PROG' order by first_name;  -- 문자도 사전 순서대로 정렬됨.
-- 1. 테이블에 가서 2. 잡아이디가 it_prog를 보여주고 3. 오름차순을 정렬

select * from employees where salary >= 5000 order by employee_id DESC; 

-- alias도 적용이 가능
select first_name, salary*12 as pay from employees order by pay asc; 



