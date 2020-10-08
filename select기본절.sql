-- 오라클 주석입니다
-- 실행은 ctrl + enter

select * from employees;

select employee_id, first_name, last_name from employees;

select email, phone_number, hire_date from employees;

-- 컬럼을 조회하는 위치에서 * / + - 연산이 가능합니다.

select salary from employees;

select first_name, last_name,salary, salary+ salary*0.1 FROM employees;

-- null값 확인
select * from employees;
select department_id, commission_pct from employees;

-- 엘리어스(컬럼명의 별칭을 붙여서 조회합니다)
select first_name as 이름, last_name as 성, salary as 급여,salary+ salary*0.1 as 급여110프로
from employees;
select * from employees;
-- 여기까지

-- ' ' 문자, 날짜를 나타내는 표기
-- '를 문자로 사용하고 싶으면 '' 으로 쓰면 '로 표기되어 나타남
-- || : 값을 연결
select first_name || ' ' || last_name || 's salary is $' || salary from employees;

select first_name || ' ' || last_name || '''s salary is $' || salary from employees;

select first_name || ' ' || last_name || '''s salary is $' || salary as "Employee Details" from employees;

-- distinct : 뚜렷한, 분명한
-- >> 중복행 제거 키워드 ; 옵션
select department_id from employees;

select distinct department_id from employees;

-- ROWID : 데이터베이스에서 행의 주소를 반환
-- ROWNUM : 쿼리에 의해 반환되는 행의 번호를 출력합니다. !!중요, 조회했을때 나오는 순서
-- 쿼리 : sql문
select rowid, rownum, employee_id from employees;

-- where 조건절
-- 사용 방법 : where 찾고자하는 조건


