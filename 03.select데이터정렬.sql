-- ������ ����
-- order by
-- ��������� ���� �ʰ� ����� �׷��� �ٸ��(as) ������ �����ص���. // as�� ���� ��Ī�� ����ص� �ȴٴ� ��
-- select������ ���� �������� ����

select * from employees order by hire_date;     -- ��¥�� ���� �������� ����
select * from employees order by hire_date asc; -- ���� ����

select * from employees order by hire_date desc;  -- ��¥�� ���� �������� ����

select * from employees where job_id = 'IT_PROG' order by first_name;  -- ���ڵ� ���� ������� ���ĵ�.
-- 1. ���̺� ���� 2. ����̵� it_prog�� �����ְ� 3. ���������� ����

select * from employees where salary >= 5000 order by employee_id DESC; 

-- alias�� ������ ����
select first_name, salary*12 as pay from employees order by pay asc; 



