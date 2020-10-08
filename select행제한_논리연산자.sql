-- ������ : where, between, in, like

-- where ������
-- ��� ��� : where ã�����ϴ� ����
select * from employees;

select first_name, last_name from employees where job_id = 'IT_PROG';

select first_name, last_name, job_id from employees where job_id = 'IT_PROG';

select * from employees where last_name = 'King'; --����

select * from employees where department_id = 90;

select * from employees where salary >= 15000; -- 15000�� �̻��� ���

select * from employees where salary <> 15000; -- 15000���� �ƴ� ���

select * from employees where hire_date = '06/03/07'; -- ��¥�� ������������ ��ȸ

-- between ������
select * from employees where salary BETWEEN 10000 AND 12000;

select * from employees where salary >= 10000 and salary <= 12000; --���� ����

select * from employees where hire_date BETWEEN '03/01/01' and '03/12/31';

-- in ������
-- : ����� Ư������ ���� �� ���
select * from employees where manager_id in(100,101,102);   -- 100,101,102���� �ִ� �ڷ� ��ȸ

select * from employees where job_id in('AD_VP','FI_MGR','SA_MAN');


-- like ������
-- % : ���
-- _ : �������� ��ġ�� ã�Ƴ���
select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '03%'; -- 03���� ����

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '%15'; -- 15�� ������

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '%05%'; -- 05�� ���ԵǾ� �ִ�

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '___05___'; -- 05�� 

select first_name || ' ' || last_name, hire_date from employees 
where hire_date like '___05%'; -- 05�� 

select email from employees where email like '_A%';

-- is null, is not null (null�� ��ȸ)
select * from employees where manager_id = null;  -- �ȳ���

select * from employees where manager_id is null;  -- �̷��� �ؾ� ����.

select * from employees where commission_pct is not null;

-- �������� : and, or, not
-- �����ڸ� ���ÿ� ���� not > and > or �� �켱������ ����.

select * from employees where department_id = 100 and salary >= 500;

select * from employees where job_id = 'IT_PROG' or job_id = 'FI_MGR' and salary >= 6000;

select * from employees where (job_id = 'IT_PROG' or job_id = 'FI_MGR') and salary >= 6000;


