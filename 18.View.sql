-- view (��)
-- ������ ������ Ȯ���ϱ� ���� ����ϴ� ���̺�
select * from EMP_DETAILS_VIEW where FIRST_NAME = 'Steven';

/*
view�� �������� �ڷḸ �������ؼ� ����� �� �ִ� ���� ���̺��� ����
view�� �������̺��̱� ������ �ʿ��� �÷��� ������ �θ� ������ ��ȸ�� ����
��� ������ �����Ͱ� ���������� ����� ���°� �ƴ� �������̺��� �����ϴ� ������� ���
�信�� DML�۾��� �ϰ� �Ǹ� ���� ���̺� ����˴ϴ�,(�ٸ�, ��������� ���� ����)
*/

select * from user_role_privs;
-- ���� ����� ���� Ȯ��
select * from user_sys_privs;


-- view ����
-- �ܼ���
-- �ϳ��� ���̺��� ������� �� ��
create view view_emp
as(select employee_id,
          first_name,
          last_name,
          job_id,
          salary from employees
    );
    
select * from view_emp;


-- ���պ�
-- �������̺��� �����Ͽ� �ʿ��� �����͸� ������ 
CREATE view view_emp_dept_job
as (select employee_id,
           first_name || ' ' || last_name as name,
           department_name,
           job_title
    from EMPLOYEES e
    left outer join DEPARTMENTS d
    on e.department_id = d.department_id
    left outer join jobs j
    on e.job_id = j.job_id
    );
    
select * from VIEW_EMP_DEPT_JOB;


-- view �� ����
-- create or replace view �����̸�
create or replace view view_emp_dept_job
as (select E.EMPLOYEE_ID,
        first_name || ' ' || last_name as name,
        department_name,
        job_title,
        salary,
        street_address
    from EMPLOYEES e
    left outer join DEPARTMENTS d
    on E.DEPARTMENT_ID = D.DEPARTMENT_ID
    left outer join jobs j
    on e.job_id = j.job_id
    left outer join locations l
    on D.LOCATION_ID = L.LOCATION_ID
    );
    
select * from VIEW_EMP_DEPT_JOB;

-- ���պ�� �ʿ��� ������ ������ �޴ٸ� �������� ��ȸ�� ����
-- ��
select 
    job_title, 
    avg(salary), 
    sum(salary), 
    count(salary), 
    count(*)
from VIEW_EMP_DEPT_JOB
GROUP by job_title;


-- �����
drop view view_emp;
drop view view_emp_dept_job;

-- ���� DML����
-- view�� insert, update, delete�� �Ͼ�� ��쿡 �������̺� �ݿ�
-- �׸��� ���� ��������� ����.
-- �������̺� Dml��� ��� ��õ
select * from VIEW_EMP_DEPT_JOB;
select * from view_emp;
desc EMPLOYEES;

-- ���պ� DML����
insert into VIEW_EMP_DEPT_JOB VALUES(300,'test','test','test');
-- ��� : SQL ����: ORA-01733: ���� ���� ����� �� �����ϴ�
--       01733. 00000 -  "virtual column not allowed here"
-->> name�� �� ������� ������ ���¸� �����Ͽ� ���� �����̱� ������ insert ������ ���� �ʴ´�.
insert into VIEW_EMP_DEPT_JOB(employee_id, department_name, job_title) 
VALUES(300,'test','test');
-- ��� : SQL ����: ORA-01776: ���� �信 ���Ͽ� �ϳ� �̻��� �⺻ ���̺��� ������ �� �����ϴ�.
--        01776. 00000 -  "cannot modify more than one base table through a join view"
-->> ���� ���̺��ǰ�쿡�� update, insert�� �ȵ˴ϴ�.

-- �ܼ��� DML
desc EMPLOYEES;
insert into VIEW_EMP(employee_id, first_name, salary) 
VALUES(300,'test',10000);
-- ��� : ORA-01400: NULL�� ("HR"."EMPLOYEES"."LAST_NAME") �ȿ� ������ �� �����ϴ�
-- last_name�� not null ���������� �ֱ⶧���� insert ���� ����.

-- ���� �������
-- �ɼ�
-- with check option :  ���� �÷� ���� �������� ���ϰ� �ϴ� �ɼ�
CREATE view view_emp_test
as (select employee_id,
           first_name,
           last_name,
           email,
           hire_date,
           job_id,
           department_id
    from EMPLOYEES 
    where department_id = 60)
with check option;
update VIEW_EMP_TEST set DEPARTMENT_ID = 100;
-- ��� :ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
-- department_id ���� �Ұ�



-- with read only : ���� select�� ����ϴ� �ɼ�
CREATE OR REPLACE VIEW view_emp_test
as (select employee_id,
           first_name,
           last_name,
           email,
           hire_date,
           job_id,
           department_id
    from EMPLOYEES 
    where department_id = 60)
with read only;

update view_emp_test set DEPARTMENT_ID = 100;
-- ��� :  ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
-- ���� select�� �Ҽ� �ֱ� ������ ���� ���� ���� �Ұ�

