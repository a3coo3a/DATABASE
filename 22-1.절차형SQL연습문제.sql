-- ������ sql��������

-- 1. �ܼ� ��¹����� 3 x 1 = 3 ���ڿ��� ����ϼ���
SET SERVEROUTPUT ON;
DECLARE
    n1 NUMBER := 3*1;
BEGIN
    dbms_output.put_line('3 x 1 = '||n1);
END;


-- 2. ��� ���̺��� 201���� ����� �̸��� �̸��� �ּҸ� ����ϴ� �͸���(declare~begin~end)�� �����Ͻø� �˴ϴ�.
SELECT * FROM employees;

DECLARE
    emp_name employees.first_name%TYPE;
    emp_email employees.email%TYPE;
BEGIN
    SELECT first_name, email
    INTO emp_name, emp_email
    FROM employees
    WHERE employee_id = 201;
    
    dbms_output.put_line('�̸� : '||emp_name||', �̸��� : '||emp_email);
END;

-- 3. ������̺��� �����ȣ�� ���� ū ����� ã�� �Ŀ� �� ��ȣ +1������ �Ʒ� ����� emps���̺� �߰��ϼ���
-- �̸� - steven, �̸���-stevenjobs, �Ի��� - sysdate, job_id - CEO
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

   