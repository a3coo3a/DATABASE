-- ����Ŭ �ּ��Դϴ�
-- ������ ctrl + enter

select * from employees;

select employee_id, first_name, last_name from employees;

select email, phone_number, hire_date from employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�.

select salary from employees;

select first_name, last_name,salary, salary+ salary*0.1 FROM employees;

-- null�� Ȯ��
select * from employees;
select department_id, commission_pct from employees;

-- �����(�÷����� ��Ī�� �ٿ��� ��ȸ�մϴ�)
select first_name as �̸�, last_name as ��, salary as �޿�,salary+ salary*0.1 as �޿�110����
from employees;
select * from employees;
-- �������

-- ' ' ����, ��¥�� ��Ÿ���� ǥ��
-- '�� ���ڷ� ����ϰ� ������ '' ���� ���� '�� ǥ��Ǿ� ��Ÿ��
-- || : ���� ����
select first_name || ' ' || last_name || 's salary is $' || salary from employees;

select first_name || ' ' || last_name || '''s salary is $' || salary from employees;

select first_name || ' ' || last_name || '''s salary is $' || salary as "Employee Details" from employees;

-- distinct : �ѷ���, �и���
-- >> �ߺ��� ���� Ű���� ; �ɼ�
select department_id from employees;

select distinct department_id from employees;

-- ROWID : �����ͺ��̽����� ���� �ּҸ� ��ȯ
-- ROWNUM : ������ ���� ��ȯ�Ǵ� ���� ��ȣ�� ����մϴ�. !!�߿�, ��ȸ������ ������ ����
-- ���� : sql��
select rowid, rownum, employee_id from employees;

-- where ������
-- ��� ��� : where ã�����ϴ� ����


