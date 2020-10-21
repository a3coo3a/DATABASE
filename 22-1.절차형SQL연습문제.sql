-- 절차형 sql연습문제

-- 1. 단순 출력문으로 3 x 1 = 3 문자열을 출력하세요
SET SERVEROUTPUT ON;
DECLARE
    n1 NUMBER := 3*1;
BEGIN
    dbms_output.put_line('3 x 1 = '||n1);
END;


-- 2. 사원 테이블에서 201번의 사원의 이름과 이메일 주소를 출력하는 익명블록(declare~begin~end)을 생성하시면 됩니다.
SELECT * FROM employees;

DECLARE
    emp_name employees.first_name%TYPE;
    emp_email employees.email%TYPE;
BEGIN
    SELECT first_name, email
    INTO emp_name, emp_email
    FROM employees
    WHERE employee_id = 201;
    
    dbms_output.put_line('이름 : '||emp_name||', 이메일 : '||emp_email);
END;

-- 3. 사원테이블에서 사원번호가 가장 큰 사원을 찾은 후에 이 번호 +1번으로 아래 사원을 emps테이블에 추가하세요
-- 이름 - steven, 이메일-stevenjobs, 입사일 - sysdate, job_id - CEO
CREATE TABLE emps AS (SELECT * FROM employees WHERE 1=2);
SELECT * FROM EMPS;

DECLARE
    emp_employee_id employees.employee_id%TYPE;
    emp_name employees.first_name%TYPE := 'steven';
    emp_email employees.email%TYPE := 'stevenjobs';
    emp_date employees.hire_date%TYPE := sysdate;
    emp_job_id employees.job_id%TYPE := 'CEO';
BEGIN
    SELECT MAX(employee_id)+1
    INTO emp_employee_id
    FROM employees;
    
    INSERT INTO emps(employee_id, first_name, last_name, email, hire_date, job_id)
    VALUES (emp_employee_id, emp_name, emp_name, emp_email, emp_date, emp_job_id);
END;

   